import 'package:coach_hub/core/theme/dark_mode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';

class MockZoomMeetingPage extends StatefulWidget {
  const MockZoomMeetingPage({super.key});

  @override
  State<MockZoomMeetingPage> createState() => _MockZoomMeetingPageState();
}

class _MockZoomMeetingPageState extends State<MockZoomMeetingPage> {
  bool inMeeting = false;
  bool obscure = true;

  bool micOn = true;
  bool camOn = true;
  bool speakerOn = true;

  final idCtrl = TextEditingController(text: "123456");
  final pwdCtrl = TextEditingController(text: "123456");

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDarkMode;

    return inMeeting ? _meetingUI(isDark) : _joinUI(isDark);
  }

  // -----------------------------------------------------
  // JOIN PAGE
  // -----------------------------------------------------
  Widget _joinUI(bool isDark) {
    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.background,
      appBar: AppBar(title: const Text("Join Meeting")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _neumorphicField(idCtrl, "Meeting ID", false, isDark),
            const SizedBox(height: 16),
            _neumorphicField(pwdCtrl, "Password", true, isDark),
            const SizedBox(height: 32),

            // ----------------------------------
            // JOIN BUTTON (same as EventDetail)
            // ----------------------------------
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => setState(() => inMeeting = true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Join Meeting",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _neumorphicField(
    TextEditingController c,
    String label,
    bool isPassword,
    bool isDark,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkBackground : AppColors.background,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black54 : AppColors.lightShadow,
            offset: const Offset(-4, -4),
            blurRadius: 6,
          ),
          BoxShadow(
            color: isDark ? Colors.black87 : AppColors.darkShadow,
            offset: const Offset(4, 4),
            blurRadius: 6,
          ),
        ],
      ),
      child: TextField(
        controller: c,
        obscureText: isPassword ? obscure : false,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: label,
          contentPadding: const EdgeInsets.all(16),
          suffixIcon: isPassword
              ? IconButton(
                  onPressed: () => setState(() => obscure = !obscure),
                  icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
                )
              : null,
        ),
      ),
    );
  }

  Widget _meetingUI(bool isDark) {
    final bgColor = isDark ? AppColors.darkBackground : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final iconColor = isDark ? Colors.white : Colors.black87;

    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          // -------------------------
          // Fake camera preview
          // -------------------------
          Center(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: isDark ? Colors.black54 : Colors.grey.shade300,
              child: camOn
                  ? Icon(
                      Icons.person,
                      size: 120,
                      color: isDark ? Colors.white24 : Colors.black26,
                    )
                  : Icon(
                      Icons.videocam_off,
                      size: 120,
                      color: isDark ? Colors.white30 : Colors.black38,
                    ),
            ),
          ),

          // -------------------------
          // TOP BAR
          // -------------------------
          Positioned(
            top: 40,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Meeting",
                  style: TextStyle(
                    color: textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                GestureDetector(
                  onTap: () => setState(() => inMeeting = false),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "Leave",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // -------------------------
          // BOTTOM CONTROL BAR
          // -------------------------
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _controlButton(
                  icon: micOn ? Icons.mic : Icons.mic_off,
                  label: "Mute",
                  active: micOn,
                  isDark: isDark,
                  onTap: () => setState(() => micOn = !micOn),
                ),
                _controlButton(
                  icon: camOn ? Icons.videocam : Icons.videocam_off,
                  label: "Video",
                  active: camOn,
                  isDark: isDark,
                  onTap: () => setState(() => camOn = !camOn),
                ),
                _controlButton(
                  icon: speakerOn ? Icons.volume_up : Icons.volume_off,
                  label: "Speaker",
                  active: speakerOn,
                  isDark: isDark,
                  onTap: () => setState(() => speakerOn = !speakerOn),
                ),
                _controlButton(
                  icon: Icons.cameraswitch,
                  label: "Switch",
                  active: true,
                  isDark: isDark,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _controlButton({
    required IconData icon,
    required String label,
    required bool active,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    final activeBg = isDark ? Colors.white : Colors.black;
    final inactiveBg = isDark
        ? Colors.white.withOpacity(0.15)
        : Colors.black.withOpacity(0.1);

    final activeIcon = isDark ? Colors.black : Colors.white;
    final inactiveIcon = isDark ? Colors.white : Colors.black87;

    final textColor = isDark ? Colors.white70 : Colors.black54;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: active ? activeBg : inactiveBg,
            child: Icon(
              icon,
              size: 28,
              color: active ? activeIcon : inactiveIcon,
            ),
          ),
          const SizedBox(height: 6),
          Text(label, style: TextStyle(color: textColor)),
        ],
      ),
    );
  }
}
