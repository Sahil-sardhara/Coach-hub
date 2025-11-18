import 'package:coach_hub/core/theme/dark_mode.dart';
import 'package:coach_hub/data/mock_users.dart';
import 'package:coach_hub/features/navigation/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/neumorphic_box.dart';

class LoginPage extends StatefulWidget {
  final bool showLogoutSuccess;
  const LoginPage({super.key, this.showLogoutSuccess = false});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isPasswordVisible = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.showLogoutSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Logout Successful!"),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.background,

      // --------------------------------------------------
      // NO APP BAR
      // --------------------------------------------------
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double screenHeight = constraints.maxHeight;
            double screenWidth = constraints.maxWidth;

            return Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize:
                      MainAxisSize.min, // important for perfect centering
                  children: [
                    // TOP TITLE
                    Text(
                      "Login",
                      style: TextStyle(
                        fontSize: screenWidth * 0.08,
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppColors.darkText : AppColors.textDark,
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.015),

                    // WELCOME TEXT
                    Text(
                      "Welcome Back!!",
                      style: TextStyle(
                        fontSize: screenWidth * 0.07,
                        fontWeight: FontWeight.w600,
                        color: isDark ? AppColors.darkText : AppColors.textDark,
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.005),

                    Text(
                      "Login to continue your learning",
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        color: isDark
                            ? AppColors.darkSubText
                            : AppColors.textLight,
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.04),

                    // LOGIN CARD
                    Container(
                      decoration: neumorphicBox(isDark),
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.06,
                        vertical: screenHeight * 0.04,
                      ),
                      child: Column(
                        children: [
                          // EMAIL FIELD
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.05,
                              vertical: screenHeight * 0.005,
                            ),
                            decoration: neumorphicBox(isDark),
                            child: TextField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                color: isDark
                                    ? AppColors.darkText
                                    : AppColors.textDark,
                              ),
                              decoration: const InputDecoration(
                                labelText: "Email Address",
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.email),
                              ),
                            ),
                          ),

                          SizedBox(height: screenHeight * 0.02),

                          // PASSWORD FIELD
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.05,
                              vertical: screenHeight * 0.005,
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
                                prefixIcon: const Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: AppColors.textLight,
                                  ),
                                  onPressed: () => setState(
                                    () =>
                                        isPasswordVisible = !isPasswordVisible,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: screenHeight * 0.035),

                          // LOGIN BUTTON
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                final email = emailController.text.trim();
                                final password = passwordController.text.trim();

                                // -------------------------------
                                // EMPTY CHECK
                                // -------------------------------
                                if (email.isEmpty || password.isEmpty) {
                                  _showError("Please fill all fields");
                                  return;
                                }

                                // -------------------------------
                                // EMAIL VALIDATION
                                // -------------------------------
                                bool isValidEmail = RegExp(
                                  r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$",
                                ).hasMatch(email);

                                if (!isValidEmail) {
                                  _showError(
                                    "Please enter a valid email address",
                                  );
                                  return;
                                }

                                // -------------------------------
                                // PASSWORD MINIMUM LENGTH
                                // -------------------------------
                                if (password.length < 6) {
                                  _showError(
                                    "Password must be at least 6 characters",
                                  );
                                  return;
                                }

                                // -------------------------------
                                // SUCCESS → ALLOW LOGIN ALWAYS
                                // -------------------------------
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const BottomNavBar(
                                      showLoginSuccess: true,
                                    ),
                                  ),
                                );
                              },

                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                padding: EdgeInsets.symmetric(
                                  vertical: screenHeight * 0.018,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: Text(
                                "Login",

                                style: TextStyle(
                                  fontSize: screenWidth * 0.045,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.05),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppColors.primary),
    );
  }
}
