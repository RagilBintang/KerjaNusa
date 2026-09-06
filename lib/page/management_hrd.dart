import 'package:flutter/material.dart';
import '../service/app_feedback.dart';

class JobManagementPage extends StatefulWidget {
  const JobManagementPage({Key? key}) : super(key: key);

  @override
  State<JobManagementPage> createState() => _JobManagementPageState();
}

class _JobManagementPageState extends State<JobManagementPage> {
  // Palet Warna KaryaLokal
  static const Color primaryBrown = Color(0xFF8C4A36);
  static const Color surfaceCream = Color(0xFFFBF8F5);
  static const Color sidebarBg = Color(0xFFF3ECE6);
  static const Color textDark = Color(0xFF2C221E);
  static const Color textMuted = Color(0xFF8C827A);
  static const Color borderGrey = Color(0xFFEADBCE);
  static const Color cardBg = Colors.white;

  // Status Colors
  static const Color activeGreenBg = Color(0xFFE8F5E9);
  static const Color activeGreenText = Color(0xFF2E7D32);
  static const Color draftGreyBg = Color(0xFFEEEEEE);
  static const Color draftGreyText = Color(0xFF616161);
  static const Color closedRedBg = Color(0xFFFFEBEE);
  static const Color closedRedText = Color(0xFFC62828);

  String selectedStatus = 'All Statuses';
  String selectedSort = 'Sort by Date';

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
                            _buildJobsTable(),
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
          _sidebarItem(Icons.work_outline, 'Jobs', isActive: true),
          _sidebarItem(Icons.groups_outlined, 'Talent'),
          _sidebarItem(Icons.description_outlined, 'Applications'),
          _sidebarItem(Icons.timeline, 'Tracking'),
          _sidebarItem(Icons.person_outline, 'Profile'),
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
                  Text('Search jobs, applicants...', style: TextStyle(color: textMuted, fontSize: 13)),
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

  // --- TITLE HEADER WITH FILTER DROPDOWNS ---
  Widget _buildTitleHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Job Postings', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: textDark)),
            SizedBox(height: 4),
            Text('Manage your active listings and draft postings.', style: TextStyle(fontSize: 13, color: textMuted)),
          ],
        ),
        Row(
          children: [
            _buildDropdown('All Statuses', ['All Statuses', 'Active', 'Draft', 'Closed']),
            const SizedBox(width: 12),
            _buildDropdown('Sort by Date', ['Sort by Date', 'Sort by Applicants', 'Sort by Title']),
          ],
        )
      ],
    );
  }

  Widget _buildDropdown(String value, List<String> items) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderGrey),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          icon: const Icon(Icons.keyboard_arrow_down, size: 18, color: textMuted),
          style: const TextStyle(fontSize: 12, color: textDark, fontWeight: FontWeight.w500),
          onChanged: (String? newValue) {
            if (newValue == null) return;
            setState(() {
              if (items.first == 'All Statuses') {
                selectedStatus = newValue;
              } else {
                selectedSort = newValue;
              }
            });
          },
          items: items.map<DropdownMenuItem<String>>((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
        ),
      ),
    );
  }

  // --- SUMMARY CARDS ---
  Widget _buildSummaryCards() {
    return Row(
      children: [
        // Active Jobs
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: borderGrey),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('ACTIVE JOBS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: textMuted, letterSpacing: 0.5)),
                    SizedBox(height: 8),
                    Text('3', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: textDark)),
                  ],
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: primaryBrown.withOpacity(0.1),
                  child: const Icon(Icons.work_outline, color: primaryBrown, size: 20),
                )
              ],
            ),
          ),
        ),
        const SizedBox(width: 20),
        // Total Applicants
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: borderGrey),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('TOTAL APPLICANTS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: textMuted, letterSpacing: 0.5)),
                    SizedBox(height: 8),
                    Text('24', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: textDark)),
                  ],
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: primaryBrown.withOpacity(0.1),
                  child: const Icon(Icons.people_outline, color: primaryBrown, size: 20),
                )
              ],
            ),
          ),
        ),
        const SizedBox(width: 20),
        // Create New Job Card
        Expanded(
          child: InkWell(
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Aksi berhasil diproses."))),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 104,
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: borderGrey),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.add_circle_outline, color: primaryBrown, size: 28),
                  SizedBox(height: 6),
                  Text('Create New Job', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: textDark)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // --- JOBS TABLE ---
  Widget _buildJobsTable() {
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
                Expanded(flex: 4, child: Text('Job Title', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: textMuted))),
                Expanded(flex: 2, child: Text('Status', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: textMuted))),
                Expanded(flex: 2, child: Text('Posted Date', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: textMuted))),
                Expanded(flex: 2, child: Center(child: Text('Applicants', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: textMuted)))),
                Expanded(flex: 2, child: Align(alignment: Alignment.centerRight, child: Text('Actions', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: textMuted)))),
              ],
            ),
          ),

          // Table Rows
          _buildJobRow(
            title: 'Senior Barista',
            subtitle: 'Jakarta Selatan • Full-time',
            status: 'Active',
            postedDate: 'Oct 12, 2023',
            applicants: '12',
            actionText: 'Manage',
            isPrimaryAction: true,
          ),
          _buildJobRow(
            title: 'Store Manager',
            subtitle: 'Bandung • Full-time',
            status: 'Active',
            postedDate: 'Oct 10, 2023',
            applicants: '8',
            actionText: 'Manage',
            isPrimaryAction: true,
          ),
          _buildJobRow(
            title: 'Cashier',
            subtitle: 'Part-time',
            status: 'Draft',
            postedDate: '-',
            applicants: '0',
            actionText: 'Edit Draft',
            isPrimaryAction: false,
          ),
          _buildJobRow(
            title: 'Pastry Chef',
            subtitle: 'Jakarta Selatan • Full-time',
            status: 'Closed',
            postedDate: 'Sep 15, 2023',
            applicants: '45',
            actionText: 'View Stats',
            isTextOnlyAction: true,
          ),

          // Table Footer / Pagination
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: borderGrey)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Showing 1 to 4 of 4 entries', style: TextStyle(fontSize: 12, color: textMuted)),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left, size: 18, color: textMuted),
                      onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Aksi berhasil diproses."))),
                      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                      padding: EdgeInsets.zero,
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.chevron_right, size: 18, color: textMuted),
                      onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Aksi berhasil diproses."))),
                      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                      padding: EdgeInsets.zero,
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildJobRow({
    required String title,
    required String subtitle,
    required String status,
    required String postedDate,
    required String applicants,
    required String actionText,
    bool isPrimaryAction = false,
    bool isTextOnlyAction = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: borderGrey, width: 0.5)),
      ),
      child: Row(
        children: [
          // Title & Subtitle
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: textDark)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 12, color: textMuted),
                    const SizedBox(width: 4),
                    Text(subtitle, style: const TextStyle(fontSize: 11, color: textMuted)),
                  ],
                ),
              ],
            ),
          ),

          // Status Badge
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: _buildStatusBadge(status),
            ),
          ),

          // Posted Date
          Expanded(
            flex: 2,
            child: Text(postedDate, style: const TextStyle(fontSize: 12, color: textMuted)),
          ),

          // Applicants
          Expanded(
            flex: 2,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: surfaceCream,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(applicants, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: textDark)),
              ),
            ),
          ),

          // Actions Button
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerRight,
              child: isTextOnlyAction
                  ? TextButton.icon(
                      onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Aksi berhasil diproses."))),
                      icon: const Icon(Icons.remove_red_eye_outlined, size: 14, color: textMuted),
                      label: Text(actionText, style: const TextStyle(fontSize: 12, color: textMuted)),
                    )
                  : OutlinedButton(
                      onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Aksi berhasil diproses."))),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: primaryBrown,
                        side: BorderSide(color: isPrimaryAction ? primaryBrown : borderGrey),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      ),
                      child: Text(actionText, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: isPrimaryAction ? primaryBrown : textDark)),
                    ),
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
      case 'Active':
        bg = activeGreenBg;
        text = activeGreenText;
        break;
      case 'Draft':
        bg = draftGreyBg;
        text = draftGreyText;
        break;
      case 'Closed':
        bg = closedRedBg;
        text = closedRedText;
        break;
      default:
        bg = draftGreyBg;
        text = draftGreyText;
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
}