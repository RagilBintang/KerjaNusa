import 'package:flutter/material.dart';
import '../service/app_feedback.dart';

class ApplicationsPage extends StatelessWidget {
  const ApplicationsPage({Key? key}) : super(key: key);

  // Definisi Warna dari Tailwind Config
  static const Color surfaceCream = Color(0xFFFFF8F6);
  static const Color surfaceContainer = Color(0xFFF3ECEA);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF9F2F0);
  static const Color outlineClay = Color(0xFF89726D);
  static const Color businessTerracotta = Color(0xFF9F402D);
  static const Color primary = Color(0xFF802918);
  static const Color onSurface = Color(0xFF1D1B1A);
  static const Color onSurfaceVariant = Color(0xFF56423E);
  static const Color primaryFixed = Color(0xFFFFDAD3);
  static const Color surfaceSand = Color(0xFFF2DEDA);
  static const Color tertiaryFixed = Color(0xFFD7E2FF);
  static const Color secondaryFixed = Color(0xFFBCF1AD);
  static const Color onTertiaryFixed = Color(0xFF001A40);
  static const Color onSecondaryFixed = Color(0xFF002201);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: surfaceCream,
      body: Row(
        children: [
          // SIDEBAR KIRI
              _buildSidebar(context),
          // KONTEN UTAMA KANAN
          Expanded(
            child: Column(
              children: [
                _buildTopAppBar(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(48.0), // margin-desktop
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeaderSection(),
                        const SizedBox(height: 32), // space-xl
                        _buildStatsRow(),
                        const SizedBox(height: 32), // space-xl
                        _buildApplicationsTable(),
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

  // --- KOMPONEN SIDEBAR ---
  Widget _buildSidebar(BuildContext context) {
    return Container(
      width: 280,
      color: surfaceContainer,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Brand
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'KaryaLokal',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: businessTerracotta,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Business Workspace',
                  style: TextStyle(fontSize: 14, color: onSurfaceVariant),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // Navigation Links
          Expanded(
            child: ListView(
              children: [
                _sidebarItem(context, Icons.dashboard_outlined, 'Dashboard'),
                _sidebarItem(context, Icons.work_outline, 'Jobs'),
                _sidebarItem(context, Icons.group_outlined, 'Talent'),
                _sidebarItem(context, Icons.description, 'Applications', isActive: true),
                _sidebarItem(context, Icons.settings_outlined, 'Settings'),
              ],
            ),
          ),
          // CTA Button
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => AppFeedback.show('Form posting lowongan siap digunakan.'),
            style: ElevatedButton.styleFrom(
              backgroundColor: businessTerracotta,
              foregroundColor: Colors.white,
              // GANTI BARIS INI: Gunakan double.infinity untuk width, dan sesuaikan height-nya (misal 44 atau 0 jika mengandalkan padding)
              minimumSize: const Size(double.infinity, 44), 
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Post a Job', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _sidebarItem(BuildContext context, IconData icon, String title, {bool isActive = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isActive ? primaryFixed.withOpacity(0.3) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(color: isActive ? businessTerracotta : Colors.transparent, width: 4),
        ),
      ),
      child: ListTile(
        leading: Icon(icon, color: isActive ? onSurface : onSurfaceVariant),
        title: Text(
          title,
          style: TextStyle(
            color: isActive ? onSurface : onSurfaceVariant,
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  // --- KOMPONEN TOP APP BAR ---
  Widget _buildTopAppBar() {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 48),
      decoration: BoxDecoration(
        color: surfaceCream.withOpacity(0.8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Search Bar
          Container(
            width: 256, // w-64
            height: 40,
            decoration: BoxDecoration(
              color: surfaceContainer,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: 'Search applications...',
                hintStyle: TextStyle(color: onSurfaceVariant, fontSize: 14),
                prefixIcon: Icon(Icons.search, color: onSurfaceVariant),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
          // Actions
          Row(
            children: [
              IconButton(icon: const Icon(Icons.notifications_none, color: onSurfaceVariant), onPressed: () => AppFeedback.show('Tidak ada notifikasi baru.')),
              IconButton(icon: const Icon(Icons.help_outline, color: onSurfaceVariant), onPressed: () => AppFeedback.show('Pusat bantuan KaryaLokal dibuka.')),
              const SizedBox(width: 16),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: outlineClay.withOpacity(0.2)),
                  image: const DecorationImage(
                    image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuCdjUilGvJF8tCLs36j8qP9Rs6XYsE38t1DxNwRxRgtrOI6lcZmiWGQMHPb3ze44PQL0xIt1wR9uIujkQjMj4irC1S0UjTnzzYb3hxsUNYIvo9Vo7eoMo6UTZCHyOZg6c8JFyGwhLQKmd-S2m9ZFsaYZxEkJJTxruFNBJFq9sOP2lCMhXsiy_f5vX_NUAlXQKNCtC5CGeWg4cRMSh_24L3wonZdXeAeh79yxYwtWdw4FO25vImVN89OzA'),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  // --- KOMPONEN HEADER KONTEN ---
  Widget _buildHeaderSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Applications', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: onSurface)),
            SizedBox(height: 8),
            Text('Manage and track incoming candidates.', style: TextStyle(fontSize: 16, color: onSurfaceVariant)),
          ],
        ),
        Row(
          children: [
            OutlinedButton.icon(
              onPressed: () => AppFeedback.show('Filter pelamar diterapkan.'),
              icon: const Icon(Icons.filter_list, size: 18),
              label: const Text('Filter'),
              style: OutlinedButton.styleFrom(
                foregroundColor: onSurface,
                side: const BorderSide(color: outlineClay),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(width: 16),
            OutlinedButton.icon(
              onPressed: () => AppFeedback.show('Data pelamar diekspor.'),
              icon: const Icon(Icons.download, size: 18),
              label: const Text('Export'),
              style: OutlinedButton.styleFrom(
                foregroundColor: onSurface,
                side: const BorderSide(color: outlineClay),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ],
        )
      ],
    );
  }

  // --- KOMPONEN STATS / SUMMARY BENTO ---
  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(child: _buildStatCard('TOTAL APPLICATIONS', '142', businessTerracotta)),
        const SizedBox(width: 24),
        Expanded(child: _buildStatCard('PENDING REVIEW', '38', onSurface)),
        const SizedBox(width: 24),
        Expanded(child: _buildStatCard('INTERVIEWS SCHEDULED', '12', onSurface)),
        const SizedBox(width: 24),
        Expanded(child: Container()), // Empty space to match grid-cols-4 layout
      ],
    );
  }

  Widget _buildStatCard(String title, String value, Color valueColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: outlineClay.withOpacity(0.2)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: onSurfaceVariant, letterSpacing: 0.5)),
          const SizedBox(height: 8),
          Text(value, style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: valueColor, height: 1.1)),
        ],
      ),
    );
  }

  // --- KOMPONEN TABEL APLIKASI ---
  Widget _buildApplicationsTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: outlineClay.withOpacity(0.2)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4)],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          children: [
            // Top Accent Line
            Container(height: 4, width: double.infinity, color: businessTerracotta),
            
            // Table Header
            Container(
              padding: const EdgeInsets.all(16),
              color: surfaceContainerLowest,
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: outlineClay.withOpacity(0.2)))),
              child: Row(
                children: const [
                  Expanded(flex: 3, child: Text('APPLICANT NAME', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: onSurfaceVariant))),
                  Expanded(flex: 4, child: Text('JOB APPLIED FOR', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: onSurfaceVariant))),
                  Expanded(flex: 2, child: Text('DATE', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: onSurfaceVariant))),
                  Expanded(flex: 2, child: Text('STATUS', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: onSurfaceVariant))),
                  Expanded(flex: 1, child: Align(alignment: Alignment.centerRight, child: Text('ACTION', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: onSurfaceVariant)))),
                ],
              ),
            ),

            // Table Rows
            _buildTableRow(
              name: 'Budi Santoso',
              email: 'budi.s@example.com',
              avatarUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAY29qK_vOcV5xJtqA1g8vdm5LOqvSiclxpaDEr-w-ZO-gi-RWvTdjQwDBUuaqhe5iyMCtyw1oJjeHqKBS6xSkfNCzT5H7k0OQ62p_YXDWjt1T3Q-lAGHhdpgCVUMSx2Vk3RXu9VFnUNyLxvDhZzCv4bHgIJwB8apcYs1PG2FM0IHEaPrq3gv6a0Qwb1DqwV7d-F7WeYM49DrEvuBlTOhHi_Wju4XUm130hCisiume4Bxqnz0oXCNMUrw',
              jobTitle: 'Senior Carpenter',
              department: 'Workshop A',
              date: 'Oct 24, 2023',
              status: 'Pending',
              statusColor: surfaceSand,
              statusTextColor: onSurfaceVariant,
            ),
            _buildTableRow(
              name: 'Siti Aminah',
              email: 'siti.a@example.com',
              initials: 'SA',
              jobTitle: 'Batik Designer',
              department: 'Creative Studio',
              date: 'Oct 23, 2023',
              status: 'Reviewed',
              statusColor: tertiaryFixed,
              statusTextColor: onTertiaryFixed,
              isAlternate: true,
            ),
            _buildTableRow(
              name: 'Agus Wijaya',
              email: 'agus.w@example.com',
              avatarUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBX9h0Wz1P5-YoXBVkKBG3IFx826mh69pl2GBd-3fRGcT98Z326th2lzXAP0jXbpKzkdKvfDCcAVnCzzNyea4OfEIi-k_wIHSL269QlhZesUTvVIAzBxFf98ZLnNUN0ThedZEfMZi1LX7N8vhmbgwUSeUGbdJc_Tu7c8mh6jriW513bbIvq3YvrC0fdItPXBhhxRHS7nmue-c5SmYP40lIds4dSFce4sGpGwXggS8VRvoDlFuxeMW-goA',
              jobTitle: 'Master Weaver',
              department: 'Production Floor',
              date: 'Oct 21, 2023',
              status: 'Interviewed',
              statusColor: secondaryFixed,
              statusTextColor: onSecondaryFixed,
            ),
            _buildTableRow(
              name: 'Rina Kurniawati',
              email: 'rina.k@example.com',
              initials: 'RK',
              jobTitle: 'Store Manager',
              department: 'Retail Front',
              date: 'Oct 20, 2023',
              status: 'Pending',
              statusColor: surfaceSand,
              statusTextColor: onSurfaceVariant,
              isAlternate: true,
            ),

            // Pagination Footer
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: surfaceContainerLowest,
                border: Border(top: BorderSide(color: outlineClay.withOpacity(0.2))),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Showing 1 to 4 of 142 results', style: TextStyle(fontSize: 14, color: onSurfaceVariant)),
                  Row(
                    children: [
                      _buildPaginationButton('Previous', isDisabled: true),
                      const SizedBox(width: 8),
                      _buildPaginationButton('1', isActive: true),
                      const SizedBox(width: 8),
                      _buildPaginationButton('2'),
                      const SizedBox(width: 8),
                      _buildPaginationButton('3'),
                      const SizedBox(width: 8),
                      _buildPaginationButton('Next'),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTableRow({
    required String name,
    required String email,
    String? avatarUrl,
    String? initials,
    required String jobTitle,
    required String department,
    required String date,
    required String status,
    required Color statusColor,
    required Color statusTextColor,
    bool isAlternate = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isAlternate ? surfaceContainerLow : Colors.transparent,
        border: Border(bottom: BorderSide(color: outlineClay.withOpacity(0.1))),
      ),
      child: Row(
        children: [
          // Applicant Name & Avatar
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: initials != null ? primaryFixed : surfaceContainer,
                    shape: BoxShape.circle,
                    image: avatarUrl != null
                        ? DecorationImage(image: NetworkImage(avatarUrl), fit: BoxFit.cover)
                        : null,
                  ),
                  alignment: Alignment.center,
                  child: initials != null
                      ? Text(initials, style: const TextStyle(fontWeight: FontWeight.bold, color: businessTerracotta))
                      : null,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: onSurface)),
                    Text(email, style: const TextStyle(fontSize: 14, color: onSurfaceVariant)),
                  ],
                ),
              ],
            ),
          ),
          // Job Applied For
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(jobTitle, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: onSurface)),
                Text(department, style: const TextStyle(fontSize: 14, color: onSurfaceVariant)),
              ],
            ),
          ),
          // Date
          Expanded(
            flex: 2,
            child: Text(date, style: const TextStyle(fontSize: 16, color: onSurface)),
          ),
          // Status Badge
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(color: statusColor, borderRadius: BorderRadius.circular(16)),
                child: Text(status, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: statusTextColor)),
              ),
            ),
          ),
          // Action Icon
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(Icons.more_vert, color: onSurfaceVariant),
                onPressed: () => AppFeedback.show('Menu pelamar dibuka.'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaginationButton(String text, {bool isActive = false, bool isDisabled = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isActive ? businessTerracotta : Colors.transparent,
        border: Border.all(color: isActive ? businessTerracotta : outlineClay.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isActive ? Colors.white : (isDisabled ? onSurfaceVariant.withOpacity(0.5) : onSurfaceVariant),
          fontSize: 14,
        ),
      ),
    );
  }
}