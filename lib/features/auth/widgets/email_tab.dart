import 'package:coach_hub/core/theme/dark_mode.dart';
import 'package:coach_hub/features/navigation/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';

import '../../../core/theme/neumorphic_box.dart';
import '../../../data/mock_users.dart';

class EmailLoginTab extends StatefulWidget {
  @override
  State<EmailLoginTab> createState() => _EmailLoginTabState();
}

class _EmailLoginTabState extends State<EmailLoginTab> {
  final emailController = TextEditingController();
  final pwdController = TextEditingController();

  bool _obscurePassword = true;

  void login() {
    final user = MockUsers.users.firstWhere(
      (u) =>
          u['email'] == emailController.text &&
          u['password'] == pwdController.text,
      orElse: () => {},
    );

    if (user.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => BottomNavBar()),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Invalid credentials")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // -----------------------
          // EMAIL FIELD
          // -----------------------
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: neumorphicBox(isDark),
            child: TextField(
              controller: emailController,
              style: TextStyle(
                color: isDark ? AppColors.darkText : AppColors.textDark,
              ),
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(
                  color: isDark ? AppColors.darkSubText : AppColors.textLight,
                ),
                border: InputBorder.none,
              ),
            ),
          ),

          const SizedBox(height: 18),

          // -----------------------
          // PASSWORD FIELD
          // -----------------------
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: neumorphicBox(isDark),
            child: TextField(
              controller: pwdController,
              obscureText: _obscurePassword,
              style: TextStyle(
                color: isDark ? AppColors.darkText : AppColors.textDark,
              ),
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle: TextStyle(
                  color: isDark ? AppColors.darkSubText : AppColors.textLight,
                ),
                border: InputBorder.none,

                // Eye toggle
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: isDark ? AppColors.darkSubText : AppColors.textLight,
                  ),
                  onPressed: () {
                    setState(() => _obscurePassword = !_obscurePassword);
                  },
                ),
              ),
            ),
          ),

          const SizedBox(height: 22),

          // -----------------------
          // LOGIN BUTTON
          // -----------------------
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: login,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 2,
              ),
              child: const Text(
                "Login",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
