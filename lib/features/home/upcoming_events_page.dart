import 'package:coach_hub/features/home/upcoming_event_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:coach_hub/model/Event_Model.dart';
import 'EventDetailPage.dart';
import '../../core/theme/app_colors.dart';

class UpcomingEventsPage extends StatelessWidget {
  final List<Event> events;

  const UpcomingEventsPage({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text("Upcoming Events"),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCard : AppColors.background,
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? AppColors.darkLightShadow
                      : AppColors.lightShadow,
                  offset: const Offset(-4, -4),
                  blurRadius: 8,
                ),
                BoxShadow(
                  color: isDark
                      ? AppColors.darkDarkShadow
                      : AppColors.darkShadow,
                  offset: const Offset(4, 4),
                  blurRadius: 8,
                ),
              ],
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.network(
                    event.imageUrl,
                    width: double.infinity,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(height: 14),

                Text(
                  event.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.darkText : AppColors.textDark,
                  ),
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: isDark
                          ? AppColors.darkSubText
                          : AppColors.textLight,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      event.time,
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark
                            ? AppColors.darkSubText
                            : AppColors.textLight,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Text(
                  event.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? AppColors.darkSubText : AppColors.textLight,
                  ),
                ),

                const SizedBox(height: 16),

                // VIEW DETAIL BUTTON
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => UpcomingEventDetailPage(event: event),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      "View Detail",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
