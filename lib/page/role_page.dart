import 'package:flutter/material.dart';

class RolePage extends StatefulWidget {
  const RolePage({super.key});

  @override
  State<RolePage> createState() => _RolePageState();
}

class _RolePageState extends State<RolePage> {
  // Index kartu yang dipilih: 0 = Pencari Kerja, 1 = Pemilik UMKM
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF7F4), // Background krem halus
      body: SafeArea(
        child: Column(
          children: [
            // === NAVBAR ATAS ===
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo KaryaLokal
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFA64B2A),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(Icons.storefront, color: Colors.white, size: 20),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'KaryaLokal',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFA64B2A),
                        ),
                      ),
                    ],
                  ),
                  // Tombol Bantuan
                  InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Bantuan KaryaLokal tersedia.')),
                      );
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.help_outline, size: 18, color: Colors.black54),
                        SizedBox(width: 6),
                        Text(
                          'Bantuan',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // === KONTEN UTAMA ===
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Judul & Deskripsi Header
                        const Text(
                          'Pilih Peran Anda untuk Memulai',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Kami menyesuaikan pengalaman Anda berdasarkan apakah Anda sedang\nmencari peluang kerja atau ingin mengelola bisnis Anda.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 40),

                        // Kartu Pilihan Role
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // KARTU 1: PENCARI KERJA
                            Expanded(
                              child: _buildRoleCard(
                                index: 0,
                                title: 'Saya Pencari Kerja',
                                description:
                                    'Temukan lowongan pekerjaan terbaik di sekitar Anda, bangun profil profesional, dan lamar dengan mudah.',
                                icon: Icons.work,
                                iconBgColor: const Color(0xFFC8E6C9),
                                iconColor: const Color(0xFF2E6B38),
                                activeColor: const Color(0xFF386633),
                                buttonText: 'Masuk sebagai Pencari Kerja',
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/login',
                                    arguments: 'worker',
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 24),

                            // KARTU 2: PEMILIK UMKM
                            Expanded(
                              child: _buildRoleCard(
                                index: 1,
                                title: 'Saya Pemilik UMKM',
                                description:
                                    'Pasang lowongan, temukan talenta lokal terbaik, dan kelola pelamar untuk mendukung pertumbuhan bisnis Anda.',
                                icon: Icons.storefront,
                                iconBgColor: const Color(0xFFFFE0B2),
                                iconColor: const Color(0xFFA64B2A),
                                activeColor: const Color(0xFFA64B2A),
                                buttonText: 'Masuk sebagai Pemilik Bisnis',
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/login',
                                    arguments: 'hrd',
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // === FOOTER NAVIGATION ===
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sudah punya akun? ',
                    style: TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/login',
                        arguments: 'worker',
                      );
                    },
                    child: const Text(
                      'Masuk di sini',
                      style: TextStyle(
                        color: Color(0xFFA64B2A),
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleCard({
    required int index,
    required String title,
    required String description,
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required Color activeColor,
    required String buttonText,
    required VoidCallback onTap,
  }) {
    final isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(28.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? activeColor : Colors.transparent,
            width: isSelected ? 2.5 : 0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Panas Indikator di Kanan Atas
            Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                height: 20,
                child: isSelected
                    ? Icon(Icons.arrow_forward, color: activeColor, size: 20)
                    : const SizedBox.shrink(),
              ),
            ),
            const SizedBox(height: 8),

            // Icon Lingkaran
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: iconBgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 38, color: iconColor),
            ),
            const SizedBox(height: 24),

            // Title
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),

            // Description
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12.5,
                color: Colors.black54,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 28),

            // Tombol Konfirmasi (Tampil penuh jika kartu aktif)
            SizedBox(
              width: double.infinity,
              height: 42,
              child: isSelected
                  ? ElevatedButton(
                      onPressed: onTap,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: activeColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        buttonText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}