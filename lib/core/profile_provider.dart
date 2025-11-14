import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  String name = "Student User";
  String course = "Flutter Developer";
  String location = "New York, USA";
  String email = "student@test.com";
  String phone = "+123 456 7890";

  void updateProfile({
    String? name,
    String? course,
    String? location,
    String? email,
    String? phone,
  }) {
    if (name != null) this.name = name;
    if (course != null) this.course = course;
    if (location != null) this.location = location;
    if (email != null) this.email = email;
    if (phone != null) this.phone = phone;
    notifyListeners(); // notify widgets to rebuild
  }
}
