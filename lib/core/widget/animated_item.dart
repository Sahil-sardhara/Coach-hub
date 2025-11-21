import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AnimatedItem extends StatelessWidget {
  final int position;
  final Widget child;
  final double offset;

  const AnimatedItem({
    super.key,
    required this.position,
    required this.child,
    this.offset = 40,
  });

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: position,
      delay: const Duration(milliseconds: 100),
      child: SlideAnimation(
        horizontalOffset: offset,
        verticalOffset: offset * -0.5,
        curve: Curves.easeOutCubic,
        duration: const Duration(milliseconds: 220),
        child: FadeInAnimation(
          duration: const Duration(milliseconds: 160),
          child: child,
        ),
      ),
    );
  }
}
