import 'package:animations/animations.dart';
import 'package:coach_hub/core/theme/app_colors.dart';
import 'package:coach_hub/core/theme/dark_mode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../home/home_page.dart';
import '../zoom/mock_zoom_meeting_page.dart';
import '../profile/profile_page.dart';
import 'CustomBottomNavBar.dart';

class BottomNavBar extends StatefulWidget {
  final bool showLoginSuccess;
  const BottomNavBar({super.key, this.showLoginSuccess = false});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int index = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.showLoginSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Login Successful!"),
            backgroundColor: AppColors.primary,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDarkMode;

    final pages = [HomePage(), MockZoomMeetingPage(), ProfilePage()];

    return Scaffold(
      body: PageTransitionSwitcher(
        duration: const Duration(milliseconds: 350),
        transitionBuilder: (child, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.05, 0), // slight slide from right
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
        child: KeyedSubtree(key: ValueKey(index), child: pages[index]),
      ),

      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: index,
        isDark: isDark,
        onTap: (i) => setState(() => index = i),
      ),
    );
  }
}
