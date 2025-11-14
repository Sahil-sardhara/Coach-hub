// import 'package:flutter/material.dart';
// import 'zoom_service.dart';

// class ZoomMeetingPage extends StatefulWidget {
//   @override
//   State<ZoomMeetingPage> createState() => _ZoomMeetingPageState();
// }

// class _ZoomMeetingPageState extends State<ZoomMeetingPage> {
//   final meetingId = TextEditingController();
//   final pwd = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Join Zoom Meeting")),
//       body: Padding(
//         padding: const EdgeInsets.all(18),
//         child: Column(
//           children: [
//             TextField(
//               controller: meetingId,
//               decoration: InputDecoration(labelText: "Meeting ID"),
//             ),
//             TextField(
//               controller: pwd,
//               decoration: InputDecoration(labelText: "Password"),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 ZoomService.joinMeeting(
//                   meetingId: meetingId.text,
//                   password: pwd.text,
//                 );
//               },
//               child: Text("Join"),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
