import 'package:coach_hub/features/zoom/mock_zoom_meeting_page.dart';
import 'package:coach_hub/features/navigation/CustomBottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:coach_hub/features/home/home_page.dart';
import 'package:coach_hub/features/profile/profile_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int index = 0;

  final pages = [HomePage(), const MockZoomMeetingPage(), const ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: index,
        onTap: (i) {
          setState(() => index = i);
        },
      ),
    );
  }
}
