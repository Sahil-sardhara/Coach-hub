import 'package:coach_hub/core/theme/app_colors.dart';
import 'package:coach_hub/model/Event_Model.dart';
import 'package:flutter/material.dart';

class MockZoomMeetingPage extends StatefulWidget {
  final Event? event;

  const MockZoomMeetingPage({Key? key, this.event}) : super(key: key);

  @override
  _MockZoomMeetingPageState createState() => _MockZoomMeetingPageState();
}

class _MockZoomMeetingPageState extends State<MockZoomMeetingPage> {
  bool _inMeeting = false;
  String _meetingId = "123456"; // default mock meeting ID
  String _password = "123456"; // default password

  final TextEditingController meetingIdController = TextEditingController(
    text: "123456",
  );

  final TextEditingController passwordController = TextEditingController(
    text: "123456",
  );

  void _joinMeeting() {
    setState(() {
      _inMeeting = true;
    });
  }

  void _leaveMeeting() {
    setState(() {
      _inMeeting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _inMeeting ? _zoomMeetingUI() : _joinMeetingUI();
  }

  // -------------------------------------------------------------
  // JOIN SCREEN (Before joining meeting)
  // -------------------------------------------------------------
  Widget _joinMeetingUI() {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(widget.event?.title ?? "Join Meeting"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Neumorphic Meeting ID Field
            Container(
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.lightShadow,
                    blurRadius: 6,
                    offset: Offset(-4, -4),
                  ),
                  BoxShadow(
                    color: AppColors.darkShadow,
                    blurRadius: 6,
                    offset: Offset(4, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: meetingIdController,
                decoration: InputDecoration(
                  labelText: "Meeting ID",
                  labelStyle: const TextStyle(color: AppColors.textLight),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(16),
                ),
                onChanged: (v) => setState(() => _meetingId = v),
              ),
            ),

            const SizedBox(height: 20),

            // Neumorphic Password Field
            Container(
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.lightShadow,
                    blurRadius: 6,
                    offset: Offset(-4, -4),
                  ),
                  BoxShadow(
                    color: AppColors.darkShadow,
                    blurRadius: 6,
                    offset: Offset(4, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle: const TextStyle(color: AppColors.textLight),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(16),
                ),
                onChanged: (v) => setState(() => _password = v),
              ),
            ),

            const SizedBox(height: 30),

            // Neumorphic Join Button (Glow + Gradient)
            SizedBox(
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary.withOpacity(0.85),
                      AppColors.primary,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: _meetingId.isNotEmpty ? _joinMeeting : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "Join Meeting",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------
  // ZOOM MEETING UI
  // -------------------------------------------------------------
  Widget _zoomMeetingUI() {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _zoomTopBar(),

      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.grey[900],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.person, size: 110, color: Colors.white54),
                    const SizedBox(height: 16),
                    Text(
                      widget.event?.title ?? "Meeting $_meetingId",
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // BOTTOM ZOOM TOOLBAR
          _zoomBottomToolbar(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // -------------------------------------------------------------
  // TOP BAR LIKE ZOOM
  // -------------------------------------------------------------
  AppBar _zoomTopBar() {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      title: Text(
        "Meeting ID: $_meetingId",
        style: const TextStyle(fontSize: 16),
      ),
      actions: [
        TextButton(
          onPressed: _leaveMeeting,
          child: const Text(
            "Leave",
            style: TextStyle(color: Colors.red, fontSize: 16),
          ),
        ),
      ],
    );
  }

  // -------------------------------------------------------------
  // ZOOM BOTTOM TOOLBAR
  // -------------------------------------------------------------
  Widget _zoomBottomToolbar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      color: Colors.black87,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _zoomButton(Icons.mic_off, "Mute"),
          _zoomButton(Icons.videocam_off, "Stop Video"),
          _zoomButton(Icons.share, "Share"),
          _zoomButton(Icons.people, "Participants"),
          _zoomButton(Icons.more_horiz, "More"),
        ],
      ),
    );
  }

  // Generic Zoom button
  Widget _zoomButton(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }
}
