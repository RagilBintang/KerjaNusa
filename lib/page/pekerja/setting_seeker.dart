import 'package:flutter/material.dart';
import '../../service/app_feedback.dart';

class SettingSeekerPage extends StatefulWidget {
  const SettingSeekerPage({super.key});

  @override
  State<SettingSeekerPage> createState() => _SettingSeekerPageState();
}

class _SettingSeekerPageState extends State<SettingSeekerPage> {
  // Palet Warna Utama sesuai UI KaryaLokal
  static const Color primaryBrown = Color(0xFF7A3E2D);
  static const Color surfaceCream = Color(0xFFF9F5F1);
  static const Color sidebarBg = Color(0xFFEFE9E3);
  static const Color textDark = Color(0xFF2C221E);
  static const Color textMuted = Color(0xFF7A6E68);
  static const Color matchGreen = Color(0xFF4CAF50);
  static const Color badgeGreenBg = Color(0xFFE8F5E9);
  static const Color borderGrey = Color(0xFFE2D9D0);
  static const Color inputBg = Color(0xFFF3ECE6);
  static const Color dangerRed = Color(0xFFC62828);

  // State untuk Switch Notifikasi
  bool _notifLowongan = true;
  bool _notifPesan = true;
  bool _notifRekomendasi = false;

  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: surfaceCream,
      body: Row(
        children: [
          _buildSidebar(),
          Expanded(
            child: Column(
              children: [
                _buildTopHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1280),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildPageHeader(),
                            const SizedBox(height: 20),
                            _buildInternalTabs(),
                            const SizedBox(height: 24),
                            _buildMainLayout(),
                            const SizedBox(height: 32),
                            _buildBottomActions(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- SIDEBAR ---
  Widget _buildSidebar() {
    return Container(
      width: 240,
      color: sidebarBg,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'KaryaLokal',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: primaryBrown),
          ),
          const SizedBox(height: 4),
          const Text('SEEKER WORKSPACE', style: TextStyle(fontSize: 9, color: textMuted, letterSpacing: 1.2)),
          const SizedBox(height: 32),
          _sidebarItem(Icons.dashboard_outlined, 'Dashboard'),
          _sidebarItem(Icons.work_outline, 'Find Jobs'),
          _sidebarItem(Icons.description_outlined, 'Application'),
          _sidebarItem(Icons.person_outline, 'Profile'),
          _sidebarItem(Icons.settings, 'Settings', isActive: true),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 18,
                  backgroundColor: textMuted,
                  child: Icon(Icons.person, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Budi Santoso', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: textDark)),
                      Text('Workforce Member', style: TextStyle(fontSize: 10, color: textMuted)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sidebarItem(IconData icon, String title, {bool isActive = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: isActive ? primaryBrown : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        dense: true,
        leading: Icon(icon, color: isActive ? Colors.white : textMuted, size: 20),
        title: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.white : textMuted,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            fontSize: 14,
          ),
        ),
        onTap: () {
          const routes = {
            'Dashboard': '/pekerja/dashboard',
            'Find Jobs': '/pekerja/find-jobs',
            'Application': '/pekerja/applications',
            'Profile': '/pekerja/profile',
            'Settings': '/pekerja/settings',
          };
          final route = routes[title];
          if (route != null) Navigator.pushReplacementNamed(context, route);
        },
      ),
    );
  }

  // --- TOP HEADER ---
  Widget _buildTopHeader() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      decoration: const BoxDecoration(
        color: surfaceCream,
        border: Border(bottom: BorderSide(color: borderGrey, width: 0.8)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 38,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: borderGrey),
              ),
              child: Row(
                children: const [
                  Icon(Icons.search, color: textMuted, size: 18),
                  SizedBox(width: 8),
                  Text('Search jobs, companies, or keywords...', style: TextStyle(color: textMuted, fontSize: 13)),
                ],
              ),
            ),
          ),
          const SizedBox(width: 20),
          IconButton(icon: const Icon(Icons.notifications_none, color: textDark), onPressed: () => AppFeedback.show('Tidak ada notifikasi baru.')),
          IconButton(icon: const Icon(Icons.bookmark_outline, color: textDark), onPressed: () => AppFeedback.show('Bookmark tersimpan dapat dilihat di sini.')),
          const CircleAvatar(radius: 16, backgroundColor: primaryBrown, child: Icon(Icons.person, color: Colors.white, size: 18)),
        ],
      ),
    );
  }

  // --- PAGE HEADER ---
  Widget _buildPageHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Pengaturan Akun', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: textDark)),
            SizedBox(height: 4),
            Text(
              'Kelola informasi pribadi, keamanan akun, preferensi notifikasi, dan pengaturan privasi\nuntuk memaksimalkan peluang karir lokal Anda.',
              style: TextStyle(fontSize: 13, color: textMuted, height: 1.4),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: borderGrey),
          ),
          child: Row(
            children: const [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Budi Santoso', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: textDark)),
                  Text('100% Profil Lengkap', style: TextStyle(fontSize: 10, color: matchGreen, fontWeight: FontWeight.w600)),
                ],
              ),
              SizedBox(width: 8),
              CircleAvatar(
                radius: 14,
                backgroundColor: primaryBrown,
                child: Icon(Icons.person, size: 16, color: Colors.white),
              )
            ],
          ),
        ),
      ],
    );
  }

  // --- TAB NAVIGASI INTERNAL ---
  Widget _buildInternalTabs() {
    final tabs = [
      {'icon': Icons.person_outline, 'label': 'Akun & Keamanan'},
      {'icon': Icons.work_outline, 'label': 'Preferensi Pekerjaan'},
      {'icon': Icons.notifications_none, 'label': 'Notifikasi'},
      {'icon': Icons.shield_outlined, 'label': 'Privasi & Keamanan'},
    ];

    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: borderGrey, width: 1)),
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          bool isActive = _selectedTab == index;
          return GestureDetector(
            onTap: () => setState(() => _selectedTab = index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: isActive ? Colors.white : Colors.transparent,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                border: isActive
                    ? Border.all(color: borderGrey)
                    : Border.all(color: Colors.transparent),
              ),
              child: Row(
                children: [
                  Icon(
                    tabs[index]['icon'] as IconData,
                    size: 16,
                    color: isActive ? primaryBrown : textMuted,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    tabs[index]['label'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                      color: isActive ? primaryBrown : textMuted,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  // --- MAIN LAYOUT 2 KOLOM ---
  Widget _buildMainLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Kolom Kiri: Form Bento Boxes (Flex 8)
        Expanded(
          flex: 8,
          child: Column(
            children: [
              _buildInformasiDasarCard(),
              const SizedBox(height: 20),
              _buildKeamananSandiCard(),
              const SizedBox(height: 20),
              _buildPreferensiKarirCard(),
              const SizedBox(height: 20),
              _buildNotifikasiCard(),
              const SizedBox(height: 20),
              _buildAreaBahayaCard(),
            ],
          ),
        ),
        const SizedBox(width: 24),
        // Kolom Kanan: Widgets Informasi (Flex 4)
        Expanded(
          flex: 4,
          child: Column(
            children: [
              _buildStatusVerifikasiCard(),
              const SizedBox(height: 20),
              _buildLokakaryaBannerCard(),
              const SizedBox(height: 20),
              _buildTipsPengaturanCard(),
            ],
          ),
        ),
      ],
    );
  }

  // --- HELPER BENTO CONTAINER ---
  Widget _buildBentoCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget child,
    Color titleColor = primaryBrown,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          top: BorderSide(color: titleColor, width: 3),
          left: const BorderSide(color: borderGrey),
          right: const BorderSide(color: borderGrey),
          bottom: const BorderSide(color: borderGrey),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: titleColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(icon, size: 18, color: titleColor),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textDark)),
                  Text(subtitle, style: const TextStyle(fontSize: 11, color: textMuted)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }

  // --- BENTO 1: INFORMASI DASAR ---
  Widget _buildInformasiDasarCard() {
    return _buildBentoCard(
      icon: Icons.person_outline,
      title: 'Informasi Dasar Akun',
      subtitle: 'Data diri utama yang terhubung dengan lamaran kerja Anda.',
      child: Column(
        children: [
          _buildInputField('Nama Lengkap (Sesuai KTP)', 'Budi Santoso'),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildInputField(
                  'Email Terdaftar',
                  'budi.santoso@gmail.com',
                  suffix: const Icon(Icons.lock_outline, size: 16, color: textMuted),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildInputField(
                  'Nomor Handphone',
                  '+62 812 3456 7890',
                  badge: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: badgeGreenBg, borderRadius: BorderRadius.circular(4)),
                    child: const Text('Terverifikasi', style: TextStyle(fontSize: 9, color: matchGreen, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- BENTO 2: KEAMANAN & KATA SANDI ---
  Widget _buildKeamananSandiCard() {
    return _buildBentoCard(
      icon: Icons.lock_outline,
      title: 'Keamanan & Kata Sandi',
      subtitle: 'Perbarui kata sandi berkala untuk menjaga keamanan akun Anda agar tetap aman.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: _buildInputField('Kata Sandi Lama', '••••••••••••', isPassword: true)),
              const SizedBox(width: 12),
              Expanded(child: _buildInputField('Kata Sandi Baru', 'Masukkan S-Sandi', isPassword: true)),
              const SizedBox(width: 12),
              Expanded(child: _buildInputField('Konfirmasi Baru', 'Ulangi Kata Sandi', isPassword: true)),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: surfaceCream, borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: const [
                Icon(Icons.info_outline, size: 16, color: textMuted),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Minimal 8 karakter dengan kombinasi huruf besar, angka, dan simbol untuk memastikan standar keamanan akun pekerjaan Anda.',
                    style: TextStyle(fontSize: 11, color: textMuted, height: 1.3),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // --- BENTO 3: PREFERENSI KARIR ---
  Widget _buildPreferensiKarirCard() {
    return _buildBentoCard(
      icon: Icons.work_outline,
      title: 'Preferensi Karir & Pekerjaan',
      subtitle: 'Penyesuaian rekomendasi dan alokasi pencarian lowongan yang sedang dicari.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Status Ketersediaan', style: TextStyle(fontSize: 11, color: textMuted, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(color: inputBg, borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Siap Magang / Kerja Praktik', style: TextStyle(fontSize: 12, color: textDark, fontWeight: FontWeight.w600)),
                          Icon(Icons.arrow_drop_down, color: textMuted, size: 18),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Ekspektasi Gaji Minimal', style: TextStyle(fontSize: 11, color: textMuted, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(color: inputBg, borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Rp 2.500.000', style: TextStyle(fontSize: 12, color: textDark, fontWeight: FontWeight.w600)),
                          Text('/bulan', style: TextStyle(fontSize: 10, color: textMuted)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Lokasi Kerja Preferensial Penempatan', style: TextStyle(fontSize: 11, color: textMuted, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildChipLocation('Yogyakarta', isSelected: true),
              _buildChipLocation('Solo (Surakarta)', isSelected: true),
              _buildChipLocation('Semarang', isSelected: true),
              _buildChipLocation('+ Tambah Kota', isSelected: false),
            ],
          )
        ],
      ),
    );
  }

  // --- BENTO 4: NOTIFIKASI ---
  Widget _buildNotifikasiCard() {
    return _buildBentoCard(
      icon: Icons.notifications_none,
      title: 'Notifikasi & Komunikasi',
      subtitle: 'Pilih bagaimana Anda ingin menerima pembaruan status lamaran dan komunikasi resmi.',
      child: Column(
        children: [
          _buildSwitchTile(
            title: 'Notifikasi Aplikasi & Status Status',
            subtitle: 'Kirim pemberitahuan saat terdapat pembaruan status lamaran Anda secara real-time.',
            value: _notifLowongan,
            onChanged: (val) => setState(() => _notifLowongan = val),
          ),
          const Divider(height: 24, color: borderGrey),
          _buildSwitchTile(
            title: 'Undangan Wawancara via Email & WhatsApp',
            subtitle: 'Terima pesan/undangan wawancara langsung dari pemilik usaha secara instan.',
            value: _notifPesan,
            onChanged: (val) => setState(() => _notifPesan = val),
          ),
          const Divider(height: 24, color: borderGrey),
          _buildSwitchTile(
            title: 'Rekomendasi Lowongan Mingguan',
            subtitle: 'Daftar lowongan disesuaikan berdasarkan pencarian Anda pengingat kurasi berkala.',
            value: _notifRekomendasi,
            onChanged: (val) => setState(() => _notifRekomendasi = val),
          ),
        ],
      ),
    );
  }

  // --- BENTO 5: AREA BAHAYA ---
  Widget _buildAreaBahayaCard() {
    return _buildBentoCard(
      icon: Icons.warning_amber_rounded,
      title: 'Zona Bahaya / Pengelolaan Data',
      subtitle: 'Tindakan berikut berakibat permanen dan mempengaruhi seluruh profil pencari kerja Anda.',
      titleColor: dangerRed,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Nonaktifkan Akun Sementara', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: textDark)),
                    SizedBox(height: 2),
                    Text('Sembunyikan profil Anda dari pencarian UMKM tanpa menghapus rekam jejak lamaran Anda.', style: TextStyle(fontSize: 11, color: textMuted)),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Aksi berhasil diproses."))),
                style: OutlinedButton.styleFrom(
                  foregroundColor: textDark,
                  side: const BorderSide(color: borderGrey),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
                child: const Text('Nonaktifkan', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
              )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Hapus Akun Permanen', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: dangerRed)),
                    SizedBox(height: 2),
                    Text('Satu kali penghapusan permanen tidak dapat dipulihkan. Seluruh data lamaran & portofolio akan terhapus.', style: TextStyle(fontSize: 11, color: textMuted)),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Aksi berhasil diproses."))),
                style: ElevatedButton.styleFrom(
                  backgroundColor: dangerRed,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                child: const Text('Hapus Akun', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ],
      ),
    );
  }

  // --- RIGHT COLUMN 1: STATUS VERIFIKASI ---
  Widget _buildStatusVerifikasiCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.verified_user_outlined, size: 18, color: primaryBrown),
              SizedBox(width: 8),
              Text('Status Verifikasi', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: textDark)),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Akun Anda telah terverifikasi sebagai tenaga kerja lokal. Lencana Terverifikasi ditampilkan di profil Anda untuk meningkatkan kepercayaan pemilik UMKM.',
            style: TextStyle(fontSize: 11, color: textMuted, height: 1.4),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: badgeGreenBg, borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                const Icon(Icons.check_circle, color: matchGreen, size: 24),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Identitas & KTP', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: textDark)),
                      Text('Terverifikasi oleh Tim Sistem OKP', style: TextStyle(fontSize: 10, color: matchGreen)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Tingkat Kepercayaan:', style: TextStyle(fontSize: 11, color: textMuted)),
              Text('Tinggi (100%)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: matchGreen)),
            ],
          ),
        ],
      ),
    );
  }

  // --- RIGHT COLUMN 2: BANNER LOKAKARYA ---
  Widget _buildLokakaryaBannerCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Stack(
              children: [
                Image.network(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuA0NUrcrw3MsAAXzPNW4UoR2W0VLfVkOcVn6zAEwdL8rpC6itci0oJSKV1dh4qIQA2zTO6rwQpmRoHtFvZTQrVTOHDhgzEIA7HEbcP3OLZdsmDnUQvHneMRXqOvUkxyhsFaXLgTKLvfJVnSer1uydCw1-TsqXbx7BQ0XR1LDSJQYKHfwx3nieYVICGdZdG4Xeuo69KyV6_3Fo9XS-f4Pdqn5LFtpZQNtLuQHA3cXlkV8_BCeq4TuHqyVA',
                  height: 110,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(color: Colors.black.withOpacity(0.7), borderRadius: BorderRadius.circular(4)),
                    child: const Text('Komunitas Pekerja Kreatif', style: TextStyle(fontSize: 9, color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Lokakarya Karir UMKM', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: textDark)),
                const SizedBox(height: 6),
                const Text(
                  'Ikuti sesi pendampingan pembuatan CV dan wawancara eksklusif bersama praktisi UMKM lokal secara gratis setiap hari Selasa.',
                  style: TextStyle(fontSize: 11, color: textMuted, height: 1.4),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Aksi berhasil diproses."))),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: primaryBrown),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('Lihat Jadwal Workshop', style: TextStyle(fontSize: 11, color: primaryBrown, fontWeight: FontWeight.bold)),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_drop_down, size: 16, color: primaryBrown),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // --- RIGHT COLUMN 3: TIPS PENGATURAN ---
  Widget _buildTipsPengaturanCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceCream,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.lightbulb_outline, color: primaryBrown, size: 18),
              SizedBox(width: 8),
              Text('Tips Pengaturan', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: textDark)),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Pastikan nomor WhatsApp aktif untuk menerima tanggapan cepat dari pemilik UMKM. Surat pengantar ringkas dan portofolio sangat membantu memperbesar peluang dipanggil wawancara langsung oleh pemilik usaha.',
            style: TextStyle(fontSize: 11, color: textMuted, height: 1.4),
          ),
          const SizedBox(height: 12),
          Row(
            children: const [
              Icon(Icons.verified, size: 12, color: primaryBrown),
              SizedBox(width: 4),
              Expanded(child: Text('Rekomendasi Profil Lengkap Kriya & Kerajinan', style: TextStyle(fontSize: 10, color: primaryBrown, fontWeight: FontWeight.bold))),
            ],
          )
        ],
      ),
    );
  }

  // --- BOTTOM ACTION BUTTONS ---
  Widget _buildBottomActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OutlinedButton(
          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Aksi berhasil diproses."))),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
            side: const BorderSide(color: borderGrey),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text('Batalkan', style: TextStyle(color: textMuted, fontWeight: FontWeight.bold, fontSize: 13)),
        ),
        const SizedBox(width: 16),
        ElevatedButton(
          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Aksi berhasil diproses."))),
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryBrown,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Row(
            children: const [
              Icon(Icons.save, size: 16),
              SizedBox(width: 8),
              Text('Simpan Perubahan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            ],
          ),
        ),
      ],
    );
  }

  // --- HELPER COMPONENT FORM ---
  Widget _buildInputField(String label, String initialValue, {bool isPassword = false, Widget? suffix, Widget? badge}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontSize: 11, color: textMuted, fontWeight: FontWeight.w500)),
            ?badge,
          ],
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: inputBg,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  initialValue,
                  style: TextStyle(
                    fontSize: 12,
                    color: initialValue.contains('Masukkan') || initialValue.contains('Ulangi') ? textMuted : textDark,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ?suffix,
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChipLocation(String label, {required bool isSelected}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isSelected ? primaryBrown.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isSelected ? primaryBrown : borderGrey),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: TextStyle(fontSize: 11, color: isSelected ? primaryBrown : textMuted, fontWeight: FontWeight.w500)),
          if (isSelected) ...[
            const SizedBox(width: 4),
            const Icon(Icons.close, size: 12, color: primaryBrown),
          ]
        ],
      ),
    );
  }

  Widget _buildSwitchTile({required String title, required String subtitle, required bool value, required ValueChanged<bool> onChanged}) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: textDark)),
              const SizedBox(height: 2),
              Text(subtitle, style: const TextStyle(fontSize: 11, color: textMuted)),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: primaryBrown,
        )
      ],
    );
  }
}