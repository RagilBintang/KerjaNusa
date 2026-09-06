import 'package:flutter/material.dart';
import 'service/app_feedback.dart';

// 1. IMPORT AUTH PAGES
import 'page/role_page.dart';
import 'page/login_page.dart';

// 2. IMPORT PEKERJA PAGES
import 'page/pekerja/find_jobs.dart';
import 'page/pekerja/dashbor_pekerja.dart';
import 'page/pekerja/profile_seeker.dart';
import 'page/pekerja/setting_seeker.dart';

// 3. IMPORT HRD PAGES
import 'page/dashboard_hrd.dart';
import 'page/management_hrd.dart';
import 'page/hrd_tracking.dart' as hrd_tracking;
import 'page/talent_hrd.dart';
import 'page/aplication.dart' as application;
import 'page/profile_hrd.dart';
import 'page/settings_hrd.dart';

void main() {
  runApp(const KaryaLokalApp());
}

class KaryaLokalApp extends StatelessWidget {
  const KaryaLokalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KaryaLokal',
      scaffoldMessengerKey: AppFeedback.messengerKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFFBF8F5),
      ),
      initialRoute: '/role',
      routes: {
        '/role': (context) => const RolePage(),
        '/login': (context) => const LoginPage(),

        // Pekerja Routes
        '/pekerja/dashboard': (context) => const DashborPekerjaPage(),
        '/pekerja/find-jobs': (context) => const FindJobsPage(),

        '/pekerja/profile': (context) => const ProfilePekerjaPage(),
        '/pekerja/settings': (context) => const SettingSeekerPage(),

        // HRD Routes
        '/hrd/dashboard': (context) => const DashboardHRD(),
        '/hrd/management': (context) => const JobManagementPage(),
        '/hrd/tracking': (context) => const hrd_tracking.ApplicationsPage(),
        '/hrd/talent': (context) => const DiscoverTalentPage(),
        '/hrd/applications': (context) => const application.ApplicationsPage(),
        '/hrd/profile': (context) => const ProfileHrdPage(),
        '/hrd/settings': (context) => const SettingsPage(),
      },
    );
  }
}