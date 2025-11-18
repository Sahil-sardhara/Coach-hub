import 'package:coach_hub/core/theme/dark_mode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/neumorphic_box.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  Widget _buildSection(String title, String content, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: neumorphicBox(isDark),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.darkText : AppColors.textDark,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
              color: isDark ? AppColors.darkSubText : AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDarkMode;
    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.background,
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
                color: isDark ? AppColors.darkText : Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            _buildSection(
              "Welcome",
              "Welcome to our app. Please read these terms...",
              isDark,
            ),
            _buildSection(
              "1. User Responsibilities",
              "Users must use the application responsibly and comply with laws.",
              isDark,
            ),
            _buildSection(
              "2. Privacy",
              "Your personal data is handled according to our privacy policy.",
              isDark,
            ),
            _buildSection(
              "3. Limitation of Liability",
              "We are not responsible for direct or indirect damages.",
              isDark,
            ),
            _buildSection(
              "4. Modifications",
              "We reserve the right to change terms at any time.",
              isDark,
            ),
          ],
        ),
      ),
    );
  }
}
