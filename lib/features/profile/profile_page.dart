import 'package:coach_hub/core/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/dark_mode.dart';
import 'EditProfilePage.dart';
import 'Terms & Conditions Page.dart';
import 'Settings Page.dart';
import 'About Page.dart';
import '../auth/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final profile = Provider.of<ProfileProvider>(context);

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primary, Colors.blueAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                  ),
                ),
                Positioned(
                  top: 130,
                  left: MediaQuery.of(context).size.width / 2 - 60,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 56,
                          backgroundColor: AppColors.primary.withOpacity(0.2),
                          child: Text(
                            profile.name[0].toUpperCase(),
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () async {
                            final updatedProfile = await Navigator.push(
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

                            if (updatedProfile != null &&
                                updatedProfile is Map<String, String>) {
                              setState(() {
                                profile.name =
                                    updatedProfile['name'] ?? profile.name;
                                profile.course =
                                    updatedProfile['course'] ?? profile.course;
                                profile.location =
                                    updatedProfile['location'] ??
                                    profile.location;
                                profile.email =
                                    updatedProfile['email'] ?? profile.email;
                                profile.phone =
                                    updatedProfile['phone'] ?? profile.phone;
                              });
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(8),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 65),
            Column(
              children: [
                Text(
                  profile.name,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  profile.email,
                  style: TextStyle(
                    fontSize: 16,
                    color: isDark ? Colors.white70 : AppColors.textLight,
                  ),
                ),
                const SizedBox(height: 4),

                const SizedBox(height: 10),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _buildMenuCard(
                    icon: Icons.edit,
                    title: "Edit Profile",
                    onTap: () async {
                      final updatedProfile = await Navigator.push(
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

                      if (updatedProfile != null &&
                          updatedProfile is Map<String, String>) {
                        setState(() {
                          profile.name = updatedProfile['name'] ?? profile.name;
                          profile.course =
                              updatedProfile['course'] ?? profile.course;
                          profile.location =
                              updatedProfile['location'] ?? profile.location;
                        });
                      }
                    },
                  ),
                  _buildMenuCard(
                    icon: Icons.description,
                    title: "Terms & Conditions",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const TermsPage()),
                      );
                    },
                  ),
                  _buildMenuCard(
                    icon: Icons.settings,
                    title: "Settings",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SettingsPage()),
                      );
                    },
                  ),
                  _buildMenuCard(
                    icon: Icons.info,
                    title: "About",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AboutPage()),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _showLogoutDialog,
                      icon: const Icon(Icons.logout),
                      label: const Text(
                        "Logout",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850] : Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary, size: 25),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to logout?"),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: const Text("Confirm"),
          ),
        ],
      ),
    );
  }
}
