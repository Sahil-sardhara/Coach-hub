import 'package:coach_hub/core/theme/dark_mode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/neumorphic_box.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});
  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDarkMode;
    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.background,
      appBar: AppBar(
        title: const Text("About"),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _tile(
              Icons.info_outline,
              "About App",
              "This app showcases events, profile and Zoom UI.",
              isDark,
            ),
            const SizedBox(height: 12),
            _tile(Icons.verified, "Version", "1.0.0", isDark),
            const SizedBox(height: 12),
            _tile(Icons.email, "Contact", "support@test.com", isDark),
          ],
        ),
      ),
    );
  }

  Widget _tile(IconData icon, String title, String subtitle, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: neumorphicBox(isDark),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDark ? AppColors.darkBackground : AppColors.background,
            ),
            child: Icon(icon, color: AppColors.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.darkText : AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: isDark ? AppColors.darkSubText : AppColors.textLight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
