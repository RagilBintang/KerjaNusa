const http = require('http');
const fs = require('fs');
const path = require('path');
const crypto = require('crypto');

const port = Number(process.env.PORT || 3000);
const databasePath = path.join(__dirname, 'db.json');

function readDatabase() {
  return JSON.parse(fs.readFileSync(databasePath, 'utf8'));
}

function writeDatabase(database) {
  fs.writeFileSync(databasePath, `${JSON.stringify(database, null, 2)}\n`);
}

function ensureDatabase(database) {
  database.users ??= [];
  database.sessions ??= [];
  database.applications ??= [];
  database.jobs ??= [];
  return database;
}

function sendJson(response, statusCode, body) {
  response.writeHead(statusCode, {
    'Content-Type': 'application/json; charset=utf-8',
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET,POST,PATCH,DELETE,OPTIONS',
    'Access-Control-Allow-Headers': 'Content-Type',
  });
  response.end(JSON.stringify(body));
}

function publicUser(user) {
  const { password, ...safeUser } = user;
  return safeUser;
}

function passwordHash(password) {
  return crypto.createHash('sha256').update(String(password)).digest('hex');
}

function token() {
  return crypto.randomBytes(32).toString('hex');
}

function authenticatedUser(request, database) {
  const value = request.headers.authorization || '';
  const session = database.sessions.find((item) => item.token === value.replace(/^Bearer\s+/i, ''));
  return session ? database.users.find((user) => user.id === session.userId) : null;
}

function requireUser(request, response, database) {
  const user = authenticatedUser(request, database);
  if (!user) {
    sendJson(response, 401, { message: 'Silakan login terlebih dahulu.' });
    return null;
  }
  return user;
}

function matchesJob(job, url) {
  const query = (url.searchParams.get('q') || '').toLowerCase();
  const location = (url.searchParams.get('location') || '').toLowerCase();
  const type = (url.searchParams.get('type') || '').toLowerCase();
  return job.status === 'Active'
    && (!query || `${job.title} ${job.company} ${job.description}`.toLowerCase().includes(query))
    && (!location || job.location.toLowerCase().includes(location))
    && (!type || job.type.toLowerCase() === type);
}

function readBody(request) {
  return new Promise((resolve, reject) => {
    let body = '';
    request.on('data', (chunk) => { body += chunk; });
    request.on('end', () => {
      try {
        resolve(body ? JSON.parse(body) : {});
      } catch (error) {
        reject(error);
      }
    });
    request.on('error', reject);
  });
}

const server = http.createServer(async (request, response) => {
  if (request.method === 'OPTIONS') {
    sendJson(response, 204, {});
    return;
  }

  const database = ensureDatabase(readDatabase());
  const url = new URL(request.url, `http://${request.headers.host}`);

  try {
    if (request.method === 'GET' && url.pathname === '/health') {
      sendJson(response, 200, { ok: true });
      return;
    }

    if (request.method === 'POST' && url.pathname === '/auth/register') {
      const input = await readBody(request);
      if (!input.name || !input.email || !input.password || !input.role) {
        sendJson(response, 422, { message: 'Nama, email, password, dan role wajib diisi.' });
        return;
      }
      const email = String(input.email).trim().toLowerCase();
      if (database.users.some((user) => user.email === email)) {
        sendJson(response, 409, { message: 'Email sudah terdaftar.' });
        return;
      }
      const user = {
        id: crypto.randomUUID(),
        name: String(input.name).trim(),
        email,
        role: input.role === 'hrd' ? 'hrd' : 'worker',
        phone: input.phone || '',
        bio: input.bio || '',
        skills: Array.isArray(input.skills) ? input.skills : [],
        createdAt: new Date().toISOString(),
        password: passwordHash(input.password),
      };
      database.users.push(user);
      const accessToken = token();
      database.sessions.push({ token: accessToken, userId: user.id, createdAt: new Date().toISOString() });
      writeDatabase(database);
      sendJson(response, 201, { token: accessToken, user: publicUser(user) });
      return;
    }

    if (request.method === 'POST' && url.pathname === '/auth/login') {
      const input = await readBody(request);
      const email = String(input.email || '').trim().toLowerCase();
      const user = database.users.find((item) => item.email === email && item.password === passwordHash(input.password || ''));
      if (!user) {
        sendJson(response, 401, { message: 'Email atau password salah.' });
        return;
      }
      const accessToken = token();
      database.sessions.push({ token: accessToken, userId: user.id, createdAt: new Date().toISOString() });
      writeDatabase(database);
      sendJson(response, 200, { token: accessToken, user: publicUser(user) });
      return;
    }

    if (request.method === 'GET' && url.pathname === '/me') {
      const user = requireUser(request, response, database);
      if (user) sendJson(response, 200, publicUser(user));
      return;
    }

    if (request.method === 'PATCH' && url.pathname === '/me') {
      const user = requireUser(request, response, database);
      if (!user) return;
      const input = await readBody(request);
      for (const field of ['name', 'phone', 'bio', 'avatar']) {
        if (input[field] !== undefined) user[field] = input[field];
      }
      if (Array.isArray(input.skills)) user.skills = input.skills;
      writeDatabase(database);
      sendJson(response, 200, publicUser(user));
      return;
    }

    if (request.method === 'GET' && url.pathname.startsWith('/users/')) {
      const user = database.users.find((item) => item.id === url.pathname.split('/')[2]);
      if (!user) {
        sendJson(response, 404, { message: 'Profil tidak ditemukan.' });
        return;
      }
      sendJson(response, 200, publicUser(user));
      return;
    }

    if (request.method === 'GET' && url.pathname === '/hrds') {
      const query = (url.searchParams.get('q') || '').toLowerCase();
      const hrds = database.users
        .filter((user) => user.role === 'hrd')
        .filter((user) => !query || `${user.name} ${user.bio}`.toLowerCase().includes(query))
        .map(publicUser);
      sendJson(response, 200, hrds);
      return;
    }

    if (request.method === 'GET' && url.pathname === '/jobs') {
      const jobs = database.jobs.filter((job) => matchesJob(job, url));
      sendJson(response, 200, jobs);
      return;
    }

    if (request.method === 'GET' && url.pathname === '/jobs/filters') {
      sendJson(response, 200, {
        locations: [...new Set(database.jobs.map((job) => job.location).filter(Boolean))],
        types: [...new Set(database.jobs.map((job) => job.type).filter(Boolean))],
      });
      return;
    }

    if (request.method === 'POST' && url.pathname === '/jobs') {
      const input = await readBody(request);
      const job = {
        id: String(Date.now()),
        status: 'Active',
        createdAt: new Date().toISOString(),
        ...input,
      };
      const user = authenticatedUser(request, database);
      if (user) job.ownerId = user.id;
      database.jobs.push(job);
      writeDatabase(database);
      sendJson(response, 201, job);
      return;
    }

    if (request.method === 'PATCH' && url.pathname.startsWith('/jobs/')) {
      const job = database.jobs.find((item) => item.id === url.pathname.split('/')[2]);
      if (!job) {
        sendJson(response, 404, { message: 'Lowongan tidak ditemukan.' });
        return;
      }
      Object.assign(job, await readBody(request));
      writeDatabase(database);
      sendJson(response, 200, job);
      return;
    }

    if (request.method === 'DELETE' && url.pathname.startsWith('/jobs/')) {
      const index = database.jobs.findIndex((item) => item.id === url.pathname.split('/')[2]);
      if (index < 0) {
        sendJson(response, 404, { message: 'Lowongan tidak ditemukan.' });
        return;
      }
      database.jobs.splice(index, 1);
      writeDatabase(database);
      sendJson(response, 200, { ok: true });
      return;
    }

    if (request.method === 'GET' && url.pathname === '/applications') {
      sendJson(response, 200, database.applications);
      return;
    }

    if (request.method === 'POST' && url.pathname === '/applications') {
      const input = await readBody(request);
      const user = authenticatedUser(request, database);
      const application = {
        id: String(Date.now()),
        status: 'Pending',
        createdAt: new Date().toISOString(),
        ...input,
      };
      if (user) application.applicantId = user.id;
      database.applications.push(application);
      writeDatabase(database);
      sendJson(response, 201, application);
      return;
    }

    if (request.method === 'PATCH' && url.pathname.startsWith('/applications/')) {
      const application = database.applications.find((item) => item.id === url.pathname.split('/')[2]);
      if (!application) {
        sendJson(response, 404, { message: 'Lamaran tidak ditemukan.' });
        return;
      }
      const input = await readBody(request);
      if (['Pending', 'Reviewed', 'Accepted', 'Rejected'].includes(input.status)) application.status = input.status;
      writeDatabase(database);
      sendJson(response, 200, application);
      return;
    }

    if (request.method === 'GET' && url.pathname === '/stats') {
      sendJson(response, 200, {
        users: database.users.length,
        activeJobs: database.jobs.filter((job) => job.status === 'Active').length,
        applications: database.applications.length,
        pendingApplications: database.applications.filter((item) => item.status === 'Pending').length,
        acceptedApplications: database.applications.filter((item) => item.status === 'Accepted').length,
        generatedAt: new Date().toISOString(),
      });
      return;
    }

    sendJson(response, 404, { message: 'Endpoint tidak ditemukan.' });
  } catch (error) {
    sendJson(response, 400, { message: error.message });
  }
});

server.listen(port, () => {
  console.log(`KaryaLokal API berjalan di http://localhost:${port}`);
});
