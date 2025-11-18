import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final bool isDark;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
      height: 70,

      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkBackground.withOpacity(0.95)
            : AppColors.background.withOpacity(0.95),
        borderRadius: BorderRadius.circular(25),

        // ⭐ SOFT TOP SHADOW ONLY
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, -6), // shadow only ABOVE navbar
          ),
        ],
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _item(Icons.home_rounded, "Home", 0),
          _item(Icons.video_call_rounded, "Zoom", 1),
          _item(Icons.person_rounded, "Profile", 2),
        ],
      ),
    );
  }

  Widget _item(IconData icon, String label, int index) {
    final selected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary.withOpacity(0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),

        child: Row(
          children: [
            Icon(
              icon,
              color: selected
                  ? AppColors.primary
                  : (isDark ? AppColors.darkSubText : AppColors.textLight),
              size: 28,
            ),

            if (selected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
