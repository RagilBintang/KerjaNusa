import 'package:flutter/material.dart';

class DashborPekerjaPage extends StatefulWidget {
  const DashborPekerjaPage({super.key});

  @override
  State<DashborPekerjaPage> createState() => _DashborPekerjaPageState();
}

class _DashborPekerjaPageState extends State<DashborPekerjaPage> {
  int _selectedNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F0),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 900;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === SIDEBAR KIRI (Sembunyikan di Mobile jika perlu) ===
              if (!isMobile) _buildSidebar(),

              // === AREA UTAMA / CONTENT ===
              Expanded(
                child: Column(
                  children: [
                    _buildTopBar(isMobile: isMobile),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 16.0 : 28.0,
                          vertical: 20.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildHeaderBanner(isMobile: isMobile),
                            const SizedBox(height: 20),

                            // Grid Layout utama
                            if (isMobile) ...[
                              _buildMainContentColumn(),
                              const SizedBox(height: 20),
                              _buildSideContentColumn(),
                            ] else ...[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(flex: 7, child: _buildMainContentColumn()),
                                  const SizedBox(width: 20),
                                  Expanded(flex: 3, child: _buildSideContentColumn()),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      drawer: MediaQuery.of(context).size.width < 900 ? Drawer(child: _buildSidebar()) : null,
    );
  }

  // --- KOMPONEN UTAMA ---

  Widget _buildMainContentColumn() {
    return Column(
      children: [
        _buildStatCards(),
        const SizedBox(height: 20),
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 500) {
              return Column(
                children: [
                  _buildApplicationStatusCard(),
                  const SizedBox(height: 16),
                  _buildActivityOverviewCard(),
                ],
              );
            }
            return Row(
              children: [
                Expanded(child: _buildApplicationStatusCard()),
                const SizedBox(width: 16),
                Expanded(child: _buildActivityOverviewCard()),
              ],
            );
          },
        ),
        const SizedBox(height: 20),
        _buildUpcomingInterviewsCard(),
        const SizedBox(height: 20),
        _buildRecentApplicationsCard(),
      ],
    );
  }

  Widget _buildSideContentColumn() {
    return Column(
      children: [
        _buildRekomendasiCard(),
        const SizedBox(height: 20),
        _buildTipsUmkmCard(),
      ],
    );
  }

  // --- WIDGET BUILDERS ---

  Widget _buildSidebar() {
    return Container(
      width: 220,
      color: const Color(0xFFEFE8DE),
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFFA64B2A),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(Icons.storefront, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 8),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('KaryaLokal', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFFA64B2A))),
                  Text('Worker Workspace', style: TextStyle(fontSize: 10, color: Colors.black45)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),
          _buildNavItem(0, Icons.dashboard_outlined, 'Dashboard'),
          _buildNavItem(1, Icons.search_outlined, 'Find Jobs'),
          _buildNavItem(2, Icons.description_outlined, 'Application'),
          _buildNavItem(3, Icons.person_outline, 'Profile'),
          _buildNavItem(4, Icons.settings_outlined, 'Settings'),
          const Spacer(),
          _buildCvCard(),
          const SizedBox(height: 16),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Bantuan', style: TextStyle(fontSize: 11, color: Colors.black54)),
              Text('v1.0', style: TextStyle(fontSize: 11, color: Colors.black38)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _selectedNavIndex == index;
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: InkWell(
        onTap: () => setState(() => _selectedNavIndex = index),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFA64B2A) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(icon, size: 18, color: isSelected ? Colors.white : Colors.black54),
              const SizedBox(width: 12),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar({required bool isMobile}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 28, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.black12, width: 0.8)),
      ),
      child: Row(
        children: [
          if (isMobile)
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
          Expanded(
            child: SizedBox(
              height: 38,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search jobs, skills...',
                  hintStyle: const TextStyle(fontSize: 12, color: Colors.black38),
                  prefixIcon: const Icon(Icons.search, size: 18, color: Colors.black38),
                  fillColor: const Color(0xFFF5F5F5),
                  filled: true,
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined, size: 20, color: Colors.black54),
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Aksi berhasil diproses."))),
          ),
          const CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage('https://i.pravatar.cc/100?img=47'),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderBanner({required bool isMobile}) {
    final bannerInfo = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Text('Welcome back, Sarah ', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)),
            Text('👋', style: TextStyle(fontSize: 20)),
          ],
        ),
        const SizedBox(height: 4),
        const Text(
          'Pantau perkembangan lamaran kerja dan jadwal wawancara minggu ini.',
          style: TextStyle(fontSize: 12, color: Colors.black54),
        ),
      ],
    );

    final completenessCard = Container(
      width: isMobile ? double.infinity : 260,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.shield_outlined, size: 16, color: Color(0xFFA64B2A)),
                  SizedBox(width: 6),
                  Text('Kelengkapan Profil', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                ],
              ),
              Text('85%', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFFA64B2A))),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: const LinearProgressIndicator(
              value: 0.85,
              backgroundColor: Color(0xFFE8E8E8),
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFA64B2A)),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            '+ Tambahkan sertifikasi agar dilirik UMKM',
            style: TextStyle(fontSize: 10, color: Colors.black54),
          ),
        ],
      ),
    );

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          bannerInfo,
          const SizedBox(height: 12),
          completenessCard,
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        bannerInfo,
        completenessCard,
      ],
    );
  }

  Widget _buildStatCards() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 600;
        return GridView.count(
          crossAxisCount: isNarrow ? 2 : 4,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: isNarrow ? 2.2 : 1.8,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _buildStatItem('APPLIED', '12', Icons.description_outlined),
            _buildStatItem('VIEWED BY HRD', '8', Icons.visibility_outlined),
            _buildStatItem('INTERVIEWS', '3', Icons.chat_bubble_outline),
            _buildStatItem('ACCEPTED', '1', Icons.check_circle_outline),
          ],
        );
      },
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: Colors.black45),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.black45),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildApplicationStatusCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Application Status', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Center(
            child: SizedBox(
              height: 100,
              width: 100,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator(
                      value: 0.7,
                      strokeWidth: 10,
                      backgroundColor: Colors.brown.shade100,
                      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFA64B2A)),
                    ),
                  ),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('24', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('Total', style: TextStyle(fontSize: 10, color: Colors.black45)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityOverviewCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Activity Overview', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildActivityRow(Colors.orangeAccent, 'Dikirim (Applied)', '50%'),
          _buildActivityRow(Colors.brown.shade300, 'Dilihat (Viewed)', '33%'),
          _buildActivityRow(Colors.brown, 'Wawancara (Interview)', '12%'),
          _buildActivityRow(Colors.green, 'Diterima (Accepted)', '4%'),
        ],
      ),
    );
  }

  Widget _buildActivityRow(Color dotColor, String title, String percentage) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(width: 8, height: 8, decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle)),
              const SizedBox(width: 8),
              Text(title, style: const TextStyle(fontSize: 11, color: Colors.black87)),
            ],
          ),
          Text(percentage, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black54)),
        ],
      ),
    );
  }

  Widget _buildUpcomingInterviewsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.calendar_today_outlined, size: 16, color: Color(0xFFA64B2A)),
                  SizedBox(width: 8),
                  Text('Jadwal Wawancara Mendatang', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                ],
              ),
              Text('2 Terjadwal', style: TextStyle(fontSize: 11, color: Colors.black45)),
            ],
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 550) {
                return Column(
                  children: [
                    _buildInterviewItem(
                      tag: 'Wawancara Online',
                      title: 'Frontend Developer',
                      subTitle: 'Maju Tech x HR & User Interview',
                      time: 'Kamis, 10.00 - 10.45 WIB',
                      iconText: 'M',
                      isJoinable: true,
                    ),
                    const SizedBox(height: 12),
                    _buildInterviewItem(
                      tag: 'Tugas/Design Test',
                      title: 'UI/UX Designer',
                      subTitle: 'Kreatif Studio x Design Challenge',
                      time: 'Kamis, 14.00 x 16.00 WIB',
                      iconText: 'K',
                      isJoinable: false,
                    ),
                  ],
                );
              }
              return Row(
                children: [
                  Expanded(
                    child: _buildInterviewItem(
                      tag: 'Wawancara Online',
                      title: 'Frontend Developer',
                      subTitle: 'Maju Tech x HR & User Interview',
                      time: 'Kamis, 10.00 - 10.45 WIB',
                      iconText: 'M',
                      isJoinable: true,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildInterviewItem(
                      tag: 'Tugas/Design Test',
                      title: 'UI/UX Designer',
                      subTitle: 'Kreatif Studio x Design Challenge',
                      time: 'Kamis, 14.00 x 16.00 WIB',
                      iconText: 'K',
                      isJoinable: false,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInterviewItem({
    required String tag,
    required String title,
    required String subTitle,
    required String time,
    required String iconText,
    required bool isJoinable,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF7F2),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: Colors.brown.shade100, borderRadius: BorderRadius.circular(4)),
                child: Text(tag, style: const TextStyle(fontSize: 9, color: Color(0xFFA64B2A), fontWeight: FontWeight.bold)),
              ),
              CircleAvatar(radius: 12, backgroundColor: Colors.brown.shade200, child: Text(iconText, style: const TextStyle(fontSize: 10, color: Colors.white))),
            ],
          ),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          Text(subTitle, style: const TextStyle(fontSize: 10, color: Colors.black54)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.access_time, size: 12, color: Colors.black45),
                  const SizedBox(width: 4),
                  Text(time, style: const TextStyle(fontSize: 9, color: Colors.black54)),
                ],
              ),
              SizedBox(
                height: 26,
                child: ElevatedButton(
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Aksi berhasil diproses."))),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isJoinable ? const Color(0xFFA64B2A) : Colors.white,
                    side: isJoinable ? BorderSide.none : const BorderSide(color: Colors.black26),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  ),
                  child: Text(
                    isJoinable ? 'Join Meet' : 'Detail Tes',
                    style: TextStyle(fontSize: 10, color: isJoinable ? Colors.white : Colors.black87, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentApplicationsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8)],
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.history, size: 16, color: Color(0xFFA64B2A)),
                  SizedBox(width: 8),
                  Text('Recent Applications', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                ],
              ),
              Text('Total: 12 Lamaran', style: TextStyle(fontSize: 11, color: Colors.black45)),
            ],
          ),
          const SizedBox(height: 12),
          _buildApplicationRow('MT', 'Frontend Developer', 'Maju Team', 'Jakarta Selatan', '18 Okt 2026', 'Wawancara', Colors.blue.shade100, Colors.blue.shade800),
          _buildApplicationRow('KS', 'UI/UX Designer', 'Kreatif Studio', 'Bandung', '17 Okt 2026', 'Dilihat', Colors.orange.shade100, Colors.orange.shade800),
          _buildApplicationRow('LM', 'Store Supervisor', 'LokalMart', 'Yogyakarta', '12 Okt 2026', 'Review', Colors.brown.shade100, Colors.brown.shade800),
        ],
      ),
    );
  }

  Widget _buildApplicationRow(
    String avatarText,
    String role,
    String company,
    String location,
    String date,
    String status,
    Color statusBg,
    Color statusTextColor,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(radius: 14, backgroundColor: Colors.brown.shade100, child: Text(avatarText, style: const TextStyle(fontSize: 10, color: Color(0xFFA64B2A), fontWeight: FontWeight.bold))),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(role, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
                Text('$company • $location', style: const TextStyle(fontSize: 10, color: Colors.black45), overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: statusBg, borderRadius: BorderRadius.circular(12)),
            child: Text(status, style: TextStyle(fontSize: 9, color: statusTextColor, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildRekomendasiCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Rekomendasi Untukmu', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
              Icon(Icons.tune, size: 16, color: Colors.black45),
            ],
          ),
          const SizedBox(height: 16),
          _buildJobCard('Senior React Developer', 'Tembakau Nusantara • Jakarta', 'Rp 9.000.000 - Rp 14.000.000', 'Fulltime', 'Hybrid', 'Match 95%'),
          const SizedBox(height: 12),
          _buildJobCard('Product Designer (UI/UX)', 'Nusantara Kreasi • Bandung', 'Rp 7.000.000 - Rp 11.000.000', 'Hybrid', 'Fulltime', 'Match 88%'),
        ],
      ),
    );
  }

  Widget _buildJobCard(String title, String company, String salary, String tag1, String tag2, String match) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF7F2),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis)),
              const Icon(Icons.bookmark_border, size: 16, color: Colors.black45),
            ],
          ),
          Text(company, style: const TextStyle(fontSize: 10, color: Colors.black54)),
          const SizedBox(height: 6),
          Text(salary, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black87)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: [
              _buildSmallChip(tag1, Colors.grey.shade200, Colors.black87),
              _buildSmallChip(tag2, Colors.grey.shade200, Colors.black87),
              _buildSmallChip(match, Colors.green.shade100, Colors.green.shade800),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 30,
            child: ElevatedButton(
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Aksi berhasil diproses."))),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFA64B2A),
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              ),
              child: const Text('Lamar Sekarang', style: TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallChip(String label, Color bg, Color text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(4)),
      child: Text(label, style: TextStyle(fontSize: 8, color: text, fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildTipsUmkmCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7ED),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.lightbulb_outline, size: 16, color: Colors.orange),
              SizedBox(width: 6),
              Text('Tips Kerja UMKM', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            'Pelajari penulisan portofolio nyata dan etika wawancara kerja untuk usaha lokal Indonesia.',
            style: TextStyle(fontSize: 10, color: Colors.black54, height: 1.4),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Aksi berhasil diproses."))),
            child: const Text('Baca Panduan ->', style: TextStyle(fontSize: 10, color: Color(0xFFA64B2A), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildCvCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.badge_outlined, size: 14, color: Color(0xFFA64B2A)),
              SizedBox(width: 4),
              Text('CV / Resume', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Perbarui profil dan CV Anda agar mudah ditemukan HRD UMKM.',
            style: TextStyle(fontSize: 10, color: Colors.black54),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 30,
            child: ElevatedButton(
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Aksi berhasil diproses."))),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFA64B2A),
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              ),
              child: const Text('Upload CV', style: TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}