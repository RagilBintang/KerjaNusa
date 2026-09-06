import 'package:flutter/material.dart';
import '../service/app_feedback.dart';

class DiscoverTalentPage extends StatefulWidget {
  const DiscoverTalentPage({super.key});

  @override
  State<DiscoverTalentPage> createState() => _DiscoverTalentPageState();
}

class _DiscoverTalentPageState extends State<DiscoverTalentPage> {
  // Palet Warna KaryaLokal
  static const Color primaryBrown = Color(0xFF8C4A36);
  static const Color surfaceCream = Color(0xFFFBF8F5);
  static const Color sidebarBg = Color(0xFFF3ECE6);
  static const Color textDark = Color(0xFF2C221E);
  static const Color textMuted = Color(0xFF8C827A);
  static const Color borderGrey = Color(0xFFEADBCE);
  static const Color cardBg = Colors.white;

  // Badge Colors
  static const Color topRatedGreenBg = Color(0xFFE8F5E9);
  static const Color topRatedGreenText = Color(0xFF2E7D32);

  // Filter Checkbox States
  bool isWoodworkingSelected = false;
  bool isTextilesSelected = false;
  bool isCeramicsSelected = false;

  // Filter Skill Tag States
  String selectedSkill = 'Carving';

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
                            _buildMainContent(),
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
          _sidebarItem(Icons.groups_outlined, 'Talent', isActive: true),
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
                  Text('Search talent by skills, roles...', style: TextStyle(color: textMuted, fontSize: 13)),
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

  // --- TITLE HEADER ---
  Widget _buildTitleHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text('Discover Talent', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: textDark)),
        SizedBox(height: 4),
        Text('Find the right local craftspeople for your business.', style: TextStyle(fontSize: 13, color: textMuted)),
      ],
    );
  }

  // --- MAIN CONTENT (FILTERS + CARDS) ---
  Widget _buildMainContent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Sidebar Filter
        SizedBox(
          width: 220,
          child: _buildFilterCard(),
        ),
        const SizedBox(width: 24),
        // Grid Talent Cards
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildTalentCard(
                  name: 'Budi Santoso',
                  role: 'Master Artisan\nWoodworker',
                  badgeText: 'Top Rated',
                  badgeIcon: Icons.star,
                  isTopRated: true,
                  avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=150&q=80',
                  skills: ['Teak Carving', 'Joinery', 'Restoration'],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTalentCard(
                  name: 'Siti Rahma',
                  role: 'Ceramics Specialist',
                  avatarUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=150&q=80',
                  skills: ['Wheel Throwing', 'Glazing', 'Kiln Operation'],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTalentCard(
                  name: 'Agus Wijaya',
                  role: 'Batik Textile Weaver',
                  badgeText: 'Verified',
                  badgeIcon: Icons.verified_user_outlined,
                  isTopRated: true,
                  avatarUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=150&q=80',
                  skills: ['Loom Weaving', 'Pattern Design', 'Natural Dyeing'],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- FILTER CARD ---
  Widget _buildFilterCard() {
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
              const Text('Filters', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textDark)),
              GestureDetector(
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Aksi berhasil diproses."))),
                child: const Text('Clear all', style: TextStyle(fontSize: 11, color: textMuted)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Industry', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: textDark)),
          const SizedBox(height: 8),
          _buildCheckboxOption('Woodworking', isWoodworkingSelected, (val) => setState(() => isWoodworkingSelected = val!)),
          _buildCheckboxOption('Textiles & Batik', isTextilesSelected, (val) => setState(() => isTextilesSelected = val!)),
          _buildCheckboxOption('Ceramics', isCeramicsSelected, (val) => setState(() => isCeramicsSelected = val!)),
          const SizedBox(height: 16),
          const Text('Skills', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: textDark)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildSkillChip('Carving', isSelected: selectedSkill == 'Carving'),
              _buildSkillChip('Joinery', isSelected: selectedSkill == 'Joinery'),
              _buildSkillChip('Finishing', isSelected: selectedSkill == 'Finishing'),
              _buildSkillChip('Upholstery', isSelected: selectedSkill == 'Upholstery'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCheckboxOption(String title, bool value, ValueChanged<bool?> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: Checkbox(
              value: value,
              onChanged: onChanged,
              activeColor: primaryBrown,
              side: const BorderSide(color: borderGrey, width: 1.5),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
            ),
          ),
          const SizedBox(width: 8),
          Text(title, style: const TextStyle(fontSize: 12, color: textMuted)),
        ],
      ),
    );
  }

  Widget _buildSkillChip(String label, {bool isSelected = false}) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedSkill = label;
        });
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? Colors.transparent : surfaceCream,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isSelected ? primaryBrown : borderGrey),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? primaryBrown : textDark,
          ),
        ),
      ),
    );
  }

  // --- TALENT CARD ---
  Widget _buildTalentCard({
    required String name,
    required String role,
    required String avatarUrl,
    required List<String> skills,
    String? badgeText,
    IconData? badgeIcon,
    bool isTopRated = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderGrey),
      ),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: 32,
                backgroundImage: NetworkImage(avatarUrl),
              ),
              if (badgeText != null)
                Positioned(
                  top: -4,
                  right: -40,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: topRatedGreenBg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (badgeIcon != null) ...[
                          Icon(badgeIcon, size: 10, color: topRatedGreenText),
                          const SizedBox(width: 3),
                        ],
                        Text(badgeText, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: topRatedGreenText)),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textDark)),
          const SizedBox(height: 4),
          Text(
            role,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11, color: textMuted, height: 1.2),
          ),
          const SizedBox(height: 16),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text('KEY SKILLS', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: textMuted, letterSpacing: 0.5)),
          ),
          const SizedBox(height: 8),
          Column(
            children: skills
                .map(
                  (skill) => Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 6),
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      color: surfaceCream,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      skill,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 11, color: textDark, fontWeight: FontWeight.w500),
                    ),
                  ),
                )
                .toList(),
          ),
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
              child: const Text('View Profile', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}