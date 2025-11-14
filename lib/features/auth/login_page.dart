import 'package:coach_hub/data/mock_users.dart' show MockUsers;
import 'package:coach_hub/features/home/home_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isEmail = true;
  bool isPasswordVisible = false; // << Add this

  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
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
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 30,
                  ),
                  child: Column(
                    children: [
                      // Toggle Email / Phone (unchanged)
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.background,
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

                      // Email or Phone input
                      TextField(
                        controller: isEmail ? emailController : phoneController,
                        keyboardType: isEmail
                            ? TextInputType.emailAddress
                            : TextInputType.number, // number keyboard for phone
                        inputFormatters: isEmail
                            ? [] // no restrictions for email
                            : [
                                FilteringTextInputFormatter
                                    .digitsOnly, // only digits
                                LengthLimitingTextInputFormatter(
                                  10,
                                ), // max 10 digits
                              ],
                        decoration: InputDecoration(
                          labelText: isEmail ? "Email Address" : "Phone Number",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          prefixIcon: Icon(isEmail ? Icons.email : Icons.phone),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Password Field with Eye button
                      TextField(
                        controller: passwordController,
                        obscureText: !isPasswordVisible, // toggle obscureText
                        decoration: InputDecoration(
                          labelText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
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
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            String input = isEmail
                                ? emailController.text.trim()
                                : phoneController.text.trim();
                            String password = passwordController.text.trim();

                            // Basic validation
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

                            // Check credentials from MockUsers
                            bool isValid = false;

                            for (var user in MockUsers.users) {
                              if (isEmail &&
                                  user.containsKey("email") &&
                                  user["email"] == input &&
                                  user["password"] == password) {
                                isValid = true;
                                break;
                              } else if (!isEmail &&
                                  user.containsKey("phone") &&
                                  user["phone"] == input &&
                                  user["password"] == password) {
                                isValid = true;
                                break;
                              }
                            }

                            if (isValid) {
                              // Navigate to HomePage
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => HomePage()),
                              );
                            } else {
                              // Invalid credentials
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Invalid credentials. Please try again.",
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

              // Sign Up Rich Text
              //
            ],
          ),
        ),
      ),
    );
  }
}
