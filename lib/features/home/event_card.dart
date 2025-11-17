import 'package:coach_hub/model/Event_Model.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'EventDetailPage.dart';

class EventCard extends StatelessWidget {
  final String title;
  final String time;
  final String imageUrl;
  final String description;

  const EventCard({
    super.key,
    required this.title,
    required this.time,
    required this.imageUrl,
    this.description =
        "Join this exciting event and enhance your skills!", // default description
  });

  // Helper method to extract only the date part (e.g., "15 Nov, 2025")
  String _extractDisplayDate(String raw) {
    try {
      // raw = "10:00 AM, Oct 28 2025"
      final parts = raw.split(',');
      if (parts.length < 2) return "Invalid Date";

      final date = parts[1].trim(); // "Oct 28 2025"
      final split = date.split(" ");

      if (split.length != 3) return date;

      final monthAbbr = split[0];
      final day = split[1];
      final year = split[2];

      const monthMap = {
        "Jan": "January",
        "Feb": "February",
        "Mar": "March",
        "Apr": "April",
        "May": "May",
        "Jun": "June",
        "Jul": "July",
        "Aug": "August",
        "Sep": "September",
        "Oct": "October",
        "Nov": "November",
        "Dec": "December",
      };

      final fullMonth = monthMap[monthAbbr] ?? monthAbbr;

      return "$fullMonth $day, $year";
    } catch (e) {
      return "Invalid Date";
    }
  }

  // Helper method to extract only the formatted time part (e.g., "3:00 PM")
  String _extractDisplayTime(String input) {
    try {
      final formatted = _formatTime(input); // Output: "TIME, DAY MONTH, YEAR"
      final parts = formatted.split(",");
      return parts[0].trim(); // "3:00 PM"
    } catch (e) {
      return input.split(",")[0].trim(); // Fallback
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayTime = _extractDisplayTime(time);
    final displayDate = _extractDisplayDate(time);

    // 1. Removed the surrounding GestureDetector.
    // 2. Used a Card directly or wrapped it in a container.
    return Card(
      // The card is now the top-level widget here
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: title,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Image.network(
                imageUrl,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textLight,
                  ),
                ),
                const SizedBox(height: 8),

                // --- TIME/DATE ROW ---
                Row(
                  children: [
                    // Time Icon and Text
                    const Icon(
                      Icons.access_time_rounded,
                      size: 16,
                      color: AppColors.textLight,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      displayTime, // e.g., "3:00 PM"
                      style: const TextStyle(color: AppColors.textLight),
                    ),

                    const SizedBox(width: 16), // Spacer between time and date
                    // Date Icon and Text
                    const Icon(
                      Icons.calendar_month, // Date icon
                      size: 16,
                      color: AppColors.textLight,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      displayDate, // e.g., "15 Nov, 2025"
                      style: const TextStyle(color: AppColors.textLight),
                    ),
                  ],
                ),

                // ---------------------
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                    ),
                    // This onPressed is now the *only* way to navigate.
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EventDetailPage(
                            event: Event(
                              title: title,
                              time: _formatTime(time),
                              description: description,
                              imageUrl: imageUrl,
                            ),
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "View Detail",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Ensure the helper function is defined outside the class or in a separate utility file
String _formatTime(String input) {
  // Expected input formats now include the year:
  // "3 PM, Nov 15 2025"

  try {
    // 1. Split into Time Part and Date Part
    final parts = input.split(",");
    if (parts.length < 2) {
      // Fallback for incomplete input
      return input.trim().isEmpty ? "Unknown Time, 2025" : "$input, 2025";
    }

    final timePart = parts[0].trim(); // e.g., "11 AM" or "10:30 AM"
    String datePart = parts[1].trim(); // e.g., "Nov 15 2025"

    String timeResult;

    // 2. Format Time Part (Existing fix for adding :00)
    if (timePart.contains(":")) {
      timeResult = timePart;
    } else {
      final isAm = timePart.toUpperCase().contains("AM");
      final isPm = timePart.toUpperCase().contains("PM");

      if (isAm || isPm) {
        final indicator = isAm ? "AM" : "PM";
        final index = timePart.toUpperCase().indexOf(indicator);
        timeResult =
            "${timePart.substring(0, index).trim()}:00 ${timePart.substring(index).trim()}";
      } else {
        timeResult = "$timePart:00 PM";
      }
    }

    // 3. Format Date Part (Logic to ensure "Day Month, Year")
    final dateElements = datePart
        .split(RegExp(r'\s+'))
        .where((e) => e.isNotEmpty)
        .toList();

    String formattedDate;

    if (dateElements.length >= 3) {
      // Input is typically ["Nov", "15", "2025"]
      final month = dateElements[0];
      final day = dateElements[1];
      final year = dateElements[2];

      // Re-arrange to "Day Month, Year" (e.g., "15 Nov, 2025")
      formattedDate = "$day $month, $year";
    } else {
      // Fallback logic
      formattedDate = datePart.contains("202") ? datePart : "$datePart 2025";
    }

    // Combine for final output: "TIME, DAY MONTH, YEAR"
    return "$timeResult, $formattedDate";
  } catch (e) {
    return "$input, 2025 (Format Error)"; // Fallback
  }
}
