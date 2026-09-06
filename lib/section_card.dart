import 'package:flutter/material.dart';

// Palette Warna
const Color primaryBrown = Color(0xFF8B4513);
const Color cardBgLight = Color(0xFFF9F9F9);
const Color textDark = Color(0xFF212121);
const Color textMuted = Color(0xFF757575);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo Section Card'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Contoh 1: Menggunakan Action Text (misal: "Lihat Semua")
          SectionCard(
            icon: Icons.history,
            title: 'Aktivitas Terakhir',
            subtitle: 'Ringkasan transaksi mingguan kamu',
            actionText: 'Lihat Semua',
            onActionPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Aksi Lihat Semua diklik!')),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Pembelian Pulsa'),
                  Text(
                    '-Rp 50.000',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Contoh 2: Menggunakan Action Icon (misal: Icon More)
          SectionCard(
            icon: Icons.settings,
            title: 'Pengaturan Quick Access',
            actionIcon: Icons.more_vert,
            onActionPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Aksi Icon diklik!')),
              );
            },
            child: const Text('Isi konten komponen lainnya di sini...'),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// WIDGET SECTION CARD (Reusable Component)
// ============================================================================
class SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final IconData? actionIcon;
  final String? actionText;
  final VoidCallback? onActionPressed;
  final Widget child;

  const SectionCard({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.actionIcon,
    this.actionText,
    this.onActionPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBgLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, size: 20, color: textDark),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: textDark,
                    ),
                  ),
                ],
              ),
              if (actionIcon != null)
                IconButton(
                  icon: Icon(actionIcon, size: 18, color: textMuted),
                  onPressed: onActionPressed,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                )
              else if (actionText != null)
                TextButton(
                  onPressed: onActionPressed,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    actionText!,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: primaryBrown,
                    ),
                  ),
                ),
            ],
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle!,
              style: const TextStyle(fontSize: 11, color: textMuted),
            ),
          ],
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}