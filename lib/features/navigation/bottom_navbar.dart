import 'package:coach_hub/core/theme/dark_mode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../home/home_page.dart';
import '../zoom/mock_zoom_meeting_page.dart';
import '../profile/profile_page.dart';
import 'CustomBottomNavBar.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDarkMode;

    final pages = [HomePage(), MockZoomMeetingPage(), ProfilePage()];

    return Scaffold(
      body: IndexedStack(index: index, children: pages),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: index,
        isDark: isDark,
        onTap: (i) => setState(() => index = i),
      ),
    );
  }
}
