import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/neumorphic_box.dart';
import '../../core/theme/dark_mode.dart';
import 'package:provider/provider.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text("Privacy"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          _card(
            isDark: isDark,
            child: ListTile(
              title: const Text("Data Usage"),
              subtitle: const Text("How we collect and use your data"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
          ),
          const SizedBox(height: 16),
          _card(
            isDark: isDark,
            child: ListTile(
              title: const Text("Permissions"),
              subtitle: const Text("Camera, microphone, storage"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
          ),
          const SizedBox(height: 16),
          _card(
            isDark: isDark,
            child: ListTile(
              title: const Text("Delete Account"),
              subtitle: const Text("Request permanent account deletion"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _card({required Widget child, required bool isDark}) {
    return Container(decoration: neumorphicBox(isDark), child: child);
  }
}
