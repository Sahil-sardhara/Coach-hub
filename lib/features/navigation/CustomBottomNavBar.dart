import 'package:coach_hub/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
      height: 70,
      decoration: BoxDecoration(
        color: AppColors.background, // SAME THEME COLOR
        borderRadius: BorderRadius.circular(25),

        // NEUMORPHIC EFFECT
        boxShadow: const [
          BoxShadow(
            color: AppColors.lightShadow, // top-left highlight
            blurRadius: 12,
            offset: Offset(-4, -4),
          ),
          BoxShadow(
            color: AppColors.darkShadow, // bottom-right shadow
            blurRadius: 12,
            offset: Offset(4, 4),
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
        duration: const Duration(milliseconds: 220),

        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary.withOpacity(0.15)
              : Colors.transparent,

          borderRadius: BorderRadius.circular(15),

          // subtle inner shadow when selected
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),

        child: Row(
          children: [
            Icon(
              icon,
              size: 28,
              color: selected ? AppColors.primary : AppColors.textLight,
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
