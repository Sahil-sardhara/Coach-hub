import 'package:coach_hub/core/theme/dark_mode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/neumorphic_box.dart';

class PhoneLoginTab extends StatefulWidget {
  @override
  State<PhoneLoginTab> createState() => _PhoneLoginTabState();
}

class _PhoneLoginTabState extends State<PhoneLoginTab> {
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // ------------------------------------------------
          // PHONE NUMBER FIELD (Neumorphic)
          // ------------------------------------------------
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: neumorphicBox(isDark),
            child: TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              style: TextStyle(
                color: isDark ? AppColors.darkText : AppColors.textDark,
              ),
              decoration: InputDecoration(
                labelText: "Phone Number",
                labelStyle: TextStyle(
                  color: isDark ? AppColors.darkSubText : AppColors.textLight,
                ),
                border: InputBorder.none,
              ),
            ),
          ),

          const SizedBox(height: 22),

          // ------------------------------------------------
          // SEND OTP BUTTON
          // ------------------------------------------------
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const Center(child: Text("OTP Page TODO")),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                "Send OTP",
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
