// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import '../../core/theme/app_colors.dart';
// import 'login_page.dart';

// class SignupPage extends StatefulWidget {
//   const SignupPage({super.key});

//   @override
//   State<SignupPage> createState() => _SignupPageState();
// }

// class _SignupPageState extends State<SignupPage> {
//   bool isEmail = true;

//   final nameController = TextEditingController();
//   final emailController = TextEditingController();
//   final phoneController = TextEditingController();
//   final passwordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       appBar: AppBar(
//         title: const Text("Create Account"),
//         backgroundColor: AppColors.primary,
//         elevation: 0,
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             children: [
//               // ==== CARD ====
//               Card(
//                 elevation: 8,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: Column(
//                     children: [
//                       // ===== TOGGLE (email/phone) =====
//                       Container(
//                         decoration: BoxDecoration(
//                           color: AppColors.background,
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: GestureDetector(
//                                 onTap: () => setState(() => isEmail = true),
//                                 child: Container(
//                                   padding: const EdgeInsets.symmetric(
//                                     vertical: 10,
//                                   ),
//                                   decoration: BoxDecoration(
//                                     color: isEmail
//                                         ? AppColors.primary
//                                         : Colors.transparent,
//                                     borderRadius: BorderRadius.circular(30),
//                                   ),
//                                   alignment: Alignment.center,
//                                   child: Text(
//                                     "Email",
//                                     style: TextStyle(
//                                       color: isEmail
//                                           ? Colors.white
//                                           : AppColors.textLight,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               child: GestureDetector(
//                                 onTap: () => setState(() => isEmail = false),
//                                 child: Container(
//                                   padding: const EdgeInsets.symmetric(
//                                     vertical: 10,
//                                   ),
//                                   decoration: BoxDecoration(
//                                     color: !isEmail
//                                         ? AppColors.primary
//                                         : Colors.transparent,
//                                     borderRadius: BorderRadius.circular(30),
//                                   ),
//                                   alignment: Alignment.center,
//                                   child: Text(
//                                     "Phone",
//                                     style: TextStyle(
//                                       color: !isEmail
//                                           ? Colors.white
//                                           : AppColors.textLight,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),

//                       const SizedBox(height: 25),

//                       // ==== NAME ====
//                       TextField(
//                         controller: nameController,
//                         decoration: InputDecoration(
//                           labelText: "Full Name",
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 15),

//                       // ==== EMAIL OR PHONE ====
//                       if (isEmail)
//                         TextField(
//                           controller: emailController,
//                           keyboardType: TextInputType.emailAddress,
//                           decoration: InputDecoration(
//                             labelText: "Email Address",
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                         )
//                       else
//                         TextField(
//                           controller: phoneController,
//                           keyboardType: TextInputType.phone,
//                           decoration: InputDecoration(
//                             labelText: "Phone Number",
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                         ),

//                       const SizedBox(height: 15),

//                       // ==== PASSWORD ====
//                       TextField(
//                         controller: passwordController,
//                         obscureText: true,
//                         decoration: InputDecoration(
//                           labelText: "Password",
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 15),

//                       // ==== CONFIRM PASSWORD ====
//                       TextField(
//                         controller: confirmPasswordController,
//                         obscureText: true,
//                         decoration: InputDecoration(
//                           labelText: "Confirm Password",
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 25),

//                       // ==== SIGN UP BUTTON ====
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: AppColors.primary,
//                             padding: const EdgeInsets.symmetric(vertical: 14),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           ),
//                           onPressed: () {
//                             // TODO: implement signup logic
//                           },
//                           child: const Text(
//                             "Create Account",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 25),

//               // ==== RICH TEXT (already have account?) ====
//               RichText(
//                 text: TextSpan(
//                   text: "Already have an account? ",
//                   style: const TextStyle(
//                     color: AppColors.textDark,
//                     fontSize: 14,
//                   ),
//                   children: [
//                     TextSpan(
//                       text: "Login",
//                       style: const TextStyle(
//                         color: AppColors.primary,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       recognizer: TapGestureRecognizer()
//                         ..onTap = () {
//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                               builder: (_) => const LoginPage(),
//                             ),
//                           );
//                         },
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
