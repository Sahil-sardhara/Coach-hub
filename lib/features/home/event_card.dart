import 'package:coach_hub/core/theme/dark_mode.dart';
import 'package:coach_hub/model/Event_Model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    this.description = "Join this exciting event and enhance your skills!",
  });

  String _extractDisplayDate(String raw) {
    try {
      final parts = raw.split(',');
      if (parts.length < 2) return "Invalid Date";

      final date = parts[1].trim();
      final split = date.split(" ");

      if (split.length != 3) return date;

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

      final monthAbbr = split[0];
      final fullMonth = monthMap[monthAbbr] ?? monthAbbr;

      return "$fullMonth ${split[1]}, ${split[2]}";
    } catch (e) {
      return "Invalid Date";
    }
  }

  String _extractDisplayTime(String input) {
    try {
      final formatted = _formatTime(input);
      final parts = formatted.split(",");
      return parts[0].trim();
    } catch (e) {
      return input.split(",")[0].trim();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;

    final displayTime = _extractDisplayTime(time);
    final displayDate = _extractDisplayDate(time);

    return Card(
      elevation: isDark ? 1 : 6,
      color: isDark ? AppColors.darkCard : Colors.white,
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
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // ---------------------
          // TEXT + BUTTON SECTION
          // ---------------------
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.darkText : AppColors.textDark,
                  ),
                ),

                const SizedBox(height: 6),

                // Description
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? AppColors.darkSubText : AppColors.textLight,
                  ),
                ),

                const SizedBox(height: 8),

                // ---------------------
                // TIME + DATE ROW
                // ---------------------
                Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      size: 16,
                      color: isDark
                          ? AppColors.darkSubText
                          : AppColors.textLight,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      displayTime,
                      style: TextStyle(
                        color: isDark
                            ? AppColors.darkSubText
                            : AppColors.textLight,
                      ),
                    ),

                    const SizedBox(width: 16),

                    Icon(
                      Icons.calendar_month,
                      size: 16,
                      color: isDark
                          ? AppColors.darkSubText
                          : AppColors.textLight,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      displayDate,
                      style: TextStyle(
                        color: isDark
                            ? AppColors.darkSubText
                            : AppColors.textLight,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // ---------------------
                // VIEW DETAILS BUTTON
                // ---------------------
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
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

// KEEP YOUR TIME FORMAT FUNCTION AS IS
String _formatTime(String input) {
  try {
    final parts = input.split(",");
    final timePart = parts[0].trim();
    final datePart = parts.length > 1 ? parts[1].trim() : "Nov 2025";

    String formattedTime = timePart.contains(":")
        ? timePart
        : "${timePart.replaceAll("AM", "").replaceAll("PM", "").trim()}:00 ${timePart.contains("AM") ? "AM" : "PM"}";

    return "$formattedTime, $datePart";
  } catch (e) {
    return input;
  }
}
