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
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 5, bottom: 12),
            child: Text(
              "App Settings",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
          ),

          // ----------------------------------------------------
          // 🔵 NEUMORPHIC CARD — Notification + Dark Mode
          // ----------------------------------------------------
          _neumorphicCard(
            child: Column(
              children: [
                _switchTile(
                  icon: Icons.notifications_none,
                  title: "Enable Notifications",
                  subtitle: "Get notified about new events",
                  value: true,
                  onChanged: (val) {},
                ),
                _tileDivider(),
                _switchTile(
                  icon: Icons.dark_mode_outlined,
                  title: "Dark Mode",
                  subtitle: themeProvider.isDarkMode
                      ? "Dark mode is ON"
                      : "Dark mode is OFF",
                  value: themeProvider.isDarkMode,
                  onChanged: (val) => themeProvider.toggleTheme(val),
                ),
              ],
            ),
          ),

          const SizedBox(height: 22),

          // ----------------------------------------------------
          // 🔵 NEUMORPHIC CARD — Other settings
          // ----------------------------------------------------
          _neumorphicCard(
            child: Column(
              children: [
                _settingsTile(
                  icon: Icons.language,
                  title: "Language",
                  subtitle: "English",
                  onTap: () {},
                ),
                _tileDivider(),
                _settingsTile(
                  icon: Icons.lock_outline,
                  title: "Privacy",
                  onTap: () {},
                ),
                _tileDivider(),
                _settingsTile(
                  icon: Icons.help_outline,
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

  // ----------------------------------------------------
  // REUSABLE NEUMORPHIC CARD (same as profile)
  // ----------------------------------------------------
  Widget _neumorphicCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: AppColors.lightShadow,
            blurRadius: 6,
            offset: Offset(-4, -4),
          ),
          BoxShadow(
            color: AppColors.darkShadow,
            blurRadius: 6,
            offset: Offset(4, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  // ----------------------------------------------------
  // SWITCH TILE (NOTIFICATIONS / DARK MODE)
  // ----------------------------------------------------
  Widget _switchTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
    String? subtitle,
  }) {
    return ListTile(
      leading: _circleIcon(icon),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.textDark,
        ),
      ),
      subtitle: subtitle != null
          ? Text(subtitle, style: const TextStyle(color: AppColors.textLight))
          : null,
      trailing: Switch(
        value: value,
        activeColor: AppColors.primary,
        onChanged: onChanged,
      ),
    );
  }

  // ----------------------------------------------------
  // SETTINGS TILE (language, help, privacy)
  // ----------------------------------------------------
  Widget _settingsTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: _circleIcon(icon),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColors.textDark,
        ),
      ),
      subtitle: subtitle != null
          ? Text(subtitle, style: const TextStyle(color: AppColors.textLight))
          : null,
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  // ----------------------------------------------------
  // NEUMORPHIC LEADING ICON
  // ----------------------------------------------------
  Widget _circleIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.background,
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(
            color: AppColors.lightShadow,
            blurRadius: 5,
            offset: Offset(-3, -3),
          ),
          BoxShadow(
            color: AppColors.darkShadow,
            blurRadius: 5,
            offset: Offset(3, 3),
          ),
        ],
      ),
      child: Icon(icon, color: AppColors.primary, size: 22),
    );
  }

  Widget _tileDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 18),
      child: Divider(height: 1, thickness: 0.7),
    );
  }
}
