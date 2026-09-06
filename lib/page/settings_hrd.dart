import 'package:flutter/material.dart';
import '../service/app_feedback.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Palet Warna KaryaLokal
  static const Color primaryBrown = Color(0xFF8C4A36);
  static const Color surfaceCream = Color(0xFFFBF8F5);
  static const Color sidebarBg = Color(0xFFF3ECE6);
  static const Color textDark = Color(0xFF2C221E);
  static const Color textMuted = Color(0xFF8C827A);
  static const Color borderGrey = Color(0xFFEADBCE);
  static const Color cardBg = Colors.white;

  // Toggle Switches
  bool newJobApplicationsNotify = true;
  bool messageAlertsNotify = true;
  bool marketingTipsNotify = false;
  String selectedIndustry = 'Retail & Crafts';

  // Form Controllers
  final companyNameController = TextEditingController(text: 'Aurea Artisan Goods');
  final websiteController = TextEditingController(text: 'https://aurea-artisan.com');
  final aboutController = TextEditingController(
    text: 'We craft high-quality, locally sourced goods for the modern home. Our mission is to support local artisans while providing beautiful, functional pieces.',
  );

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
                        constraints: const BoxConstraints(maxWidth: 1000),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTitleHeader(),
                            const SizedBox(height: 24),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildSubNavigation(),
                                const SizedBox(width: 24),
                                Expanded(
                                  child: Column(
                                    children: [
                                      _buildBusinessProfileCard(),
                                      const SizedBox(height: 24),
                                      _buildNotificationPreferencesCard(),
                                      const SizedBox(height: 24),
                                      _buildAccountSecurityCard(),
                                    ],
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
          _sidebarItem(Icons.person_outline, 'Profile'),
          const Spacer(),
          _sidebarItem(Icons.settings_outlined, 'Settings', isActive: true),
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
                  Text('Search settings...', style: TextStyle(color: textMuted, fontSize: 13)),
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
        Text('Settings', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: textDark)),
        SizedBox(height: 4),
        Text('Manage your business profile, preferences, and security.', style: TextStyle(fontSize: 13, color: textMuted)),
      ],
    );
  }

  // --- SUB NAVIGATION (LEFT) ---
  Widget _buildSubNavigation() {
    return SizedBox(
      width: 180,
      child: Column(
        children: [
          _subNavItem(Icons.person_outline, 'Profile Details', isActive: true),
          _subNavItem(Icons.notifications_none, 'Notifications'),
          _subNavItem(Icons.security, 'Account Security'),
          _subNavItem(Icons.payment, 'Billing & Plans'),
        ],
      ),
    );
  }

  Widget _subNavItem(IconData icon, String title, {bool isActive = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: isActive ? primaryBrown.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        dense: true,
        leading: Icon(icon, color: isActive ? primaryBrown : textMuted, size: 18),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
            color: isActive ? primaryBrown : textMuted,
          ),
        ),
        onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Aksi berhasil diproses."))),
      ),
    );
  }

  // --- BUSINESS PROFILE CARD ---
  Widget _buildBusinessProfileCard() {
    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Business Profile', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textDark)),
                const SizedBox(height: 2),
                const Text('Update your company logo and public details.', style: TextStyle(fontSize: 12, color: textMuted)),
                const SizedBox(height: 20),
                
                // Company Logo Section
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: surfaceCream,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: borderGrey),
                        image: const DecorationImage(
                          image: NetworkImage('https://images.unsplash.com/photo-1560060141-7b9018741ced?auto=format&fit=crop&w=150&q=80'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Company Logo', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: textDark)),
                        const SizedBox(height: 2),
                        const Text('Recommended size is 256x256px. Maximum file size is 5MB.', style: TextStyle(fontSize: 11, color: textMuted)),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            OutlinedButton(
                              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Aksi berhasil diproses."))),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: textDark,
                                side: const BorderSide(color: borderGrey),
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: const Text('Change', style: TextStyle(fontSize: 11)),
                            ),
                            const SizedBox(width: 12),
                            GestureDetector(
                              onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Aksi berhasil diproses."))),
                              child: const Text('Remove', style: TextStyle(fontSize: 11, color: primaryBrown, fontWeight: FontWeight.w500)),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 20),

                // Company Name Field
                _buildTextField('Company Name', companyNameController),
                const SizedBox(height: 16),

                // Industry & Website (2 Columns)
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Industry', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: textDark)),
                          const SizedBox(height: 6),
                          DropdownButtonFormField<String>(
                            initialValue: selectedIndustry,
                            items: const [
                              DropdownMenuItem(value: 'Retail & Crafts', child: Text('Retail & Crafts', style: TextStyle(fontSize: 13))),
                            ],
                            onChanged: (val) {
                              if (val != null) {
                                setState(() => selectedIndustry = val);
                              }
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: borderGrey)),
                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: borderGrey)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildTextField('Website (optional)', websiteController),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // About the Business Field
                const Text('About the Business', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: textDark)),
                const SizedBox(height: 6),
                TextField(
                  controller: aboutController,
                  maxLines: 3,
                  style: const TextStyle(fontSize: 13, color: textDark),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(12),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: borderGrey)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: borderGrey)),
                  ),
                ),
              ],
            ),
          ),
          
          // Card Footer Button
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: surfaceCream,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
              border: Border(top: BorderSide(color: borderGrey)),
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Aksi berhasil diproses."))),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBrown,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  elevation: 0,
                ),
                child: const Text('Save Changes', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ),
          )
        ],
      ),
    );
  }

  // --- NOTIFICATION PREFERENCES CARD ---
  Widget _buildNotificationPreferencesCard() {
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
          const Text('Notification Preferences', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textDark)),
          const SizedBox(height: 2),
          const Text('Control how you receive updates and alerts.', style: TextStyle(fontSize: 12, color: textMuted)),
          const SizedBox(height: 16),

          _buildSwitchTile(
            'New Job Applications',
            'Receive an email when a candidate applies to your job post.',
            newJobApplicationsNotify,
            (val) => setState(() => newJobApplicationsNotify = val),
          ),
          const Divider(color: borderGrey, height: 20),
          _buildSwitchTile(
            'Message Alerts',
            'Get notified when a candidate sends you a message.',
            messageAlertsNotify,
            (val) => setState(() => messageAlertsNotify = val),
          ),
          const Divider(color: borderGrey, height: 20),
          _buildSwitchTile(
            'Marketing & Tips',
            'Occasional emails with platform updates and hiring tips.',
            marketingTipsNotify,
            (val) => setState(() => marketingTipsNotify = val),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(String title, String subtitle, bool value, ValueChanged<bool> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: textDark)),
              const SizedBox(height: 2),
              Text(subtitle, style: const TextStyle(fontSize: 11, color: textMuted)),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: primaryBrown,
        ),
      ],
    );
  }

  // --- ACCOUNT SECURITY CARD ---
  Widget _buildAccountSecurityCard() {
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
          const Text('Account Security', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textDark)),
          const SizedBox(height: 2),
          const Text('Manage your password and authentication settings.', style: TextStyle(fontSize: 12, color: textMuted)),
          const SizedBox(height: 20),

          const Text('Change Password', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: textDark)),
          const SizedBox(height: 12),
          _buildTextField('Current Password', TextEditingController(), isPassword: true),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildTextField('New Password', TextEditingController(), isPassword: true)),
              const SizedBox(width: 16),
              Expanded(child: _buildTextField('Confirm New Password', TextEditingController(), isPassword: true)),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Aksi berhasil diproses."))),
            style: ElevatedButton.styleFrom(
              backgroundColor: sidebarBg,
              foregroundColor: textMuted,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            ),
            child: const Text('Update Password', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ),

          const Divider(color: borderGrey, height: 32),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('Two-Factor Authentication (2FA)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: textDark)),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text('ENABLED', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32))),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text('Add an extra layer of security to your account. You will need to enter a code sent to your mobile device.', style: TextStyle(fontSize: 11, color: textMuted)),
                ],
              ),
              OutlinedButton(
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Aksi berhasil diproses."))),
                style: OutlinedButton.styleFrom(
                  foregroundColor: textDark,
                  side: const BorderSide(color: borderGrey),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
                child: const Text('Manage 2FA', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
              )
            ],
          )
        ],
      ),
    );
  }

  // Helper Custom TextField
  Widget _buildTextField(String label, TextEditingController controller, {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: textDark)),
        const SizedBox(height: 6),
        SizedBox(
          height: 40,
          child: TextField(
            controller: controller,
            obscureText: isPassword,
            style: const TextStyle(fontSize: 13, color: textDark),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: borderGrey)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: borderGrey)),
            ),
          ),
        ),
      ],
    );
  }
}