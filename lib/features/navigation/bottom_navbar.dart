import 'package:coach_hub/core/theme/app_colors.dart';
import 'package:coach_hub/features/auth/zoom/mock_zoom_meeting_page.dart';
import 'package:coach_hub/features/auth/zoom/zoom_meeting_page.dart';
import 'package:coach_hub/features/home/home_page.dart';
import 'package:coach_hub/features/profile/profile_page.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int index = 0;

  final pages = [HomePage(), MockZoomMeetingPage(), ProfilePage()];

  final appBarTitles = ["Events", "Zoom Meetings", "Profile"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appBarTitles[index])),
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        onTap: (i) => setState(() => index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.event), label: "Events"),
          BottomNavigationBarItem(icon: Icon(Icons.video_call), label: "Zoom"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
