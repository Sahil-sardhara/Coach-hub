import 'package:flutter/material.dart';

class AppColors {
  // ---------------------------------------------------------
  // BRAND COLORS
  // ---------------------------------------------------------
  static const primary = Color.fromARGB(255, 7, 134, 50);
  // Your main green (used on buttons, icons, highlights)

  static const secondary = Color(0xFF5A85F0);
  // Not heavily used but kept for design flexibility

  // ---------------------------------------------------------
  // TEXT COLORS
  // ---------------------------------------------------------
  static const textDark = Color(0xFF1A1A1A); // Main dark text
  static const textLight = Color(0xFF6D6D6D); // Subtitle / grey text

  // ---------------------------------------------------------
  // BACKGROUND COLORS (Neumorphism)
  // ---------------------------------------------------------
  static const background = Color(0xffF2F3F7);
  // SAME background used on:
  // ✔ Profile page
  // ✔ Home page
  // ✔ Neumorphic cards
  // ✔ Search bar
  // This is the most important UI color in your theme.

  // ---------------------------------------------------------
  // CARD BACKGROUND (light green hint)
  // ---------------------------------------------------------
  static const cardBackground = Color(0xFFE8F5E9);
  // Very light mint green (Material Green 50)

  // ---------------------------------------------------------
  // NEUMORPHISM SHADOWS
  // ---------------------------------------------------------
  static const lightShadow = Colors.white;
  static const darkShadow = Color.fromARGB(30, 0, 0, 0); // soft black12

  // ---------------------------------------------------------
  // OPTIONAL EXTRA COLORS (if needed later)
  // ---------------------------------------------------------
  static const danger = Color(0xFFE53935); // Red warning/logout
  static const success = Color(0xFF4CAF50); // Success green
  static const warning = Color(0xFFFFC107); // Yellow warning
}
