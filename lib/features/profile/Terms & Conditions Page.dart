import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/dark_mode.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  Widget _buildSection(String title, String content, bool isDark) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: isDark ? Colors.grey[850] : Colors.white,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : AppColors.textDark,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: isDark ? Colors.white70 : AppColors.textLight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : AppColors.background,
      appBar: AppBar(
        title: const Text("Terms & Conditions"),
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Terms & Conditions",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            _buildSection(
              "Welcome",
              "Welcome to our application! Please read these terms and conditions carefully before using the app. By accessing or using the app, you agree to be bound by these terms.",
              isDark,
            ),
            _buildSection(
              "1. User Responsibilities",
              "Users must use the application responsibly and comply with all applicable laws.",
              isDark,
            ),
            _buildSection(
              "2. Privacy",
              "Your personal data is handled according to our privacy policy.",
              isDark,
            ),
            _buildSection(
              "3. Limitation of Liability",
              "We are not responsible for any direct or indirect damage resulting from the use of the application.",
              isDark,
            ),
            _buildSection(
              "4. Modifications",
              "We reserve the right to modify these terms at any time. Continued use of the app constitutes acceptance of the modified terms.",
              isDark,
            ),
          ],
        ),
      ),
    );
  }
}
