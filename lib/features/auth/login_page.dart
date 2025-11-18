import 'package:coach_hub/core/theme/dark_mode.dart';
import 'package:coach_hub/data/mock_users.dart';
import 'package:coach_hub/features/navigation/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/neumorphic_box.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isEmail = true;
  bool isPasswordVisible = false;

  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.background,
      appBar: AppBar(
        title: const Text("Student Login"),
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Container(
                decoration: neumorphicBox(isDark),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 30,
                  ),
                  child: Column(
                    children: [
                      // ----------------------------------------------------
                      // EMAIL / PHONE TOGGLE
                      // ----------------------------------------------------
                      Container(
                        decoration: BoxDecoration(
                          color: isDark
                              ? AppColors.darkBackground
                              : AppColors.background,
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: AppColors.primary.withOpacity(0.4),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setState(() => isEmail = true),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: isEmail
                                        ? AppColors.primary
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Email",
                                    style: TextStyle(
                                      color: isEmail
                                          ? Colors.white
                                          : AppColors.textLight,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setState(() => isEmail = false),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: !isEmail
                                        ? AppColors.primary
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Phone",
                                    style: TextStyle(
                                      color: !isEmail
                                          ? Colors.white
                                          : AppColors.textLight,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                      // ----------------------------------------------------
                      // EMAIL / PHONE INPUT (NEUMORPHIC)
                      // ----------------------------------------------------
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 4,
                        ),
                        decoration: neumorphicBox(isDark),
                        child: TextField(
                          controller: isEmail
                              ? emailController
                              : phoneController,
                          keyboardType: isEmail
                              ? TextInputType.emailAddress
                              : TextInputType.number,
                          inputFormatters: isEmail
                              ? []
                              : [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(10),
                                ],
                          style: TextStyle(
                            color: isDark
                                ? AppColors.darkText
                                : AppColors.textDark,
                          ),
                          decoration: InputDecoration(
                            labelText: isEmail
                                ? "Email Address"
                                : "Phone Number",
                            labelStyle: TextStyle(
                              color: isDark
                                  ? AppColors.darkSubText
                                  : AppColors.textLight,
                            ),
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              isEmail ? Icons.email : Icons.phone,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // ----------------------------------------------------
                      // PASSWORD FIELD (NEUMORPHIC)
                      // ----------------------------------------------------
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 4,
                        ),
                        decoration: neumorphicBox(isDark),
                        child: TextField(
                          controller: passwordController,
                          obscureText: !isPasswordVisible,
                          style: TextStyle(
                            color: isDark
                                ? AppColors.darkText
                                : AppColors.textDark,
                          ),
                          decoration: InputDecoration(
                            labelText: "Password",
                            border: InputBorder.none,
                            labelStyle: TextStyle(
                              color: isDark
                                  ? AppColors.darkSubText
                                  : AppColors.textLight,
                            ),
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(
                                isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppColors.textLight,
                              ),
                              onPressed: () {
                                setState(
                                  () => isPasswordVisible = !isPasswordVisible,
                                );
                              },
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // ----------------------------------------------------
                      // LOGIN BUTTON
                      // ----------------------------------------------------
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            String input = isEmail
                                ? emailController.text.trim()
                                : phoneController.text.trim();
                            String password = passwordController.text.trim();

                            if (input.isEmpty || password.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Please fill all fields"),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }

                            if (!isEmail && input.length != 10) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Phone number must be 10 digits",
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }

                            bool isValid = MockUsers.users.any((user) {
                              if (isEmail &&
                                  user["email"] == input &&
                                  user["password"] == password) {
                                return true;
                              }
                              if (!isEmail &&
                                  user["phone"] == input &&
                                  user["password"] == password) {
                                return true;
                              }
                              return false;
                            });

                            if (isValid) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BottomNavBar(), // FIXED
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Invalid credentials. Try again.",
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
