import 'package:coach_hub/features/home/upcoming_event_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:coach_hub/model/event_model.dart';
import '../../core/theme/app_colors.dart';

class UpcomingEventsPage extends StatefulWidget {
  final List<Event> events;

  const UpcomingEventsPage({super.key, required this.events});

  @override
  State<UpcomingEventsPage> createState() => _UpcomingEventsPageState();
}

class _UpcomingEventsPageState extends State<UpcomingEventsPage> {
  String selectedFilter = "ALL";

  Widget _neumorphicFilter(String label) {
    final bool isSelected = selectedFilter == label;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = label;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        margin: const EdgeInsets.symmetric(horizontal: 6),

        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.background,
          borderRadius: BorderRadius.circular(18),
          boxShadow: isSelected
              ? [
                  // Pressed (inset feeling)
                  BoxShadow(
                    color: isDark
                        ? AppColors.darkLightShadow
                        : AppColors.lightShadow,
                    offset: const Offset(2, 2),
                    blurRadius: 4,
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                    color: isDark
                        ? AppColors.darkDarkShadow
                        : AppColors.darkShadow,
                    offset: const Offset(-2, -2),
                    blurRadius: 4,
                    spreadRadius: 1,
                  ),
                ]
              : [
                  // Outer emboss effect
                  BoxShadow(
                    color: isDark
                        ? AppColors.darkLightShadow
                        : AppColors.lightShadow,
                    offset: const Offset(-3, -3),
                    blurRadius: 6,
                  ),
                  BoxShadow(
                    color: isDark
                        ? AppColors.darkDarkShadow
                        : AppColors.darkShadow,
                    offset: const Offset(3, 3),
                    blurRadius: 6,
                  ),
                ],
        ),

        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: isSelected
                ? AppColors.primary
                : (isDark ? AppColors.darkText : AppColors.textDark),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // FILTERED LIST
    final filteredEvents = widget.events.where((event) {
      if (selectedFilter == "FREE") return event.isFree;
      if (selectedFilter == "PAID") return !event.isFree;
      return true;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text("Upcoming Events"),
      ),

      body: Column(
        children: [
          const SizedBox(height: 12),

          // ⭐ FILTER BAR
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _neumorphicFilter("ALL"),
              _neumorphicFilter("FREE"),
              _neumorphicFilter("PAID"),
            ],
          ),

          const SizedBox(height: 16),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredEvents.length,
              itemBuilder: (context, index) {
                final event = filteredEvents[index];
                final bool isFree = event.isFree;
                final String badgeLabel = isFree ? "FREE" : "PAID";

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
                      // IMAGE + BADGE
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: event.imageAsset != null
                                ? Image.asset(
                                    event.imageAsset!,
                                    width: double.infinity,
                                    height: 180,
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    event.imageUrl!,
                                    width: double.infinity,
                                    height: 180,
                                    fit: BoxFit.cover,
                                  ),
                          ),

                          // ⭐ BADGE TOP RIGHT
                          Positioned(
                            top: 10,
                            right: 10,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: isFree
                                    ? Colors.green.withOpacity(0.7)
                                    : Colors.red.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 6,
                                    offset: const Offset(2, 2),
                                  ),
                                ],
                              ),
                              child: Text(
                                badgeLabel, // FREE or PAID only
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      // TITLE
                      Text(
                        event.title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? AppColors.darkText
                              : AppColors.textDark,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // TIME ROW
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

                      // DESCRIPTION
                      Text(
                        event.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark
                              ? AppColors.darkSubText
                              : AppColors.textLight,
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
                                builder: (_) =>
                                    UpcomingEventDetailPage(event: event),
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
          ),
        ],
      ),
    );
  }
}
