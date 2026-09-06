import 'package:flutter/material.dart';
import '../service/app_feedback.dart';

class ApplicationsPage extends StatefulWidget {
  const ApplicationsPage({Key? key}) : super(key: key);

  @override
  State<ApplicationsPage> createState() => _ApplicationsPageState();
}

class _ApplicationsPageState extends State<ApplicationsPage> {
  // Palet Warna KaryaLokal
  static const Color primaryBrown = Color(0xFF8C4A36);
  static const Color surfaceCream = Color(0xFFFBF8F5);
  static const Color sidebarBg = Color(0xFFF3ECE6);
  static const Color textDark = Color(0xFF2C221E);
  static const Color textMuted = Color(0xFF8C827A);
  static const Color borderGrey = Color(0xFFEADBCE);
  static const Color cardBg = Colors.white;

  // Status Badge Colors
  static const Color pendingOrangeBg = Color(0xFFFFF3E0);
  static const Color pendingOrangeText = Color(0xFFE65100);

  static const Color reviewedBlueBg = Color(0xFFE3F2FD);
  static const Color reviewedBlueText = Color(0xFF1565C0);

  static const Color interviewedGreenBg = Color(0xFFE8F5E9);
  static const Color interviewedGreenText = Color(0xFF2E7D32);

  int currentPage = 1;

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
                            _buildSummaryCards(),
                            const SizedBox(height: 24),
                            _buildApplicationsTable(),
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
          _sidebarItem(Icons.description_outlined, 'Applications', isActive: true),
          const Spacer(),
          _sidebarItem(Icons.settings_outlined, 'Settings'),
          const SizedBox(height: 12),
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
                  Text('Search applications...', style: TextStyle(color: textMuted, fontSize: 13)),
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

  // --- TITLE HEADER WITH BUTTONS ---
  Widget _buildTitleHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Applications', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: textDark)),
            SizedBox(height: 4),
            Text('Manage and track incoming candidates.', style: TextStyle(fontSize: 13, color: textMuted)),
          ],
        ),
        Row(
          children: [
            OutlinedButton.icon(
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Aksi berhasil diproses."))),
              icon: const Icon(Icons.filter_list, size: 16, color: textDark),
              label: const Text('Filter', style: TextStyle(fontSize: 13, color: textDark, fontWeight: FontWeight.w500)),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(color: borderGrey),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(width: 12),
            OutlinedButton.icon(
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Aksi berhasil diproses."))),
              icon: const Icon(Icons.file_download_outlined, size: 16, color: textDark),
              label: const Text('Export', style: TextStyle(fontSize: 13, color: textDark, fontWeight: FontWeight.w500)),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(color: borderGrey),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ],
        )
      ],
    );
  }

  // --- SUMMARY CARDS ---
  Widget _buildSummaryCards() {
    return Row(
      children: [
        _buildStatCard('TOTAL APPLICATIONS', '142'),
        const SizedBox(width: 20),
        _buildStatCard('PENDING REVIEW', '38'),
        const SizedBox(width: 20),
        _buildStatCard('INTERVIEWS SCHEDULED', '12'),
      ],
    );
  }

  Widget _buildStatCard(String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderGrey),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: textMuted, letterSpacing: 0.5)),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: textDark)),
          ],
        ),
      ),
    );
  }

  // --- APPLICATIONS TABLE ---
  Widget _buildApplicationsTable() {
    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderGrey),
      ),
      child: Column(
        children: [
          // Table Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: borderGrey)),
            ),
            child: Row(
              children: const [
                Expanded(flex: 4, child: Text('APPLICANT NAME', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: textMuted))),
                Expanded(flex: 3, child: Text('JOB APPLIED FOR', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: textMuted))),
                Expanded(flex: 2, child: Text('DATE', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: textMuted))),
                Expanded(flex: 2, child: Text('STATUS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: textMuted))),
                SizedBox(width: 40, child: Align(alignment: Alignment.centerRight, child: Text('ACTION', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: textMuted)))),
              ],
            ),
          ),

          // Rows
          _buildApplicantRow(
            name: 'Budi Santoso',
            email: 'budi.s@example.com',
            jobTitle: 'Senior Carpenter',
            department: 'Workshop A',
            date: 'Oct 24, 2023',
            status: 'Pending',
            avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=150&q=80',
          ),
          _buildApplicantRow(
            name: 'Siti Aminah',
            email: 'siti.a@example.com',
            jobTitle: 'Batik Designer',
            department: 'Creative Studio',
            date: 'Oct 23, 2023',
            status: 'Reviewed',
            initials: 'SA',
          ),
          _buildApplicantRow(
            name: 'Agus Wijaya',
            email: 'agus.w@example.com',
            jobTitle: 'Master Weaver',
            department: 'Production Floor',
            date: 'Oct 21, 2023',
            status: 'Interviewed',
            avatarUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=150&q=80',
          ),
          _buildApplicantRow(
            name: 'Rina Kurniawati',
            email: 'rina.k@example.com',
            jobTitle: 'Store Manager',
            department: 'Retail Front',
            date: 'Oct 20, 2023',
            status: 'Pending',
            initials: 'RK',
          ),

          // Pagination Footer
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: borderGrey)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Showing 1 to 4 of 142 results', style: TextStyle(fontSize: 12, color: textMuted)),
                Row(
                  children: [
                    _buildPaginationButton('Previous', isEnabled: false),
                    const SizedBox(width: 4),
                    _buildPageNumberButton(1, isActive: currentPage == 1),
                    _buildPageNumberButton(2, isActive: currentPage == 2),
                    _buildPageNumberButton(3, isActive: currentPage == 3),
                    const SizedBox(width: 4),
                    _buildPaginationButton('Next', isEnabled: true),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildApplicantRow({
    required String name,
    required String email,
    required String jobTitle,
    required String department,
    required String date,
    required String status,
    String? avatarUrl,
    String? initials,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: borderGrey, width: 0.5)),
      ),
      child: Row(
        children: [
          // Applicant Name & Avatar
          Expanded(
            flex: 4,
            child: Row(
              children: [
                avatarUrl != null
                    ? CircleAvatar(
                        radius: 18,
                        backgroundImage: NetworkImage(avatarUrl),
                      )
                    : CircleAvatar(
                        radius: 18,
                        backgroundColor: borderGrey,
                        child: Text(initials ?? '', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: textDark)),
                      ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: textDark)),
                    const SizedBox(height: 2),
                    Text(email, style: const TextStyle(fontSize: 11, color: textMuted)),
                  ],
                ),
              ],
            ),
          ),

          // Job Applied For
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(jobTitle, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: textDark)),
                const SizedBox(height: 2),
                Text(department, style: const TextStyle(fontSize: 11, color: textMuted)),
              ],
            ),
          ),

          // Date
          Expanded(
            flex: 2,
            child: Text(date, style: const TextStyle(fontSize: 12, color: textDark)),
          ),

          // Status Badge
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: _buildStatusBadge(status),
            ),
          ),

          // Action Menu
          SizedBox(
            width: 40,
            child: IconButton(
              icon: const Icon(Icons.more_vert, size: 18, color: textMuted),
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Aksi berhasil diproses."))),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color bg;
    Color text;

    switch (status) {
      case 'Pending':
        bg = pendingOrangeBg;
        text = pendingOrangeText;
        break;
      case 'Reviewed':
        bg = reviewedBlueBg;
        text = reviewedBlueText;
        break;
      case 'Interviewed':
        bg = interviewedGreenBg;
        text = interviewedGreenText;
        break;
      default:
        bg = borderGrey;
        text = textDark;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: text),
      ),
    );
  }

  // --- PAGINATION WIDGETS ---
  Widget _buildPaginationButton(String label, {required bool isEnabled}) {
    return OutlinedButton(
      onPressed: isEnabled ? () {} : null,
      style: OutlinedButton.styleFrom(
        foregroundColor: isEnabled ? textDark : textMuted,
        side: const BorderSide(color: borderGrey),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      child: Text(label, style: const TextStyle(fontSize: 11)),
    );
  }

  Widget _buildPageNumberButton(int page, {required bool isActive}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      child: InkWell(
        onTap: () {
          setState(() {
            currentPage = page;
          });
        },
        borderRadius: BorderRadius.circular(6),
        child: Container(
          width: 32,
          height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActive ? primaryBrown : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: isActive ? primaryBrown : borderGrey),
          ),
          child: Text(
            '$page',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isActive ? Colors.white : textDark,
            ),
          ),
        ),
      ),
    );
  }
}