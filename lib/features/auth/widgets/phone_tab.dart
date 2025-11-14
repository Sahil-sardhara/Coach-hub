import 'package:flutter/material.dart';

class PhoneLoginTab extends StatelessWidget {
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            controller: phoneController,
            decoration: InputDecoration(labelText: "Phone Number"),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Mock OTP flow
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => Text("OTP page TODO")),
              );
            },
            child: Text("Send OTP"),
          ),
        ],
      ),
    );
  }
}
