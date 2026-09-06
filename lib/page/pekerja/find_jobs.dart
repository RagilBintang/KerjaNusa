import 'package:flutter/material.dart';
import '../../service/app_feedback.dart';
import '../../service/api_client.dart';

// --- DATA MODEL ---
class JobItem {
  final String id;
  final String logoText;
  final String company;
  final String title;
  final List<String> tags;
  final String salary;
  final String location;
  final String desc;
  final String time;
  final String matchPercentage;
  final String bannerImageUrl;
  final String companyProfile;
  final List<String> responsibilities;
  final List<String> qualifications;
  final List<String> benefits;

  const JobItem({
    required this.id,
    required this.logoText,
    required this.company,
    required this.title,
    required this.tags,
    required this.salary,
    required this.location,
    required this.desc,
    required this.time,
    required this.matchPercentage,
    required this.bannerImageUrl,
    required this.companyProfile,
    required this.responsibilities,
    required this.qualifications,
    required this.benefits,
  });
}

class FindJobsPage extends StatefulWidget {
  const FindJobsPage({super.key});

  @override
  State<FindJobsPage> createState() => _FindJobsPageState();
}

class _FindJobsPageState extends State<FindJobsPage> {
  // Palet Warna
  static const Color primaryBrown = Color(0xFF7A3E2D);
  static const Color surfaceCream = Color(0xFFF9F5F1);
  static const Color sidebarBg = Color(0xFFEFE9E3);
  static const Color textDark = Color(0xFF2C221E);
  static const Color textMuted = Color(0xFF7A6E68);
  static const Color matchGreen = Color(0xFF4CAF50);
  static const Color badgeGreenBg = Color(0xFFE8F5E9);
  static const Color borderGrey = Color(0xFFE2D9D0);

  int selectedJobIndex = 0;
  final Set<String> bookmarkedJobIds = <String>{};
  final Set<String> appliedJobIds = <String>{};
  final ApiClient _apiClient = ApiClient();
    final TextEditingController _applicantNameController =
      TextEditingController(text: 'Budi Santoso');
    final TextEditingController _applicantEmailController =
      TextEditingController(text: 'budi@example.com');
  List<JobItem> apiJobs = <JobItem>[];
  bool isLoadingJobs = true;

  // Master Data Lowongan
  final List<JobItem> mockJobs = const [
    JobItem(
      id: '1',
      logoText: 'SK',
      company: 'Studio Kriya Nusantara',
      title: 'Staff Desain Konten Kreatif',
      tags: ['Magang / PKL', 'Work-in-person', 'Match 95%'],
      salary: 'Rp 3.500.000 - Rp 5.000.000',
      location: 'Bandung Wetan, Jawa Barat',
      desc: 'Mencari kreator muda bersemangat untuk memproduksi visual feed media sosial, reels, dan katalog digital kriya rekaan modern...',
      time: '2 jam yang lalu',
      matchPercentage: '95% MATCH',
      bannerImageUrl: 'https://images.unsplash.com/photo-1513519245088-0e12902e5a38?auto=format&fit=crop&w=800&q=80',
      companyProfile: 'Studio Kriya Nusantara adalah UMKM kerajinan rotan & bambu kontemporer berorientasi ekspor. Kami memadukan kearifan lokal anyaman Sunda dengan estetika minimalis modern.',
      responsibilities: [
        'Merancang konten digital, carousel Instagram, dan thumbnail video TikTok mingguan.',
        'Membantu sesi foto katalog produk berkala di workshop kreatif.',
        'Bekerja sama dengan tim operasional untuk materi promosi owner UMKM.',
      ],
      qualifications: [
        'Fresh graduate & siswa magang SMK Multimedia/DKV diprioritaskan.',
        'Menguasai tools grafis dasar (Canva Pro / Adobe Illustrator / Photoshop).',
        'Paham komposisi warna earth tone dan visual clean.',
      ],
      benefits: ['Mentoring 1 on 1', 'Uang Makan', 'Sertifikat Resmi', 'Jam Kerja Fleksibel'],
    ),
    JobItem(
      id: '2',
      logoText: 'WT',
      company: 'WarungTech Solusindo',
      title: 'Junior Flutter Developer',
      tags: ['Full-time', 'Onsite (WFA)', 'Match 88%'],
      salary: 'Rp 6.000.000 - Rp 8.000.000',
      location: 'Jakarta Selatan / WFA',
      desc: 'Membangun modul POS kasir digital untuk ribuan warung mitra. Memerlukan pemahaman dasar State Management & REST API Provider...',
      time: '5 jam yang lalu',
      matchPercentage: '88% MATCH',
      bannerImageUrl: 'https://images.unsplash.com/photo-1555066931-4365d14bab8c?auto=format&fit=crop&w=800&q=80',
      companyProfile: 'WarungTech Solusindo berfokus menyediakan sistem POS dan aplikasi kasir pintar serba digital bagi UMKM ritel tradisional.',
      responsibilities: [
        'Mengembangkan UI komponen re-usable menggunakan Flutter SDK.',
        'Mengintegrasikan endpoint RESTful API dengan State Management (Provider/Bloc).',
        'Memperbaiki bug dan mengoptimalkan performa aplikasi mobile.',
      ],
      qualifications: [
        'Pendidikan D3/S1 Rekayasa Perangkat Lunak, Informatika, atau lulusan SMK terkait.',
        'Memiliki portofolio aplikasi Flutter sederhana.',
        'Terbiasa menggunakan Version Control (Git/GitHub).',
      ],
      benefits: ['Kerja Remot/WFA', 'Tunjangan Kesehatan', 'Bonus Kinerja', 'Kredit Device'],
    ),
    JobItem(
      id: '3',
      logoText: 'BM',
      company: 'CV Berkah Mandiri',
      title: 'Staff Administrasi & Keuangan',
      tags: ['Full-time', 'On-site', 'Match 82%'],
      salary: 'Rp 4.200.000 - Rp 5.500.000',
      location: 'Surabaya, Jawa Timur',
      desc: 'Mengelola pembukuan harian, faktur pajak sederhana, serta rekapitulasi kas operasional toko grosir bahan kue...',
      time: '1 hari yang lalu',
      matchPercentage: '82% MATCH',
      bannerImageUrl: 'https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?auto=format&fit=crop&w=800&q=80',
      companyProfile: 'CV Berkah Mandiri merupakan distributor dan toko grosir bahan baku kue terpercaya di Jawa Timur yang melayani ratusan pelaku usaha kuliner.',
      responsibilities: [
        'Mencatat transaksi penjualan dan pembelian harian ke dalam sistem pencatatan.',
        'Membuat faktur tagihan dan mengelola administrasi piutang pelanggan.',
        'Menyusun laporan arus kas bulanan secara teliti.',
      ],
      qualifications: [
        'Lulusan SMK Akuntansi / D3 Keuangan.',
        'Menguasai Ms. Excel (VLOOKUP, Pivot Table) atau spreadsheet.',
        'Jujur, teliti, dan memiliki komunikasi yang baik.',
      ],
      benefits: ['Gaji Pokok', 'Tunjangan Hari Raya', 'Insentif Bulanan', 'Asuransi Kesehatan'],
    ),
  ];

  List<JobItem> get displayedJobs => apiJobs.isEmpty ? mockJobs : apiJobs;

  @override
  void initState() {
    super.initState();
    _loadJobs();
  }

  Future<void> _loadJobs() async {
    try {
      final records = await _apiClient.getJobs();
      if (!mounted) return;
      setState(() {
        apiJobs = records.map(_jobFromApi).toList();
        isLoadingJobs = false;
        selectedJobIndex = 0;
      });
    } catch (_) {
      if (mounted) setState(() => isLoadingJobs = false);
    }
  }

  JobItem _jobFromApi(Map<String, dynamic> data) {
    final title = data['title']?.toString() ?? 'Lowongan Baru';
    final company = data['company']?.toString() ?? 'UMKM Lokal';
    return JobItem(
      id: data['id']?.toString() ?? title,
      logoText: company.substring(0, company.length > 2 ? 2 : 1).toUpperCase(),
      company: company,
      title: title,
      tags: [data['type']?.toString() ?? 'Full-time', 'API'],
      salary: data['salary']?.toString() ?? 'Negosiasi',
      location: data['location']?.toString() ?? 'Indonesia',
      desc: data['description']?.toString() ?? 'Deskripsi belum tersedia.',
      time: 'Dari API',
      matchPercentage: 'MATCH',
      bannerImageUrl: 'https://images.unsplash.com/photo-1521737711867-e3b97375f902?auto=format&fit=crop&w=800&q=80',
      companyProfile: company,
      responsibilities: const ['Bekerja sesuai deskripsi lowongan.'],
      qualifications: const ['Memenuhi kualifikasi yang ditentukan perusahaan.'],
      benefits: const ['Kesempatan berkembang bersama UMKM lokal.'],
    );
  }

  Future<void> _applyForJob(JobItem job) async {
    try {
      await _apiClient.createApplication(
        jobId: job.id,
        jobTitle: job.title,
        applicantName: _applicantNameController.text,
        applicantEmail: _applicantEmailController.text,
      );
      if (!mounted) return;
      setState(() => appliedJobIds.add(job.id));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lamaran ${job.title} tersimpan di API.')),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('API belum aktif. Lamaran belum dikirim.')),
      );
    }
  }

  @override
  void dispose() {
    _apiClient.dispose();
    _applicantNameController.dispose();
    _applicantEmailController.dispose();
    super.dispose();
  }

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
                        constraints: const BoxConstraints(maxWidth: 1300),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildBannerHeader(),
                            const SizedBox(height: 20),
                            _buildFilterSection(),
                            const SizedBox(height: 24),
                            _buildMainContent(),
                            const SizedBox(height: 24),
                            _buildPagination(),
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
          _sidebarItem(Icons.work, 'Find Jobs', isActive: true),
          _sidebarItem(Icons.description_outlined, 'Application'),
          _sidebarItem(Icons.person_outline, 'Profile'),
          _sidebarItem(Icons.settings_outlined, 'Settings'),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0x99FFFFFF),
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

  // --- BANNER HEADER ---
  Widget _buildBannerHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: primaryBrown,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0x26FFFFFF),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text('EKOSISTEM KARIR UMKM TERINTEGRASI', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 12),
                const Text('Temukan Lowongan UMKM', style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('Ratusan peluang karir dan magang terverifikasi untuk fresh graduate & SMK di seluruh Indonesia.', style: TextStyle(color: Colors.white70, fontSize: 13)),
              ],
            ),
          ),
          const Icon(Icons.storefront, size: 90, color: Colors.white24),
        ],
      ),
    );
  }

  // --- FILTER SECTION ---
  Widget _buildFilterSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderGrey),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildFilterDropdown('Posisi / Keahlian', 'Desain Grafis')),
              const SizedBox(width: 12),
              Expanded(child: _buildFilterDropdown('Lokasi Kerja', 'Bandung, Jawa Barat')),
              const SizedBox(width: 12),
              Expanded(child: _buildFilterDropdown('Tipe Pekerjaan', 'Magang / PKL (Internship)')),
              const SizedBox(width: 12),
              Expanded(child: _buildFilterDropdown('Rentang Gaji', 'Rp 3 - 10 Juta')),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Text('Filter Aktif: ', style: TextStyle(fontSize: 12, color: textMuted)),
              _buildChipFilter('Desain Grafis'),
              _buildChipFilter('Bandung'),
              _buildChipFilter('Magang / PKL'),
              const Spacer(),
              TextButton(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Aksi berhasil diproses."))), child: const Text('Reset', style: TextStyle(color: textMuted, fontSize: 12))),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Aksi berhasil diproses."))),
                icon: const Icon(Icons.filter_list, size: 16),
                label: const Text('Terapkan Filter'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBrown,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildFilterDropdown(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: textMuted, fontWeight: FontWeight.w500)),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: surfaceCream,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: borderGrey),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: textDark)),
              const Icon(Icons.arrow_drop_down, color: textMuted, size: 18),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChipFilter(String label) {
    return Container(
      margin: const EdgeInsets.only(right: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: surfaceCream,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0x4D7A3E2D)),
      ),
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontSize: 11, color: primaryBrown, fontWeight: FontWeight.bold)),
          const SizedBox(width: 4),
          const Icon(Icons.close, size: 12, color: primaryBrown),
        ],
      ),
    );
  }

  // --- CONTENT LAYOUT ---
  Widget _buildMainContent() {
    final selectedJob = displayedJobs[selectedJobIndex.clamp(0, displayedJobs.length - 1)];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Kolom Kiri: List Pekerjaan
        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text('Lowongan Tersedia', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textDark)),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(color: badgeGreenBg, borderRadius: BorderRadius.circular(12)),
                        child: Text('${displayedJobs.length} Ditemukan', style: const TextStyle(fontSize: 11, color: matchGreen, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  Row(
                    children: const [
                      Text('Urutkan: ', style: TextStyle(fontSize: 12, color: textMuted)),
                      Text('Paling Relevan', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: textDark)),
                      Icon(Icons.arrow_drop_down, size: 16),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 16),
              ...List.generate(displayedJobs.length, (index) {
                return _buildJobCard(job: displayedJobs[index], index: index);
              }),
            ],
          ),
        ),
        const SizedBox(width: 24),
        // Kolom Kanan: Detail Panel Dinamis
        Expanded(
          flex: 5,
          child: _buildJobDetailPanel(selectedJob),
        ),
      ],
    );
  }

  Widget _buildJobCard({required JobItem job, required int index}) {
    bool isSelected = selectedJobIndex == index;

    return GestureDetector(
      onTap: () => setState(() => selectedJobIndex = index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? primaryBrown : borderGrey, width: isSelected ? 2 : 1),
          boxShadow: isSelected ? const [BoxShadow(color: Color(0x1A7A3E2D), blurRadius: 8)] : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: surfaceCream,
                  child: Text(job.logoText, style: const TextStyle(fontWeight: FontWeight.bold, color: primaryBrown)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(job.company, style: const TextStyle(fontSize: 12, color: textMuted)),
                          const SizedBox(width: 4),
                          const Icon(Icons.verified, size: 14, color: Colors.blue),
                        ],
                      ),
                      Text(job.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textDark)),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    bookmarkedJobIds.contains(job.id)
                        ? Icons.bookmark
                        : Icons.bookmark_outline,
                    color: primaryBrown,
                  ),
                  onPressed: () {
                    setState(() {
                      if (!bookmarkedJobIds.add(job.id)) {
                        bookmarkedJobIds.remove(job.id);
                      }
                    });
                  },
                  tooltip: 'Simpan lowongan',
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: job.tags.map((t) => Container(
                margin: const EdgeInsets.only(right: 6),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: t.contains('Match') ? badgeGreenBg : surfaceCream,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  t,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: t.contains('Match') ? matchGreen : textDark,
                  ),
                ),
              )).toList(),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(job.salary, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: primaryBrown)),
                const Text(' / bulan', style: TextStyle(fontSize: 11, color: textMuted)),
                const Spacer(),
                const Icon(Icons.location_on_outlined, size: 14, color: textMuted),
                const SizedBox(width: 2),
                Text(job.location, style: const TextStyle(fontSize: 11, color: textMuted)),
              ],
            ),
            const SizedBox(height: 10),
            Text(job.desc, style: const TextStyle(fontSize: 12, color: textMuted, height: 1.4)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(job.time, style: const TextStyle(fontSize: 11, color: textMuted)),
                ElevatedButton(
                  onPressed: () {
                    _applyForJob(job);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBrown,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  child: const Text('Lamar Cepat', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // --- DETAIL PANEL KANAN ---
  Widget _buildJobDetailPanel(JobItem job) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderGrey),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: surfaceCream,
                    child: Text(job.logoText, style: const TextStyle(fontWeight: FontWeight.bold, color: primaryBrown, fontSize: 18)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(job.company, style: const TextStyle(fontSize: 12, color: textMuted)),
                        Text(job.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textDark)),
                        Text(job.location, style: const TextStyle(fontSize: 12, color: textMuted)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: badgeGreenBg, borderRadius: BorderRadius.circular(12)),
                    child: Text(job.matchPercentage, style: const TextStyle(fontSize: 11, color: matchGreen, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: surfaceCream, borderRadius: BorderRadius.circular(8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Kisaran Gaji', style: TextStyle(fontSize: 10, color: textMuted)),
                        Text('${job.salary} / bulan', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: primaryBrown)),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                      child: Text(job.tags.first, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: textDark)),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  job.bannerImageUrl,
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 140,
                    color: borderGrey,
                    child: const Icon(Icons.broken_image, color: textMuted),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildDetailSectionTitle('Profil Singkat Usaha'),
              Text(
                job.companyProfile,
                style: const TextStyle(fontSize: 12, color: textMuted, height: 1.5),
              ),
              const SizedBox(height: 16),
              _buildDetailSectionTitle('Tanggung Jawab Utama'),
              ...job.responsibilities.map((r) => _buildBulletPoint(r)),
              const SizedBox(height: 16),
              _buildDetailSectionTitle('Kualifikasi'),
              ...job.qualifications.map((q) => _buildBulletPoint(q)),
              const SizedBox(height: 16),
              _buildDetailSectionTitle('Benefit & Fasilitas'),
              Wrap(
                spacing: 12,
                runSpacing: 6,
                children: job.benefits.map((b) => SizedBox(
                  width: 180,
                  child: _buildBulletPoint(b),
                )).toList(),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _applyForJob(job);
                      },
                      icon: const Icon(Icons.send, size: 16),
                      label: const Text('Lamar Sekarang'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryBrown,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton(
                    onPressed: () {
                      setState(() {
                        if (!bookmarkedJobIds.add(job.id)) {
                          bookmarkedJobIds.remove(job.id);
                        }
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.all(14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Icon(Icons.bookmark_border, color: textDark),
                  )
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: surfaceCream,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderGrey),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Icon(Icons.lightbulb_outline, color: primaryBrown, size: 20),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tips Tiba Melamar di UMKM', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: textDark)),
                    SizedBox(height: 4),
                    Text(
                      'UMKM sangat menghargai inisiatif dan sikap santun. Sertakan surat pengantar ringkas dan portofolio terbaikmu untuk memperbesar peluang dipanggil wawancara langsung oleh pemilik usaha.',
                      style: TextStyle(fontSize: 11, color: textMuted, height: 1.4),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildDetailSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: textDark)),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(color: primaryBrown, fontWeight: FontWeight.bold)),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 11, color: textMuted, height: 1.3))),
        ],
      ),
    );
  }

  // --- PAGINATION ---
  Widget _buildPagination() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Menampilkan 1 - ${displayedJobs.length} dari ${displayedJobs.length} lowongan', style: const TextStyle(fontSize: 12, color: textMuted)),
        Row(
          children: [
            const Icon(Icons.chevron_left, color: textMuted, size: 20),
            const SizedBox(width: 8),
            _pageNumber('1', isActive: true),
            _pageNumber('2'),
            _pageNumber('3'),
            const Text(' ... ', style: TextStyle(color: textMuted)),
            _pageNumber('12'),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, color: textMuted, size: 20),
          ],
        )
      ],
    );
  }

  Widget _pageNumber(String number, {bool isActive = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      width: 28,
      height: 28,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isActive ? primaryBrown : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        number,
        style: TextStyle(
          fontSize: 12,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          color: isActive ? Colors.white : textDark,
        ),
      ),
    );
  }
}