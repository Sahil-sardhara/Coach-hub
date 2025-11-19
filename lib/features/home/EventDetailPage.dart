import 'package:coach_hub/core/theme/app_colors.dart';
import 'package:coach_hub/model/event_model.dart';
import 'package:flutter/material.dart';
import '../zoom/mock_zoom_meeting_page.dart';

class EventDetailPage extends StatefulWidget {
  final Event event;

  const EventDetailPage({super.key, required this.event});

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  // Short title - first 3 words only
  String _shortTitle3Words(String title) {
    final words = title.split(" ");
    if (words.length <= 3) return title;
    return "${words[0]} ${words[1]} ${words[2]} ...";
  }

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

  Widget _contractInfoRow(
    IconData icon,
    String label,
    String value,
    bool isDark,
  ) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.primary),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  color: isDark ? AppColors.darkSubText : Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: isDark ? AppColors.darkText : AppColors.textDark,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _bulletPoint(String text, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("•  ", style: TextStyle(fontSize: 18)),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 15,
                height: 1.4,
                color: isDark ? AppColors.darkSubText : AppColors.textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final displayTime = _extractTimeOnly(widget.event.time);
    final displayDate = _extractDateOnly(widget.event.time);

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.background,

      // ⭐ NORMAL APP BAR, NO COLLAPSING
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
            // ⭐ IMAGE BANNER
            widget.event.imageAsset != null
                ? Image.asset(
                    widget.event.imageAsset!,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.30,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    widget.event.imageUrl!,
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
                    widget.event.title,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.darkText : AppColors.textDark,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // ⭐ TIME + TIMEZONE
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _infoRow(Icons.access_time, displayTime, isDark),
                      _infoRow(Icons.language, "IST (UTC+5:30)", isDark),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // ⭐ DATE + PRICE
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _infoRow(Icons.calendar_month, displayDate, isDark),
                      Text(
                        widget.event.isFree
                            ? "FREE"
                            : "SAR ${widget.event.price.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // ⭐ DESCRIPTION
                  Text(
                    widget.event.description,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: isDark
                          ? AppColors.darkSubText
                          : AppColors.textDark,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // ⭐ JOIN NOW BUTTON
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const MockZoomMeetingPage(),
                          ),
                        );
                      },
                      child: const Text(
                        "Join Now",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // ⭐ RECORDED SESSIONS
                  Text(
                    "Recorded Sessions",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.darkText : AppColors.textDark,
                    ),
                  ),

                  const SizedBox(height: 12),

                  SizedBox(
                    height: 200,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      separatorBuilder: (_, __) => const SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        return Container(
                          width: 280,
                          decoration: BoxDecoration(
                            color: isDark ? AppColors.darkCard : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(16),
                                ),
                                child: Stack(
                                  children: [
                                    // IMAGE
                                    widget.event.imageAsset != null
                                        ? Image.asset(
                                            widget.event.imageAsset!,
                                            height: 150,
                                            width: 280,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.network(
                                            widget.event.imageUrl!,
                                            height: 150,
                                            width: 280,
                                            fit: BoxFit.cover,
                                          ),

                                    // DARK OVERLAY (TO MAKE TEXT + ICON CLEAR)
                                    Positioned.fill(
                                      child: Container(
                                        color: Colors.black.withOpacity(0.25),
                                      ),
                                    ),

                                    // PLAY ICON
                                    const Positioned(
                                      top: 8,
                                      left: 8,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 16,
                                        child: Icon(
                                          Icons.play_arrow,
                                          size: 20,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ),

                                    // DURATION LABEL
                                    Positioned(
                                      bottom: 10,
                                      left: 10,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 4,
                                          horizontal: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.black87,
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Text(
                                          "12:0$index min",
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // TITLE BELOW IMAGE
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  "Recorded Video ${index + 1}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: isDark
                                        ? AppColors.darkText
                                        : AppColors.textDark,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  buildRichTextSection(isDark),

                  const SizedBox(height: 30),

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
                        showDialog(
                          context: context,
                          builder: (_) => Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(22),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? AppColors.darkCard
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // TITLE
                                  Text(
                                    "Event Contract",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: isDark
                                          ? AppColors.darkText
                                          : AppColors.textDark,
                                    ),
                                  ),

                                  const SizedBox(height: 14),

                                  // EVENT NAME
                                  Text(
                                    widget.event.title,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primary,
                                    ),
                                  ),

                                  const SizedBox(height: 16),

                                  // DATE & TIME BOX
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _contractInfoRow(
                                        Icons.calendar_month,
                                        "Date",
                                        displayDate,
                                        isDark,
                                      ),
                                      const SizedBox(height: 8),
                                      _contractInfoRow(
                                        Icons.access_time,
                                        "Time",
                                        displayTime,
                                        isDark,
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 22),

                                  // TERMS HEADER
                                  Text(
                                    "Terms & Conditions",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: isDark
                                          ? AppColors.darkText
                                          : AppColors.textDark,
                                    ),
                                  ),

                                  const SizedBox(height: 12),

                                  // BULLET POINTS
                                  _bulletPoint(
                                    "You must attend on the specified date.",
                                    isDark,
                                  ),
                                  _bulletPoint(
                                    "Fees are non-refundable unless the event is cancelled.",
                                    isDark,
                                  ),
                                  _bulletPoint(
                                    "Event content is the intellectual property of Coach Hub.",
                                    isDark,
                                  ),
                                  _bulletPoint(
                                    "By joining, you accept all the above terms.",
                                    isDark,
                                  ),

                                  const SizedBox(height: 24),

                                  // CLOSE BUTTON
                                  SizedBox(
                                    width: double.infinity,
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor: AppColors.primary,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                      ),
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text(
                                        "Close",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
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
        Icon(
          icon,
          size: 16,
          color: isDark ? AppColors.darkSubText : AppColors.primary,
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: isDark ? AppColors.darkSubText : AppColors.textDark,
          ),
        ),
      ],
    );
  }

  // ⭐ RICH TEXT SECTION
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
