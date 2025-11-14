import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCard(
              title: "About This App",
              content:
                  "This is a mock educational app created for demonstration purposes. It showcases a profile page, edit profile functionality, terms & conditions, settings, and other features.",
              isDark: isDark,
            ),
            _buildCard(title: "Version", content: "1.0.0", isDark: isDark),
            _buildCard(
              title: "Contact",
              content: "Email: support@test.com\nPhone: +123 456 7890",
              isDark: isDark,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required String content,
    required bool isDark,
  }) {
    return Card(
      color: isDark ? Colors.grey[900] : Colors.white,
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              content,
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
