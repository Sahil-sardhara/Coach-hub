import 'package:coach_hub/features/navigation/bottom_navbar.dart';
import 'package:flutter/material.dart';
import '../../../data/mock_users.dart';

class EmailLoginTab extends StatefulWidget {
  @override
  State<EmailLoginTab> createState() => _EmailLoginTabState();
}

class _EmailLoginTabState extends State<EmailLoginTab> {
  final emailController = TextEditingController();
  final pwdController = TextEditingController();

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
      ).showSnackBar(SnackBar(content: Text("Invalid credentials")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            controller: emailController,
            decoration: InputDecoration(labelText: "Email"),
          ),
          TextField(
            controller: pwdController,
            decoration: InputDecoration(labelText: "Password"),
            obscureText: true,
          ),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: login, child: Text("Login")),
        ],
      ),
    );
  }
}
