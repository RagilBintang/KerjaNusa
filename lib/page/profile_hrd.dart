import 'package:flutter/material.dart';
import '../service/app_feedback.dart';

class ProfileHrdPage extends StatefulWidget {
  const ProfileHrdPage({super.key});

  @override
  State<ProfileHrdPage> createState() => _ProfileHrdPageState();
}

class _ProfileHrdPageState extends State<ProfileHrdPage> {
  // Palet Warna KaryaLokal
  static const Color primaryBrown = Color(0xFF8C4A36);
  static const Color surfaceCream = Color(0xFFFBF8F5);
  static const Color sidebarBg = Color(0xFFF3ECE6);
  static const Color textDark = Color(0xFF2C221E);
  static const Color textMuted = Color(0xFF8C827A);
  static const Color badgeGreenBg = Color(0xFFE8F5E9);
  static const Color matchGreen = Color(0xFF2E7D32);
  static const Color borderGrey = Color(0xFFEADBCE);
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
                    padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 28.0),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1200),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTitleHeader(),
                            const SizedBox(height: 24),
                            _buildMainGrid(),
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
          const SizedBox(height: 2),
          const Text('Business Workspace', style: TextStyle(fontSize: 10, color: textMuted, letterSpacing: 0.8)),
          const SizedBox(height: 32),
          _sidebarItem(Icons.dashboard_outlined, 'Dashboard'),
          _sidebarItem(Icons.work_outline, 'Jobs'),
          _sidebarItem(Icons.groups_outlined, 'Talent'),
          _sidebarItem(Icons.description_outlined, 'Applications'),
          _sidebarItem(Icons.timeline, 'Tracking'),
          _sidebarItem(Icons.settings_outlined, 'Settings'),
          _sidebarItem(Icons.person_outline, 'Profile', isActive: true),
          const Spacer(),
          ElevatedButton.icon(
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Aksi berhasil diproses."))),
            icon: const Icon(Icons.add, size: 18),
            label: const Text('+ Post a Job', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryBrown,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 44),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              elevation: 0,
            ),
          )
        ],
      ),
    );
  }

  Widget _sidebarItem(IconData icon, String title, {bool isActive = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: isActive ? primaryBrown.withOpacity(0.12) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        dense: true,
        leading: Icon(icon, color: isActive ? primaryBrown : textMuted, size: 20),
        title: Text(
          title,
          style: TextStyle(
            color: isActive ? primaryBrown : textMuted,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            fontSize: 14,
          ),
        ),
        onTap: () {
          const routes = {
            'Dashboard': '/hrd/dashboard',
            'Jobs': '/hrd/management',
            'Talent': '/hrd/talent',
            'Applications': '/hrd/applications',
            'Tracking': '/hrd/tracking',
            'Profile': '/hrd/profile',
            'Settings': '/hrd/settings',
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
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 36),
      decoration: const BoxDecoration(
        color: surfaceCream,
        border: Border(bottom: BorderSide(color: borderGrey, width: 1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 40,
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
                  Text('Search applications, jobs...', style: TextStyle(color: textMuted, fontSize: 13)),
                ],
              ),
            ),
          ),
          const SizedBox(width: 20),
          IconButton(icon: const Icon(Icons.notifications_none, color: textDark), onPressed: () => AppFeedback.show('Tidak ada notifikasi baru.')),
          IconButton(icon: const Icon(Icons.help_outline, color: textDark), onPressed: () => AppFeedback.show('Pusat bantuan KaryaLokal dibuka.')),
          const SizedBox(width: 8),
          const CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage('https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=150&q=80'),
          ),
        ],
      ),
    );
  }

  // --- HEADER JUDUL HALAMAN ---
  Widget _buildTitleHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Business Profile', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: textDark)),
            SizedBox(height: 4),
            Text('Manage your public presence and active listings.', style: TextStyle(fontSize: 13, color: textMuted)),
          ],
        ),
        OutlinedButton(
          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Aksi berhasil diproses."))),
          style: OutlinedButton.styleFrom(
            foregroundColor: primaryBrown,
            side: const BorderSide(color: primaryBrown),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text('Edit Profile', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        ),
      ],
    );
  }

  // --- GRID UTAMA HALAMAN ---
  Widget _buildMainGrid() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Kolom Kiri: Profil Bisnis & Lokasi (Flex 7)
        Expanded(
          flex: 7,
          child: Column(
            children: [
              _buildBusinessCard(),
              const SizedBox(height: 24),
              _buildLocationCard(),
            ],
          ),
        ),
        const SizedBox(width: 24),
        // Kolom Kanan: Primary Contact & Active Jobs (Flex 4)
        Expanded(
          flex: 4,
          child: Column(
            children: [
              _buildPrimaryContactCard(),
              const SizedBox(height: 24),
              _buildActiveJobsCard(),
            ],
          ),
        ),
      ],
    );
  }

  // --- KARTU PROFIL BISNIS ---
  Widget _buildBusinessCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 72,
                height: 72,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: surfaceCream,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: borderGrey),
                ),
                child: Image.network(
                  'https://cdn-icons-png.flaticon.com/512/3081/3081061.png',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Warung Makan\nBudi', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textDark, height: 1.2)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: badgeGreenBg,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text('Active Profile', style: TextStyle(fontSize: 11, color: matchGreen, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Text('Culinary & Hospitality', style: TextStyle(fontSize: 12, color: primaryBrown, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Established in 2015, Warung Makan Budi is a beloved local eatery known for serving authentic, home-style Indonesian cuisine. We pride ourselves on using fresh, locally sourced ingredients to create comforting dishes that bring the community together.',
            style: TextStyle(fontSize: 12, color: textMuted, height: 1.5),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildTagChip(Icons.verified, 'Verified Business'),
              const SizedBox(width: 12),
              _buildTagChip(Icons.people_outline, '10-50 Employees'),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTagChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: surfaceCream,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: borderGrey),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: textMuted),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontSize: 11, color: textDark, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  // --- KARTU LOKASI ---
  Widget _buildLocationCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Location', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textDark)),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Icon(Icons.location_on_outlined, size: 18, color: primaryBrown),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Jl. Sudirman No. 45\nKecamatan Gondokusuman\nYogyakarta, 55224\nIndonesia',
                            style: TextStyle(fontSize: 12, color: textMuted, height: 1.5),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Aksi berhasil diproses."))),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text('Get Directions', style: TextStyle(fontSize: 12, color: primaryBrown, fontWeight: FontWeight.bold)),
                          SizedBox(width: 4),
                          Icon(Icons.open_in_new, size: 12, color: primaryBrown),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // Visual Peta Mockup
              Expanded(
                flex: 6,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1526778548025-fa2f459cd5c1?auto=format&fit=crop&w=500&q=80',
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- KARTU PRIMARY CONTACT (PIC) ---
  Widget _buildPrimaryContactCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Primary Contact (PIC)', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: textDark)),
          const SizedBox(height: 16),
          Row(
            children: [
              const CircleAvatar(
                radius: 22,
                backgroundImage: NetworkImage('https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=150&q=80'),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Budi Santoso', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: textDark)),
                  SizedBox(height: 2),
                  Text('Owner & Manager', style: TextStyle(fontSize: 11, color: textMuted)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: surfaceCream,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: const [
                Icon(Icons.email_outlined, size: 16, color: primaryBrown),
                SizedBox(width: 10),
                Text('budi@warungbudi.id', style: TextStyle(fontSize: 12, color: textDark)),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: surfaceCream,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: const [
                Icon(Icons.phone_outlined, size: 16, color: primaryBrown),
                SizedBox(width: 10),
                Text('+62 812 3456 7890', style: TextStyle(fontSize: 12, color: textDark)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- KARTU ACTIVE JOBS ---
  Widget _buildActiveJobsCard() {
    return Container(
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
              const Text('Active Jobs', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: textDark)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: primaryBrown.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text('2 Postings', style: TextStyle(fontSize: 10, color: primaryBrown, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildJobPostingItem('Head Chef', 'Full-time', 'Rp 4M - 6M'),
          const SizedBox(height: 12),
          _buildJobPostingItem('Waitstaff', 'Part-time', 'Rp 1.5M - 2M'),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Aksi berhasil diproses."))),
              style: OutlinedButton.styleFrom(
                foregroundColor: primaryBrown,
                side: const BorderSide(color: primaryBrown),
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('View All Postings', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildJobPostingItem(String title, String type, String salary) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: surfaceCream,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: textDark)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: badgeGreenBg,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text('ACTIVE', style: TextStyle(fontSize: 9, color: matchGreen, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text('$type • $salary', style: const TextStyle(fontSize: 11, color: textMuted)),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Aksi berhasil diproses."))),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryBrown,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 6),
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              ),
              child: const Text('Manage', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
    );
  }
}