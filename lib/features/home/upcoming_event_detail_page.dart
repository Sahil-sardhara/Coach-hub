import 'package:coach_hub/core/theme/app_colors.dart';
import 'package:coach_hub/model/event_model.dart';
import 'package:flutter/material.dart';

class UpcomingEventDetailPage extends StatelessWidget {
  final Event event;

  const UpcomingEventDetailPage({super.key, required this.event});

  String _extractTimeOnly(String formattedTime) =>
      formattedTime.split(',')[0].trim();

  String _extractDateOnly(String raw) {
    final parts = raw.split(',');
    if (parts.length < 2) return "Invalid Date";

    final date = parts[1].trim();
    final split = date.split(" ");

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

    final fullMonth = monthMap[split[0]] ?? split[0];
    return "$fullMonth ${split[1]}, ${split[2]}";
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final displayTime = _extractTimeOnly(event.time);
    final displayDate = _extractDateOnly(event.time);

    final bool isFree = event.isFree;
    final String priceLabel = event.priceLabel;
    final int availableSlots = event.slots;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          event.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.white),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ⭐ IMAGE BANNER
            event.imageAsset != null
                ? Image.asset(
                    event.imageAsset!,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.30,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    event.imageUrl!,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.30,
                    fit: BoxFit.cover,
                  ),

            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ⭐ TITLE
                  Text(
                    event.title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.darkText : AppColors.textDark,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ⭐ TIME + LANGUAGE
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _infoRow(Icons.access_time, displayTime, isDark),
                      _infoRow(Icons.language, "IST (UTC+5:30)", isDark),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // ⭐ DATE + PRICE
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _infoRow(Icons.calendar_month, displayDate, isDark),
                      Text(
                        event.isFree
                            ? "FREE"
                            : "SAR ${event.price.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: event.isFree
                              ? Colors.green
                              : AppColors.primary,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // ⭐ SLOTS LEFT (RED IF <=10)
                  Row(
                    children: [
                      Icon(Icons.chair, size: 20, color: AppColors.primary),
                      const SizedBox(width: 8),

                      Text(
                        "${event.slots} spots left",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: event.slots <= 10
                              ? Colors.red
                              : AppColors.primary,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // ⭐ FULL DESCRIPTION
                  Text(
                    event.description,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: isDark
                          ? AppColors.darkSubText
                          : AppColors.textDark,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // ⭐ REGISTER NOW BUTTON
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {
                        // TODO: Implement register action
                      },
                      child: const Text(
                        "Register Now",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // ⭐ RICH CONTENT SECTION
                  buildRichTextSection(isDark),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ----------------------------------------------------
  // ⭐ INFO ROW WIDGET
  // ----------------------------------------------------
  Widget _infoRow(
    IconData icon,
    String text,
    bool isDark, {
    Color? valueColor,
  }) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.primary),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color:
                valueColor ??
                (isDark ? AppColors.darkText : AppColors.textDark),
          ),
        ),
      ],
    );
  }

  // ----------------------------------------------------
  // ⭐ RICH TEXT SECTION
  // ----------------------------------------------------
  Widget buildRichTextSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Discover essential leadership principles based on 20+ years of experience",
          style: TextStyle(
            fontSize: 22,
            height: 1.4,
            fontWeight: FontWeight.bold,
            color: isDark ? AppColors.darkText : AppColors.textDark,
          ),
        ),
        const SizedBox(height: 18),
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 16,
              height: 1.6,
              color: isDark ? AppColors.darkSubText : AppColors.textDark,
            ),
            children: const [
              TextSpan(
                text: "Discover leadership principles that help create ",
              ),
              TextSpan(
                text: "exceptional teams",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: " and improve organizational outcomes."),
            ],
          ),
        ),
        const SizedBox(height: 14),
        NumberedText(number: 1, text: "Core leadership insight explained."),
        const SizedBox(height: 10),
        NumberedText(number: 2, text: "Another deep leadership takeaway."),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(color: AppColors.primary, width: 4),
            ),
          ),
          child: Text(
            "A highlighted message written in italic style to deliver a powerful insight.",
            style: TextStyle(
              fontSize: 16,
              height: 1.6,
              fontStyle: FontStyle.italic,
              color: isDark ? AppColors.darkSubText : AppColors.textDark,
            ),
          ),
        ),
      ],
    );
  }
}

// ----------------------------------------------------
// ⭐ NUMBERED TEXT COMPONENT
// ----------------------------------------------------
class NumberedText extends StatelessWidget {
  final int number;
  final String text;

  const NumberedText({super.key, required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$number.",
            style: TextStyle(
              fontSize: 16,
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                height: 1.6,
                color: isDark ? AppColors.darkSubText : AppColors.textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
