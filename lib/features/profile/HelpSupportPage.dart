import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/neumorphic_box.dart';
import '../../core/theme/dark_mode.dart';
import 'package:provider/provider.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text("Help & Support"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          _card(
            isDark: isDark,
            child: ListTile(
              title: const Text("FAQ"),
              subtitle: const Text("Frequently asked questions"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
          ),
          const SizedBox(height: 16),
          _card(
            isDark: isDark,
            child: ListTile(
              title: const Text("Contact Support"),
              subtitle: const Text("Email or chat with support"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
          ),
          const SizedBox(height: 16),
          _card(
            isDark: isDark,
            child: ListTile(
              title: const Text("Report an Issue"),
              subtitle: const Text("Tell us what went wrong"),
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
