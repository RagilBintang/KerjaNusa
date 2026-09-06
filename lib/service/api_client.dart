import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiClient {
  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;
  String? token;

  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:3000',
  );

  Future<List<Map<String, dynamic>>> getJobs() async {
    final response = await _client.get(
      Uri.parse('$baseUrl/jobs'),
      headers: _headers(),
    );
    if (response.statusCode != 200) {
      throw Exception('Gagal memuat lowongan (${response.statusCode}).');
    }
    return List<Map<String, dynamic>>.from(jsonDecode(response.body));
  }

  Map<String, String> _headers() => {
    'Content-Type': 'application/json',
    if (token != null) 'Authorization': 'Bearer $token',
  };

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (response.statusCode != 200)
      throw Exception(_message(response, 'Gagal masuk.'));
    final result = Map<String, dynamic>.from(jsonDecode(response.body));
    token = result['token'] as String;
    return result;
  }

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'role': role,
      }),
    );
    if (response.statusCode != 201)
      throw Exception(_message(response, 'Gagal membuat akun.'));
    final result = Map<String, dynamic>.from(jsonDecode(response.body));
    token = result['token'] as String;
    return result;
  }

  Future<Map<String, dynamic>> getProfile() async {
    final response = await _client.get(
      Uri.parse('$baseUrl/me'),
      headers: _headers(),
    );
    if (response.statusCode != 200)
      throw Exception(_message(response, 'Gagal memuat profil.'));
    return Map<String, dynamic>.from(jsonDecode(response.body));
  }

  Future<Map<String, dynamic>> updateProfile(
    Map<String, dynamic> changes,
  ) async {
    final response = await _client.patch(
      Uri.parse('$baseUrl/me'),
      headers: _headers(),
      body: jsonEncode(changes),
    );
    if (response.statusCode != 200)
      throw Exception(_message(response, 'Gagal menyimpan profil.'));
    return Map<String, dynamic>.from(jsonDecode(response.body));
  }

  Future<List<Map<String, dynamic>>> searchJobs({
    String query = '',
    String location = '',
    String type = '',
  }) async {
    final uri = Uri.parse('$baseUrl/jobs').replace(
      queryParameters: {
        if (query.isNotEmpty) 'q': query,
        if (location.isNotEmpty) 'location': location,
        if (type.isNotEmpty) 'type': type,
      },
    );
    final response = await _client.get(uri, headers: _headers());
    if (response.statusCode != 200)
      throw Exception(_message(response, 'Gagal memuat lowongan.'));
    return List<Map<String, dynamic>>.from(jsonDecode(response.body));
  }

  Future<Map<String, dynamic>> createApplication({
    required String jobId,
    required String jobTitle,
    required String applicantName,
    required String applicantEmail,
  }) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/applications'),
      headers: _headers(),
      body: jsonEncode({
        'jobId': jobId,
        'jobTitle': jobTitle,
        'applicantName': applicantName,
        'applicantEmail': applicantEmail,
      }),
    );
    if (response.statusCode != 201) {
      throw Exception('Gagal mengirim lamaran (${response.statusCode}).');
    }
    return Map<String, dynamic>.from(jsonDecode(response.body));
  }

  Future<Map<String, dynamic>> createJob({
    required String title,
    required String company,
    required String location,
    required String salary,
    required String type,
    required String description,
  }) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/jobs'),
      headers: _headers(),
      body: jsonEncode({
        'title': title,
        'company': company,
        'location': location,
        'salary': salary,
        'type': type,
        'description': description,
      }),
    );
    if (response.statusCode != 201) {
      throw Exception('Gagal menambah lowongan (${response.statusCode}).');
    }
    return Map<String, dynamic>.from(jsonDecode(response.body));
  }

  Future<Map<String, dynamic>> getStats() async {
    final response = await _client.get(
      Uri.parse('$baseUrl/stats'),
      headers: _headers(),
    );
    if (response.statusCode != 200)
      throw Exception(_message(response, 'Gagal memuat statistik.'));
    return Map<String, dynamic>.from(jsonDecode(response.body));
  }

  Future<List<Map<String, dynamic>>> getHrdProfiles({String query = ''}) async {
    final uri = Uri.parse(
      '$baseUrl/hrds',
    ).replace(queryParameters: {if (query.isNotEmpty) 'q': query});
    final response = await _client.get(uri, headers: _headers());
    if (response.statusCode != 200) {
      throw Exception(_message(response, 'Gagal memuat profil HRD.'));
    }
    return List<Map<String, dynamic>>.from(jsonDecode(response.body));
  }

  Future<Map<String, dynamic>> updateApplicationStatus({
    required String id,
    required String status,
  }) async {
    final response = await _client.patch(
      Uri.parse('$baseUrl/applications/$id'),
      headers: _headers(),
      body: jsonEncode({'status': status}),
    );
    if (response.statusCode != 200) {
      throw Exception(_message(response, 'Gagal memperbarui status lamaran.'));
    }
    return Map<String, dynamic>.from(jsonDecode(response.body));
  }

  String _message(http.Response response, String fallback) {
    try {
      return (jsonDecode(response.body) as Map<String, dynamic>)['message']
              as String? ??
          fallback;
    } catch (_) {
      return fallback;
    }
  }

  void dispose() => _client.close();
}
