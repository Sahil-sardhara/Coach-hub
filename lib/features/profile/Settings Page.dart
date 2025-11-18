import 'package:coach_hub/core/theme/dark_mode.dart';
import 'package:coach_hub/features/profile/HelpSupportPage.dart';
import 'package:coach_hub/features/profile/PrivacyPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/neumorphic_box.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notificationsEnabled = false;
  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDarkMode;
    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          "Settings",
          style: TextStyle(color: isDark ? AppColors.darkText : Colors.white),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5, bottom: 12),
            child: Text(
              "App Settings",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.darkText : AppColors.textDark,
              ),
            ),
          ),
          _neumorphicCard(
            isDark: isDark,
            child: Column(
              children: [
                _switchTile(
                  icon: Icons.notifications_none,
                  title: "Enable Notifications",
                  subtitle: "Get notified about events",
                  value: notificationsEnabled,
                  onChanged: (val) {
                    setState(() => notificationsEnabled = val);
                  },
                  isDark: isDark,
                ),
                _tileDivider(isDark),
                _switchTile(
                  icon: Icons.dark_mode_outlined,
                  title: "Dark Mode",
                  subtitle: isDark ? "Dark mode is ON" : "Dark mode is OFF",
                  value: isDark,
                  onChanged: (val) =>
                      context.read<ThemeProvider>().toggleTheme(val),
                  isDark: isDark,
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          _neumorphicCard(
            isDark: isDark,
            child: Column(
              children: [
                _settingsTile(
                  icon: Icons.language,
                  title: "Language",
                  subtitle: "English",
                  onTap: () {},
                  isDark: isDark,
                ),
                _tileDivider(isDark),
                _settingsTile(
                  icon: Icons.lock_outline,
                  title: "Privacy",
                  subtitle: "Manage your privacy & data",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const PrivacyPage()),
                    );
                  },
                  isDark: isDark,
                ),
                _tileDivider(isDark),
                _settingsTile(
                  icon: Icons.help_outline,
                  title: "Help & Support",
                  subtitle: "Get help or contact support",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const HelpSupportPage(),
                      ),
                    );
                  },
                  isDark: isDark,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _neumorphicCard({required Widget child, required bool isDark}) =>
      Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: neumorphicBox(isDark),
        child: child,
      );

  Widget _switchTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
    required bool isDark,
    String? subtitle,
  }) {
    return ListTile(
      leading: _circleIcon(icon, isDark),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isDark ? AppColors.darkText : AppColors.textDark,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyle(
                color: isDark ? AppColors.darkSubText : AppColors.textLight,
              ),
            )
          : null,
      trailing: Switch(
        value: value,
        activeColor: AppColors.primary,
        onChanged: onChanged,
      ),
    );
  }

  Widget _settingsTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required bool isDark,
    String? subtitle,
  }) {
    return ListTile(
      leading: _circleIcon(icon, isDark),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: isDark ? AppColors.darkText : AppColors.textDark,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyle(
                color: isDark ? AppColors.darkSubText : AppColors.textLight,
              ),
            )
          : null,
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: isDark ? AppColors.darkSubText : AppColors.textLight,
      ),
      onTap: onTap,
    );
  }

  Widget _circleIcon(IconData icon, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.background,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: isDark ? AppColors.darkLightShadow : AppColors.lightShadow,
            blurRadius: 5,
            offset: const Offset(-3, -3),
          ),
          BoxShadow(
            color: isDark ? AppColors.darkDarkShadow : AppColors.darkShadow,
            blurRadius: 5,
            offset: const Offset(3, 3),
          ),
        ],
      ),
      child: Icon(icon, color: AppColors.primary),
    );
  }

  Widget _tileDivider(bool isDark) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 18),
    child: Divider(
      height: 1,
      thickness: 1,
      color: isDark
          ? Colors.white.withOpacity(0.20) // visible light line
          : Colors.black.withOpacity(0.15), // visible dark line
    ),
  );
}
