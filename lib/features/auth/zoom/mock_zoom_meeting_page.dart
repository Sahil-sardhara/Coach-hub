import 'package:coach_hub/model/Event_Model.dart';
import 'package:flutter/material.dart';

class MockZoomMeetingPage extends StatefulWidget {
  final Event? event; // optional, can pass the event info

  const MockZoomMeetingPage({Key? key, this.event}) : super(key: key);

  @override
  _MockZoomMeetingPageState createState() => _MockZoomMeetingPageState();
}

class _MockZoomMeetingPageState extends State<MockZoomMeetingPage> {
  bool _inMeeting = false;
  String _meetingId = '';
  String _password = '';

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
    if (!_inMeeting) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.event?.title ?? 'Mock Meeting'),
          backgroundColor: Colors.blueAccent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Meeting ID'),
                onChanged: (v) => _meetingId = v,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Password'),
                onChanged: (v) => _password = v,
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_meetingId.isNotEmpty) {
                    _joinMeeting();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Enter Meeting ID')),
                    );
                  }
                },
                child: const Text('Join Mock Meeting'),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.event?.title ?? 'In Meeting: $_meetingId'),
          actions: [
            IconButton(
              icon: const Icon(Icons.call_end, color: Colors.red),
              onPressed: _leaveMeeting,
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.videocam, size: 120, color: Colors.grey),
              const SizedBox(height: 20),
              Text(
                'You are in meeting $_meetingId',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _leaveMeeting,
                child: const Text('Leave Meeting'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
            ],
          ),
        ),
      );
    }
  }
}
