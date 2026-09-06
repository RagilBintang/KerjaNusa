import 'package:flutter/material.dart';
import '../../service/app_feedback.dart';

class ProfilePekerjaPage extends StatefulWidget {
  const ProfilePekerjaPage({super.key});

  @override
  State<ProfilePekerjaPage> createState() => _ProfilePekerjaPageState();
}

class _ProfilePekerjaPageState extends State<ProfilePekerjaPage> {
  // Palet Warna Utama sesuai UI KaryaLokal
  static const Color primaryBrown = Color(0xFF7A3E2D);
  static const Color surfaceCream = Color(0xFFF9F5F1);
  static const Color sidebarBg = Color(0xFFEFE9E3);
  static const Color textDark = Color(0xFF2C221E);
  static const Color textMuted = Color(0xFF7A6E68);
  static const Color badgeGreenBg = Color(0xFFE8F5E9);
  static const Color matchGreen = Color(0xFF2E7D32);
  static const Color borderGrey = Color(0xFFE2D9D0);
  static const Color inputBg = Color(0xFFF3ECE6);
  static const Color cardBg = Colors.white;

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
                            _buildProfileHeaderCard(),
                            const SizedBox(height: 20),
                            _buildCompletenessCard(),
                            const SizedBox(height: 24),
                            _buildMainContentGrid(),
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
          const Text('WORKFORCE WORKSPACE', style: TextStyle(fontSize: 9, color: textMuted, letterSpacing: 1.2)),
          const SizedBox(height: 32),
          _sidebarItem(Icons.dashboard_outlined, 'Dashboard'),
          _sidebarItem(Icons.work_outline, 'Find Jobs'),
          _sidebarItem(Icons.description_outlined, 'Application'),
          _sidebarItem(Icons.person, 'Profile', isActive: true),
          _sidebarItem(Icons.settings_outlined, 'Settings'),
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
                  backgroundColor: primaryBrown,
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
                const Icon(Icons.unfold_more, size: 16, color: textMuted),
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

  // --- HEADER PROFIL & BANNER ---
  Widget _buildProfileHeaderCard() {
    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderGrey),
      ),
      child: Column(
        children: [
          // Banner Cokelat Teratas
          Container(
            height: 110,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              gradient: LinearGradient(
                colors: [Color(0xFF5C2D20), Color(0xFF8C4A36)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 12,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.star_rate_rounded, size: 14, color: Colors.amber),
                        SizedBox(width: 4),
                        Text('Siap Bekerja & Magang (Open to Work)', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Info Diri & Foto
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Transform.translate(
                  offset: const Offset(0, -50),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: borderGrey, width: 2),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text('Budi Santoso', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: textDark)),
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: badgeGreenBg,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              children: const [
                                Icon(Icons.check_circle, size: 12, color: matchGreen),
                                SizedBox(width: 4),
                                Text('Terverifikasi Pekerja Lokal', style: TextStyle(fontSize: 10, color: matchGreen, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: const [
                          Text('Frontend & UI/UX Specialist', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: textDark)),
                          Text('  |  ', style: TextStyle(color: borderGrey)),
                          Text('Lulusan Baru Sistem Informasi', style: TextStyle(fontSize: 13, color: textMuted)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 16,
                        runSpacing: 8,
                        children: const [
                          _IconDetail(Icons.location_on_outlined, 'Bandung, Jawa Barat'),
                          _IconDetail(Icons.email_outlined, 'budi.santoso@example.com'),
                          _IconDetail(Icons.phone_outlined, '+62 812-3456-7890'),
                          _IconDetail(Icons.link_outlined, 'github.com/budisantoso'),
                        ],
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    OutlinedButton.icon(
                      onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Aksi berhasil diproses."))),
                      icon: const Icon(Icons.visibility_outlined, size: 16),
                      label: const Text('Pratinjau CV', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: textDark,
                        side: const BorderSide(color: borderGrey),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton.icon(
                      onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Aksi berhasil diproses."))),
                      icon: const Icon(Icons.edit_outlined, size: 16),
                      label: const Text('Edit Profil', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryBrown,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // --- KARTU KELENGKAPAN PROFIL ---
  Widget _buildCompletenessCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderGrey),
      ),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: const [
              SizedBox(
                width: 52,
                height: 52,
                child: CircularProgressIndicator(
                  value: 0.85,
                  strokeWidth: 5,
                  backgroundColor: inputBg,
                  valueColor: AlwaysStoppedAnimation<Color>(primaryBrown),
                ),
              ),
              Text('85%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: textDark)),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Kelengkapan Profil KaryaLokal', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: textDark)),
                SizedBox(height: 2),
                Text('Lengkapi profil Anda agar peluang dilirik UMKM meningkat hingga 3x lipat!', style: TextStyle(fontSize: 12, color: textMuted)),
              ],
            ),
          ),
          Wrap(
            spacing: 8,
            children: [
              _buildCheckChip('Foto Profil', true),
              _buildCheckChip('Pengalaman', true),
              _buildCheckChip('Portofolio', true),
              _buildCheckChip('+ Tambah Sertifikat', false),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildCheckChip(String label, bool isDone) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isDone ? badgeGreenBg : inputBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isDone ? Icons.check_circle : Icons.add_circle_outline,
            size: 14,
            color: isDone ? matchGreen : primaryBrown,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: isDone ? matchGreen : primaryBrown,
            ),
          ),
        ],
      ),
    );
  }

  // --- GRID UTAMA HALAMAN ---
  Widget _buildMainContentGrid() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Kolom Kiri (Flex 4) - Ringkasan & Keahlian
        Expanded(
          flex: 4,
          child: Column(
            children: [
              _buildRingkasanDiriCard(),
              const SizedBox(height: 20),
              _buildKeahlianCard(),
              const SizedBox(height: 20),
              _buildRingkasanAktivitasCard(),
            ],
          ),
        ),
        const SizedBox(width: 24),
        // Kolom Kanan (Flex 8) - Portofolio, Pendidikan, & Sertifikat
        Expanded(
          flex: 8,
          child: Column(
            children: [
              _buildPortofolioCard(),
              const SizedBox(height: 20),
              _buildPendidikanPengalamanCard(),
              const SizedBox(height: 20),
              _buildSertifikatCard(),
            ],
          ),
        ),
      ],
    );
  }

  // --- RINGKASAN DIRI ---
  Widget _buildRingkasanDiriCard() {
    return _buildCardWrapper(
      title: 'Ringkasan Diri',
      icon: Icons.edit_note,
      actionIcon: Icons.edit_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Dedikasi tinggi dalam mengembangkan antarmuka digital yang ramah pengguna, berdaya guna, dan responsif. Memiliki ketertarikan kuat dalam memajukan ekosistem UMKM lokal di Indonesia melalui sentuhan estetika modern dan sistem desain yang efisien. Terbiasa berkolaborasi dalam tim lincah, beradaptasi cepat, dan berfokus pada solusi praktis.',
            style: TextStyle(fontSize: 12, color: textMuted, height: 1.5),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: surfaceCream, borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                const Icon(Icons.storefront_outlined, size: 20, color: primaryBrown),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Fokus Minat Industri:', style: TextStyle(fontSize: 10, color: textMuted)),
                      Text('UMKM Kuliner, Kerajinan, & Agroteknologi', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: textDark)),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // --- KEAHLIAN ---
  Widget _buildKeahlianCard() {
    return _buildCardWrapper(
      title: 'Keahlian & Kemampuan',
      icon: Icons.psychology_outlined,
      actionText: '+ Tambah',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Teknis & Desain', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: textMuted)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              _buildSkillBadge('Flutter & Dart', true),
              _buildSkillBadge('Figma / UI', true),
              _buildSkillBadge('HTML5 & Tailwind CSS', false),
              _buildSkillBadge('Desain Kemasan', false),
              _buildSkillBadge('Wireframing & Prototyping', false),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Soft Skills & Non-Teknis', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: textMuted)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              _buildSkillBadge('Manajemen Waktu', false),
              _buildSkillBadge('Copywriting Produk', false),
              _buildSkillBadge('Komunikasi Tim Lokal', false),
              _buildSkillBadge('Bekerja Kemitraan', false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkillBadge(String title, bool isHighlighted) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isHighlighted ? primaryBrown.withOpacity(0.1) : inputBg,
        borderRadius: BorderRadius.circular(6),
        border: isHighlighted ? Border.all(color: primaryBrown.withOpacity(0.3)) : null,
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 11,
          fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
          color: isHighlighted ? primaryBrown : textDark,
        ),
      ),
    );
  }

  // --- RINGKASAN AKTIVITAS ---
  Widget _buildRingkasanAktivitasCard() {
    return _buildCardWrapper(
      title: 'Ringkasan Aktivitas',
      icon: Icons.bar_chart_outlined,
      child: Row(
        children: [
          Expanded(child: _buildStatBox('12', 'Lamaran Terkirim')),
          const SizedBox(width: 12),
          Expanded(child: _buildStatBox('4', 'Panggilan Wawancara')),
        ],
      ),
    );
  }

  Widget _buildStatBox(String count, String label) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: surfaceCream,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(count, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: primaryBrown)),
          const SizedBox(height: 2),
          Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 10, color: textMuted)),
        ],
      ),
    );
  }

  // --- PORTOFOLIO PROYEK ---
  Widget _buildPortofolioCard() {
    return _buildCardWrapper(
      title: 'Showcase Portofolio Proyek',
      icon: Icons.folder_special_outlined,
      subtitle: 'Karya IT yang telah dirancang dan dibangun untuk UMKM lokal.',
      actionText: '+ Tambah Karya',
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.95,
        children: [
          _buildPortfolioItem(
            category: 'Web E-commerce',
            title: 'e-Commerce UMKM Kopi Puntang',
            description: 'Membangun toko online berbasis React dan Tailwind untuk petani...',
            image: 'https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?auto=format&fit=crop&w=400&q=80',
            tags: ['ReactJS', 'Lihat Preview'],
          ),
          _buildPortfolioItem(
            category: 'Packaging Branding',
            title: 'Desain Kemasan Keripik Singkong Renyah',
            description: 'Redesain visual packaging standing pouch berstandar retail modern...',
            image: 'https://images.unsplash.com/photo-1527661591475-527312dd65f5?auto=format&fit=crop&w=400&q=80',
            tags: ['Figma', 'Lihat Studi Kasus'],
          ),
          _buildPortfolioItem(
            category: 'Apps Redesign',
            title: 'Redesain Katalog Toko Busana Muslim Hayra',
            description: 'Menyederhanakan alur pemesanan pelanggan hingga 40% lebih cepat...',
            image: 'https://images.unsplash.com/photo-1512496015851-a90fb38ba796?auto=format&fit=crop&w=400&q=80',
            tags: ['Figma', 'Lihat Preview Figma'],
          ),
        ],
      ),
    );
  }

  Widget _buildPortfolioItem({
    required String category,
    required String title,
    required String description,
    required String image,
    required List<String> tags,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(image, height: 120, width: double.infinity, fit: BoxFit.cover),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(color: badgeGreenBg, borderRadius: BorderRadius.circular(4)),
                  child: Text(category, style: const TextStyle(fontSize: 9, color: matchGreen, fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: textDark)),
                const SizedBox(height: 4),
                Text(description, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11, color: textMuted, height: 1.3)),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(tags[0], style: const TextStyle(fontSize: 10, color: textMuted)),
                    Row(
                      children: [
                        Text(tags[1], style: const TextStyle(fontSize: 10, color: primaryBrown, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 2),
                        const Icon(Icons.arrow_outward, size: 12, color: primaryBrown),
                      ],
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // --- PENDIDIKAN & PENGALAMAN ---
  Widget _buildPendidikanPengalamanCard() {
    return _buildCardWrapper(
      title: 'Pendidikan & Pengalaman',
      icon: Icons.history_edu_outlined,
      subtitle: 'Riwayat akademis serta jejak magang / industri kejuruan.',
      child: Column(
        children: [
          _buildTimelineItem(
            title: 'Universitas Komputer Indonesia (UNIKOM)',
            period: '2020 - 2024 (Lulus)',
            description: 'S1 Sistem Informasi (IPK: 3.78 / 4.00)\nFokus pada Manajemen Perangkat Lunak Bisnis & Tata Kelola UMKM. Judul Tugas Akhir: "Pengembangan Prototipe Pasar Bahan Pangan Terstandarisasi untuk Asosiasi UMKM Sentra Kopi Bandung Barat".',
            isGreenDot: true,
          ),
          const SizedBox(height: 16),
          _buildTimelineItem(
            title: 'Frontend Web Intern - PT Digital Kriya Nusantara',
            period: 'Agt 2023 - Des 2023',
            description: 'Magang Bersertifikat Kampus Merdeka\nMengembangkan 5 landing page interaktif berbasis Tailwind CSS untuk onboarding UMKM, mengoptimalkan skor performa Lighthouse dari 68 ke 94.',
            isGreenDot: true,
          ),
          const SizedBox(height: 16),
          _buildTimelineItem(
            title: 'SMKN 1 Cimahi',
            period: '2017 - 2020',
            description: 'Rekayasa Perangkat Lunak (RPL)\nJuara 2 Lomba Keterampilan Siswa (LKS) Web Design Tingkat Kota Bandung Raya.',
            isGreenDot: false,
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({required String title, required String period, required String description, required bool isGreenDot}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 10,
              height: 10,
              margin: const EdgeInsets.only(top: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isGreenDot ? matchGreen : primaryBrown,
              ),
            ),
            Container(width: 1.5, height: 60, color: borderGrey),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: textDark))),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(color: inputBg, borderRadius: BorderRadius.circular(4)),
                    child: Text(period, style: const TextStyle(fontSize: 10, color: textMuted)),
                  )
                ],
              ),
              const SizedBox(height: 4),
              Text(description, style: const TextStyle(fontSize: 11, color: textMuted, height: 1.4)),
            ],
          ),
        )
      ],
    );
  }

  // --- SERTIFIKAT & LISENSI ---
  Widget _buildSertifikatCard() {
    return _buildCardWrapper(
      title: 'Sertifikat & Lisensi',
      icon: Icons.card_membership_outlined,
      subtitle: 'Verifikasi keahlian terstandarisasi industri.',
      actionText: '+ Unggah Sertifikat Baru',
      child: Row(
        children: [
          Expanded(
            child: _buildCertificateTile(
              title: 'Google UX Design Professional Certificate',
              issuer: 'Diterbitkan oleh Google',
              date: 'Tersertifikasi s.d. Des 2026',
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildCertificateTile(
              title: 'Sertifikasi Magang Frontend Developer',
              issuer: 'Kementrian Pendidikan / PT Kriya',
              date: 'Tersertifikasi s.d. Des 2025',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCertificateTile({required String title, required String issuer, required String date}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: surfaceCream,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderGrey),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)),
            child: const Icon(Icons.workspace_premium, color: primaryBrown, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: textDark)),
                const SizedBox(height: 2),
                Text(issuer, style: const TextStyle(fontSize: 10, color: textMuted)),
                Text(date, style: const TextStyle(fontSize: 9, color: matchGreen, fontWeight: FontWeight.w600)),
              ],
            ),
          )
        ],
      ),
    );
  }

  // --- CARD WRAPPER TEMPLATE ---
  Widget _buildCardWrapper({
    required String title,
    required IconData icon,
    required Widget child,
    String? subtitle,
    IconData? actionIcon,
    String? actionText,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, size: 18, color: primaryBrown),
                  const SizedBox(width: 8),
                  Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: textDark)),
                ],
              ),
              if (actionIcon != null)
                Icon(actionIcon, size: 18, color: textMuted)
              else if (actionText != null)
                TextButton(
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Aksi berhasil diproses."))),
                  style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(50, 20)),
                  child: Text(actionText, style: const TextStyle(fontSize: 11, color: primaryBrown, fontWeight: FontWeight.bold)),
                ),
            ],
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 2),
            Text(subtitle, style: const TextStyle(fontSize: 11, color: textMuted)),
          ],
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

// Helper Widget Detail Icon
class _IconDetail extends StatelessWidget {
  final IconData icon;
  final String label;
  const _IconDetail(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: const Color(0xFF7A6E68)),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Color(0xFF7A6E68))),
      ],
    );
  }
}