import 'package:coach_hub/core/theme/app_colors.dart';
import 'package:coach_hub/model/Event_Model.dart';
import 'package:flutter/material.dart';

class UpcomingEventDetailPage extends StatefulWidget {
  final Event event;

  const UpcomingEventDetailPage({super.key, required this.event});

  @override
  State<UpcomingEventDetailPage> createState() =>
      _UpcomingEventDetailPageState();
}

class _UpcomingEventDetailPageState extends State<UpcomingEventDetailPage> {
  bool expanded = false;

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
    final displayTime = _extractTimeOnly(widget.event.time);
    final displayDate = _extractDateOnly(widget.event.time);

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
          widget.event.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.white),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ⭐ FULL-WIDTH HERO IMAGE ⭐
            ClipRRect(
              child: Image.network(
                widget.event.imageUrl,
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.30,
                fit: BoxFit.cover,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TITLE
                  Text(
                    widget.event.title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.darkText : AppColors.textDark,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ⭐ DATE & TIME CARD ⭐
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.darkCard : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: isDark
                              ? AppColors.darkDarkShadow
                              : Colors.black.withOpacity(0.08),
                          blurRadius: 8,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _infoRow(Icons.calendar_month, displayDate, isDark),
                        const SizedBox(height: 6),
                        _infoRow(Icons.access_time, displayTime, isDark),
                        const SizedBox(height: 6),
                        _infoRow(Icons.language, "IST (UTC+5:30)", isDark),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // SHORT DESCRIPTION
                  Text(
                    widget.event.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: isDark
                          ? AppColors.darkSubText
                          : AppColors.textDark,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ⭐ NOTIFY ME BUTTON ⭐
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {},
                      icon: const Icon(
                        Icons.notifications_active,
                        color: Colors.white,
                      ),
                      label: const Text(
                        "Notify Me",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  // ⭐ ADD TO CALENDAR BUTTON ⭐
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary.withOpacity(0.15),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Add to Calendar",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // ⭐ ABOUT HEADER ⭐
                  Text(
                    "About This Event",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.darkText : AppColors.textDark,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ⭐ EXPANDABLE FULL SECTION ⭐
                  AnimatedCrossFade(
                    firstChild: Text(
                      widget.event.description,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.6,
                        color: isDark
                            ? AppColors.darkSubText
                            : AppColors.textDark,
                      ),
                    ),
                    secondChild: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.event.description,
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.6,
                            color: isDark
                                ? AppColors.darkSubText
                                : AppColors.textDark,
                          ),
                        ),

                        const SizedBox(height: 25),

                        // ⭐ RICH TEXT SECTION ⭐
                        buildRichTextSection(isDark),

                        const SizedBox(height: 30),

                        // ⭐ CONTRACT BUTTON ⭐
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            icon: const Icon(Icons.description),
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
                              _openContractDialog(
                                context,
                                isDark,
                                displayTime,
                                displayDate,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    crossFadeState: expanded
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 250),
                  ),

                  const SizedBox(height: 10),

                  GestureDetector(
                    onTap: () => setState(() => expanded = !expanded),
                    child: Text(
                      expanded ? "Read Less" : "Read More",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text, bool isDark) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.primary),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 15,
            color: isDark ? AppColors.darkText : AppColors.textDark,
          ),
        ),
      ],
    );
  }

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
        const SizedBox(height: 25),
        NumberedText(number: 1, text: "Core leadership insight explained."),
        const SizedBox(height: 14),
        NumberedText(number: 2, text: "Another deep leadership takeaway."),
        const SizedBox(height: 25),
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

  void _openContractDialog(
    BuildContext context,
    bool isDark,
    String time,
    String date,
  ) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: isDark ? AppColors.darkCard : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: Text(
          widget.event.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDark ? AppColors.darkText : AppColors.textDark,
          ),
        ),
        content: Text(
          "📅 Date: $date\n"
          "⏰ Time: $time\n\n"
          "Terms & Conditions:\n\n"
          "• Event must be attended on the given date.\n"
          "• Fees non-refundable once booked.\n"
          "• All content belongs to Coach Hub.\n"
          "• Joining means accepting all terms.\n",
          style: TextStyle(
            height: 1.4,
            color: isDark ? AppColors.darkSubText : AppColors.textDark,
          ),
        ),
        actions: [
          Center(
            child: TextButton(
              child: const Text(
                "Close",
                style: TextStyle(color: AppColors.primary),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}

class NumberedText extends StatelessWidget {
  final int number;
  final String text;

  const NumberedText({super.key, required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
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
    );
  }
}
