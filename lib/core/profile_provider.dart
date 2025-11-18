import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  String _name = "John Doe";
  String _email = "john@example.com";

  String get name => _name;
  String get email => _email;

  void update({required String name, required String email}) {
    _name = name;
    _email = email;
    notifyListeners();
  }
}
