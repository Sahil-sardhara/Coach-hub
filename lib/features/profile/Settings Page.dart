import 'package:coach_hub/core/theme/dark_mode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Settings"), elevation: 0),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "App Settings",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // Notification & Dark Mode Card
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 5,
            shadowColor: AppColors.primary.withOpacity(0.3),
            margin: const EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text(
                    "Enable Notifications",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: const Text("Get notified about new events"),
                  value: true,
                  onChanged: (val) {},
                  activeColor: AppColors.primary,
                  secondary: const Icon(
                    Icons.notifications,
                    color: AppColors.primary,
                  ),
                ),
                const Divider(height: 1),
                SwitchListTile(
                  title: const Text(
                    "Dark Mode",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    themeProvider.isDarkMode
                        ? "Dark mode is ON"
                        : "Dark mode is OFF",
                  ),
                  value: themeProvider.isDarkMode,
                  onChanged: (val) => themeProvider.toggleTheme(val),
                  activeColor: AppColors.primary,
                  secondary: const Icon(
                    Icons.dark_mode,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),

          // Other Settings Card
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 5,
            shadowColor: AppColors.primary.withOpacity(0.3),
            child: Column(
              children: [
                _buildTile(
                  icon: Icons.language,
                  title: "Language",
                  subtitle: "English",
                  onTap: () {},
                ),
                _divider(),
                _buildTile(icon: Icons.lock, title: "Privacy", onTap: () {}),
                _divider(),
                _buildTile(
                  icon: Icons.help,
                  title: "Help & Support",
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary, size: 28),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
      onTap: onTap,
    );
  }

  Widget _divider() {
    return const Divider(height: 1, indent: 16, endIndent: 16);
  }
}
