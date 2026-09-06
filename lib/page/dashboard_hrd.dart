import 'package:flutter/material.dart';
import '../service/app_feedback.dart';

class DashboardHRD extends StatelessWidget {
  const DashboardHRD({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF6F0),
      body: Row(
        children: [
          // Sidebar Kiri
              _buildSidebar(context),

          // Area Konten Utama
          Expanded(
            child: Column(
              children: [
                // Top Search Bar
                _buildTopBar(context),

                // Konten Utama (Scrollable)
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32.0, vertical: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header Title
                        _buildHeaderTitle(),
                        const SizedBox(height: 24),

                        // Row 3 Stat Cards
                        _buildStatCards(),
                        const SizedBox(height: 24),

                        // Row Recruitment Funnel & Recent Activity
                        _buildFunnelAndActivityRow(),
                        const SizedBox(height: 24),

                        // Active Job Listings Table
                        _buildActiveJobListings(),
                      ],
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

  // Widget Sidebar
  Widget _buildSidebar(BuildContext context) {
    return Container(
      width: 240,
      color: const Color(0xFFFAF6F0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo & Subtitle
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFFA63C2C),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(Icons.storefront,
                    color: Colors.white, size: 20),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'KaryaLokal',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFA63C2C),
                    ),
                  ),
                  Text(
                    'Business Workspace',
                    style: TextStyle(fontSize: 11, color: Colors.black45),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Menu Navigation
          _buildSidebarMenuItem(
            context: context,
            icon: Icons.dashboard,
            title: 'Dashboard',
            isSelected: true,
          ),
            _buildSidebarMenuItem(context: context, icon: Icons.work_outline, title: 'Jobs'),
            _buildSidebarMenuItem(context: context, icon: Icons.people_outline, title: 'Talent'),
          _buildSidebarMenuItem(
              context: context,
              icon: Icons.assignment_outlined, title: 'Applications'),
          _buildSidebarMenuItem(
              context: context,
              icon: Icons.settings_outlined, title: 'Settings'),

          const Spacer(),

          // Button Post a Job
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => AppFeedback.show('Form posting lowongan siap digunakan.'),
              icon: const Icon(Icons.add, color: Colors.white, size: 18),
              label: const Text(
                'Post a Job',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFA63C2C),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarMenuItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    bool isSelected = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isSelected
            ? const Color(0xFFA63C2C).withOpacity(0.08)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: isSelected
            ? const Border(
                left: BorderSide(color: Color(0xFFA63C2C), width: 3),
              )
            : null,
      ),
      child: ListTile(
        dense: true,
        leading: Icon(
          icon,
          color: isSelected ? const Color(0xFFA63C2C) : Colors.black54,
          size: 20,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? const Color(0xFFA63C2C) : Colors.black87,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 14,
          ),
        ),
        onTap: () {
          const routes = {
            'Dashboard': '/hrd/dashboard',
            'Jobs': '/hrd/management',
            'Talent': '/hrd/talent',
            'Applications': '/hrd/applications',
            'Settings': '/hrd/settings',
          };
          final route = routes[title];
          if (route != null) Navigator.pushReplacementNamed(context, route);
        },
      ),
    );
  }

  // Widget Top Navigation Bar
  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
      child: Row(
        children: [
          // Search Input
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black12),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search applications, jobs...',
                  hintStyle: TextStyle(fontSize: 13, color: Colors.black38),
                  prefixIcon:
                      Icon(Icons.search, size: 18, color: Colors.black38),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                ),
              ),
            ),
          ),
          const SizedBox(width: 24),

          // Notification, Help, Profile
          IconButton(
            onPressed: () => AppFeedback.show('Tidak ada notifikasi baru.'),
            icon: const Icon(Icons.notifications_none, color: Colors.black54),
          ),
          IconButton(
            onPressed: () => AppFeedback.show('Pusat bantuan KaryaLokal dibuka.'),
            icon: const Icon(Icons.help_outline, color: Colors.black54),
          ),
          const SizedBox(width: 8),
          const CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage('https://i.pravatar.cc/100'),
          ),
        ],
      ),
    );
  }

  // Header Title Area
  Widget _buildHeaderTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dashboard Bisnis',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF222222),
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Overview of your recruitment activity today.',
              style: TextStyle(fontSize: 13, color: Colors.black45),
            ),
          ],
        ),
        Text(
          'UPDATED TODAY, 09:41 AM',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Colors.black38,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  // Top 3 Cards Stat
  Widget _buildStatCards() {
    return Row(
      children: [
        Expanded(
          child: _buildSingleStatCard(
            title: 'Total Lowongan Aktif',
            value: '12',
            badgeText: '+2 this week',
            badgeColor: const Color(0xFFE2F7E2),
            badgeTextColor: const Color(0xFF2D6A3E),
            icon: Icons.work_outline,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildSingleStatCard(
            title: 'Pelamar Baru',
            value: '48',
            badgeText: 'Requires review',
            badgeColor: const Color(0xFFFFF0EC),
            badgeTextColor: const Color(0xFFA63C2C),
            icon: Icons.person_add_alt,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildSingleStatCard(
            title: 'Total Kunjungan Profil',
            value: '1.2k',
            badgeText: '+14% vs last mo',
            badgeColor: const Color(0xFFE2F7E2),
            badgeTextColor: const Color(0xFF2D6A3E),
            icon: Icons.remove_red_eye_outlined,
          ),
        ),
      ],
    );
  }

  Widget _buildSingleStatCard({
    required String title,
    required String value,
    required String badgeText,
    required Color badgeColor,
    required Color badgeTextColor,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: const Border(
          top: BorderSide(color: Color(0xFFA63C2C), width: 3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(icon, color: Colors.black26, size: 20),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF222222),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: badgeColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  badgeText,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: badgeTextColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Row Funnel & Activity
  Widget _buildFunnelAndActivityRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Recruitment Funnel Card
        Expanded(
          flex: 3,
          child: Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: const Border(
                top: BorderSide(color: Color(0xFFA63C2C), width: 3),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Recruitment Funnel',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF222222),
                      ),
                    ),
                    InkWell(
                      onTap: () => AppFeedback.show('Laporan recruitment dibuka.'),
                      child: Row(
                        children: const [
                          Text(
                            'View Report',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFFA63C2C),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(Icons.chevron_right,
                              size: 16, color: Color(0xFFA63C2C)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildFunnelStep(
                      icon: Icons.badge_outlined,
                      label: 'Pelamar Baru',
                      count: '124',
                      isActive: true,
                    ),
                    _buildFunnelStep(
                      icon: Icons.assignment_outlined,
                      label: 'Ditinjau',
                      count: '45',
                    ),
                    _buildFunnelStep(
                      icon: Icons.forum_outlined,
                      label: 'Wawancara',
                      count: '12',
                    ),
                    _buildFunnelStep(
                      icon: Icons.check_circle_outline,
                      label: 'Diterima',
                      count: '3',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),

        // Recent Activity Card
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: const Border(
                top: BorderSide(color: Color(0xFFA63C2C), width: 3),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Recent Activity',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF222222),
                  ),
                ),
                const SizedBox(height: 20),
                _buildActivityItem(
                  avatarUrl: 'https://i.pravatar.cc/101',
                  name: 'Siti Rahma',
                  action: 'applied for',
                  position: 'Head Barista',
                  time: '2 hours ago',
                ),
                const SizedBox(height: 16),
                _buildActivityItem(
                  avatarUrl: 'https://i.pravatar.cc/102',
                  name: 'Budi Santoso',
                  action: 'applied for',
                  position: 'Admin Toko',
                  time: '5 hours ago',
                ),
                const SizedBox(height: 16),
                _buildActivityItem(
                  icon: Icons.calendar_month,
                  name: 'Interview scheduled with',
                  action: 'Dewi L.',
                  position: 'Store Manager',
                  time: 'Yesterday, 14:00',
                  isEvent: true,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFunnelStep({
    required IconData icon,
    required String label,
    required String count,
    bool isActive = false,
  }) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFFA63C2C) : const Color(0xFFF2EFEA),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: isActive ? Colors.white : Colors.black45,
            size: 22,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          count,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isActive ? const Color(0xFFA63C2C) : const Color(0xFF222222),
          ),
        ),
      ],
    );
  }

  Widget _buildActivityItem({
    String? avatarUrl,
    IconData? icon,
    required String name,
    required String action,
    required String position,
    required String time,
    bool isEvent = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (avatarUrl != null)
          CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage(avatarUrl),
          )
        else
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 18, color: Colors.blue.shade700),
          ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 12, color: Colors.black87),
                  children: [
                    TextSpan(
                      text: '$name ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '$action ',
                      style: const TextStyle(color: Colors.black54),
                    ),
                    if (isEvent)
                      TextSpan(
                        text: position,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                  ],
                ),
              ),
              if (!isEvent)
                Text(
                  position,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              const SizedBox(height: 2),
              Text(
                time,
                style: const TextStyle(fontSize: 11, color: Colors.black38),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Active Job Listings Table Card
  Widget _buildActiveJobListings() {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: const Border(
          top: BorderSide(color: Color(0xFFA63C2C), width: 3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Active Job Listings',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF222222),
                ),
              ),
              OutlinedButton(
                onPressed: () => AppFeedback.show('Daftar lowongan sedang dimuat.'),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.black26),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: const Text(
                  'View All',
                  style: TextStyle(color: Colors.black87, fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Table Header & Rows
          Table(
            columnWidths: const {
              0: FlexColumnWidth(2.5),
              1: FlexColumnWidth(1.2),
              2: FlexColumnWidth(1.2),
              3: FlexColumnWidth(1.5),
              4: FlexColumnWidth(1.0),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black12)),
                ),
                children: [
                  _buildTableHeader('Job Title'),
                  _buildTableHeader('Status'),
                  _buildTableHeader('Applicants'),
                  _buildTableHeader('Posted Date'),
                  _buildTableHeader('Actions', alignRight: true),
                ],
              ),
              _buildTableRow(
                title: 'Head Barista',
                tags: ['FULL-TIME', 'ON-SITE'],
                status: 'Active',
                applicants: '24 total',
                postedDate: 'Oct 12, 2023',
              ),
              _buildTableRow(
                title: 'Admin Toko',
                tags: ['PART-TIME', 'REMOTE'],
                status: 'Active',
                applicants: '8 total',
                postedDate: 'Oct 15, 2023',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader(String text, {bool alignRight = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        text,
        textAlign: alignRight ? TextAlign.right : TextAlign.left,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.black45,
        ),
      ),
    );
  }

  TableRow _buildTableRow({
    required String title,
    required List<String> tags,
    required String status,
    required String applicants,
    required String postedDate,
  }) {
    return TableRow(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12)),
      ),
      children: [
        // Job Title + Tags
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF222222),
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: tags
                    .map(
                      (tag) => Container(
                        margin: const EdgeInsets.only(right: 6),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.04),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          tag,
                          style: const TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),

        // Status
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFE2F7E2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Color(0xFF2D6A3E),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    status,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D6A3E),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        // Applicants
        Text(
          applicants,
          style: const TextStyle(fontSize: 13, color: Colors.black87),
        ),

        // Posted Date
        Text(
          postedDate,
          style: const TextStyle(fontSize: 13, color: Colors.black54),
        ),

        // Action
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: () => AppFeedback.show('Detail lowongan dibuka.'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFA63C2C),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Manage',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}