import 'package:flutter/material.dart';
import 'app_colors.dart';

BoxDecoration neumorphicBox(bool isDark) {
  return BoxDecoration(
    color: isDark ? AppColors.darkCard : AppColors.background,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: isDark ? AppColors.darkLightShadow : AppColors.lightShadow,
        offset: const Offset(-4, -4),
        blurRadius: 6,
      ),
      BoxShadow(
        color: isDark ? AppColors.darkDarkShadow : AppColors.darkShadow,
        offset: const Offset(4, 4),
        blurRadius: 6,
      ),
    ],
  );
}
