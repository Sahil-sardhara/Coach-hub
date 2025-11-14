import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'package:coach_hub/model/Event_Model.dart';
import '../auth/zoom/mock_zoom_meeting_page.dart';

class EventDetailPage extends StatelessWidget {
  final Event event;

  const EventDetailPage({super.key, required this.event});

  // Helper function to extract only the time (e.g., "3:00 PM")
  String _extractTimeOnly(String formattedTime) {
    // formattedTime is like: "3:00 PM, 15 Nov, 2025"
    // Gets the first part before the first comma.
    return formattedTime.split(',')[0].trim();
  }

  // Helper function to extract only the date (e.g., "15 Nov, 2025")
  String _extractDateOnly(String formattedTime) {
    // formattedTime is like: "3:00 PM, 15 Nov, 2025"
    final parts = formattedTime.split(',');
    if (parts.length > 2) {
      // Recombines the date and year parts, index 1 and 2
      return "${parts[1].trim()}, ${parts[2].trim()}";
    }
    return 'Date Unavailable';
  }

  // MOCK DATA for demonstration
  static const String displayTimeZone = "IST (UTC+5:30)";
  static const String displayPrice = "\SAR 29.99";
  static const double verticalAlignmentSpacerWidth = 80.0;

  // MOCK DATA for Recorded Videos (Only need title and duration now)
  final List<Map<String, String>> recordedVideos = const [
    {"title": "Session 1: Warm-up", "duration": "15 min"},
    {"title": "Session 2: Main Drill", "duration": "45 min"},
    {"title": "Session 3: Cool Down", "duration": "10 min"},
  ];

  // MOCK DATA for Contract
  static const String mockContractTerms = """
    1. The participant agrees to attend the event on the specified date and time.
    2. Fees (SAR 29.99) are non-refundable unless the event is cancelled by the organizer.
    3. All content, including recorded sessions, is the intellectual property of Coach Hub. 
    4. By clicking 'Accept' on the main page, you acknowledge and agree to these terms.
  """;

  // --- Contract Dialog Function ---
  void _showContractDialog(
    BuildContext context,
    String title,
    String time,
    String date,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            "Event Contract: $title",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                // Event Details
                const Text(
                  "Details:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text("Date: $date"),
                Text("Time: $time ($displayTimeZone)"),
                const SizedBox(height: 12),

                // Contract Conditions
                const Text(
                  "Terms and Conditions:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(mockContractTerms),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Close',
                style: TextStyle(color: AppColors.primary),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  // --- End: Contract Dialog Function ---

  @override
  Widget build(BuildContext context) {
    final displayTime = _extractTimeOnly(event.time);
    final displayDate = _extractDateOnly(event.time);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Hero(
                  tag: event.title,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(24),
                    ),
                    child: Image.network(
                      event.imageUrl,
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // --- TIME, DATE, TIME ZONE, AND PRICE DISPLAY ---
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row 1: Time and Time Zone (Aligned)
                        Row(
                          children: [
                            Row(
                              // Time Group
                              children: [
                                const Icon(
                                  Icons.access_time,
                                  size: 16,
                                  color: AppColors.textLight,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  displayTime,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: AppColors.textLight,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: verticalAlignmentSpacerWidth),
                            Row(
                              // Time Zone Group
                              children: [
                                const Icon(
                                  Icons.language,
                                  size: 16,
                                  color: AppColors.textLight,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  displayTimeZone,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: AppColors.textLight,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ), // Vertical spacer between rows
                        // Row 2: Date and Price (Aligned)
                        Row(
                          children: [
                            Row(
                              // Date Group
                              children: [
                                const Icon(
                                  Icons.calendar_month,
                                  size: 16,
                                  color: AppColors.textLight,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  displayDate,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: AppColors.textLight,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: verticalAlignmentSpacerWidth),
                            Row(
                              // Price Group
                              children: [
                                const SizedBox(width: 6),
                                Text(
                                  displayPrice,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),

                    // --------------------------------------------------------
                    const SizedBox(height: 16),

                    // 1. Description
                    Text(
                      event.description,
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // 2. Join Now Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MockZoomMeetingPage(event: event),
                            ),
                          );
                        },
                        child: const Text(
                          "Join Now",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // 3. Recorded Videos Section
                    if (recordedVideos.isNotEmpty) ...[
                      const Text(
                        "Recorded Videos ",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 120, // Define a height for the horizontal list
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: recordedVideos.length,
                          itemBuilder: (context, index) {
                            final video = recordedVideos[index];
                            return Padding(
                              padding: EdgeInsets.only(
                                right: index == recordedVideos.length - 1
                                    ? 0
                                    : 16,
                              ),
                              child: Container(
                                width: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.15),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    // 1. Background Image Thumbnail
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        event
                                            .imageUrl, // Use the main event image
                                        fit: BoxFit.cover,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                              if (loadingProgress == null)
                                                return child;
                                              return Container(
                                                color: AppColors.cardBackground,
                                                alignment: Alignment.center,
                                                child:
                                                    const CircularProgressIndicator(
                                                      color: AppColors.primary,
                                                    ),
                                              );
                                            },
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Container(
                                                  color:
                                                      AppColors.cardBackground,
                                                  child: const Icon(
                                                    Icons.broken_image,
                                                    color: AppColors.textLight,
                                                  ),
                                                ),
                                      ),
                                    ),

                                    // 2. Gradient Overlay for Text Readability
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.black.withOpacity(0.6),
                                            Colors.transparent,
                                          ],
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          stops: const [0.0, 0.7],
                                        ),
                                      ),
                                    ),

                                    // 3. Content (Play icon, Title, Duration)
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Play Icon (Top-Left)
                                          const Icon(
                                            Icons.play_circle_fill,
                                            color: Colors.white,
                                            size: 32,
                                          ),
                                          // Title and Duration (Bottom-Left)
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                video["title"]!,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                video["duration"]!,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white70,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                    // 4. New: Rich Text Description
                    const SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style.copyWith(
                          fontSize: 16,
                          color: AppColors.textDark,
                        ),
                        children: <TextSpan>[
                          const TextSpan(
                            text: 'Important: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                          TextSpan(
                            text:
                                'This session focuses heavily on advanced techniques in the final 45 minutes. ',
                            style: TextStyle(
                              color: AppColors.textDark.withOpacity(0.8),
                            ),
                          ),
                          const TextSpan(text: 'Please review '),
                          const TextSpan(
                            text: 'Session 1 (Warm-up)',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          const TextSpan(
                            text: ' before attempting the main drill.',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // --- End: New Rich Text Description ---

                    // 5. Event Contract Button
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.description, size: 18),
                        label: const Text("View Contract"),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          side: const BorderSide(color: AppColors.primary),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          _showContractDialog(
                            context,
                            event.title,
                            displayTime,
                            displayDate,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
