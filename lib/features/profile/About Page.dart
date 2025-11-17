import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("About"),
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _settingsTile(
              icon: Icons.info_outline,
              title: "About This App",
              subtitle:
                  "This is a mock educational app created for demonstration purposes, showcasing events, profiles, settings and Zoom meeting UI.",
            ),
            const SizedBox(height: 15),

            _settingsTile(
              icon: Icons.verified,
              title: "Version",
              subtitle: "1.0.0",
            ),
            const SizedBox(height: 15),

            _settingsTile(
              icon: Icons.email_outlined,
              title: "Contact",
              subtitle: "support@test.com\nPhone: +123 456 7890",
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------
  //  PROFILE-STYLE NEUMORPHIC TILE
  // -------------------------------------------------------
  Widget _settingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          // Light Shadow (top-left)
          BoxShadow(
            color: AppColors.lightShadow,
            blurRadius: 6,
            offset: Offset(-4, -4),
          ),

          // Dark Shadow (bottom-right)
          BoxShadow(
            color: AppColors.darkShadow,
            blurRadius: 6,
            offset: Offset(4, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Leading Icon Circle
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.background,
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(
                  color: AppColors.lightShadow,
                  blurRadius: 6,
                  offset: Offset(-3, -3),
                ),
                BoxShadow(
                  color: AppColors.darkShadow,
                  blurRadius: 6,
                  offset: Offset(3, 3),
                ),
              ],
            ),
            child: Icon(icon, color: AppColors.primary),
          ),

          const SizedBox(width: 18),

          // Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textLight,
                    height: 1.4,
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
