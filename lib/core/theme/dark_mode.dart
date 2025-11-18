import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _mode = ThemeMode.light;

  ThemeMode get themeMode => _mode;
  bool get isDarkMode => _mode == ThemeMode.dark;

  void toggleTheme(bool on) {
    _mode = on ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void setDark() {
    _mode = ThemeMode.dark;
    notifyListeners();
  }

  void setLight() {
    _mode = ThemeMode.light;
    notifyListeners();
  }
}
