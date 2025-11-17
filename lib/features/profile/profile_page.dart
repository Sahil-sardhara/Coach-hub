import 'package:coach_hub/core/profile_provider.dart';
import 'package:coach_hub/features/profile/About%20Page.dart';
import 'package:coach_hub/features/profile/EditProfilePage.dart';
import 'package:coach_hub/features/profile/Settings%20Page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/dark_mode.dart';
import '../auth/login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;
    final profile = Provider.of<ProfileProvider>(context);

    return Scaffold(
      backgroundColor: isDark ? Colors.black : const Color(0xffF2F3F7),

      body: SafeArea(
        child: Column(
          children: [
            // ---------------- HEADER ----------------
            _buildHeader(profile),

            const SizedBox(height: 20),

            // ---------------- SETTINGS LIST ----------------
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // _settingsTile(
                    //   icon: Icons.notifications_rounded,
                    //   title: "Notifications",
                    //   subtitle: "Manage your reminders",
                    //   onTap: () {},
                    // ),
                    _settingsTile(
                      icon: Icons.edit,
                      title: "Edit Profile",
                      subtitle: "Update your personal details",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditProfilePage(
                              name: profile.name,
                              course: profile.course,
                              location: profile.location,
                              email: profile.email,
                              phone: profile.phone,
                            ),
                          ),
                        );
                      },
                    ),
                    _settingsTile(
                      icon: Icons.settings,
                      title: "Setting",
                      subtitle: "Manage your app preferences",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => SettingsPage()),
                        );
                      },
                    ),
                    _settingsTile(
                      icon: Icons.info_outline_rounded,
                      title: "About",
                      subtitle: "App version 1.0.0",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => AboutPage()),
                        );
                      },
                    ),
                    _settingsTile(
                      icon: Icons.logout_rounded,
                      title: "Logout",
                      subtitle: "Sign out of your account",
                      onTap: () => _showLogoutDialog(context),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // HEADER WITH GLOW AVATAR
  // ----------------------------------------------------------
  Widget _buildHeader(ProfileProvider profile) {
    return Container(
      height: 190,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xffF8F9FB), Color(0xffECEEF3)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Avatar glow
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.4),
                    blurRadius: 25,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 42,
                backgroundColor: AppColors.primary.withOpacity(0.15),
                child: Icon(Icons.person, size: 50, color: AppColors.primary),
              ),
            ),

            const SizedBox(height: 10),

            Text(
              profile.name,
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Color(0xff222222),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // SETTINGS TILE (NEUMORPHISM STYLE)
  // ----------------------------------------------------------
  Widget _settingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xffF2F3F7),
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(color: Colors.white, blurRadius: 6, offset: Offset(-4, -4)),
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(4, 4)),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 18,
        ),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.primary),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 13, color: Colors.black54),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  // ----------------------------------------------------------
  // LOGOUT POPUP
  // ----------------------------------------------------------
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: const Text("Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
              );
            },
            child: const Text("Confirm", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
