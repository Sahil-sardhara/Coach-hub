import 'package:coach_hub/core/theme/app_colors.dart';
import 'package:coach_hub/model/Event_Model.dart';
import 'package:flutter/material.dart';
import '../zoom/mock_zoom_meeting_page.dart';

class EventDetailPage extends StatefulWidget {
  final Event event;

  const EventDetailPage({super.key, required this.event});

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  late ScrollController _scrollController;
  bool isCollapsed = false;

  String _extractTimeOnly(String formattedTime) =>
      formattedTime.split(',')[0].trim();

  String _extractDateOnly(String raw) {
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
  }

  String _monthName(int month) {
    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];
    return months[month - 1];
  }

  static const String displayTimeZone = "IST (UTC+5:30)";
  static const String displayPrice = "\SAR 29.99";

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset > 180 && !isCollapsed) {
        setState(() => isCollapsed = true);
      } else if (_scrollController.offset <= 180 && isCollapsed) {
        setState(() => isCollapsed = false);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _showContractDialog(
    BuildContext context,
    String title,
    String time,
    String date,
  ) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          "Event Contract",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ----------------------------------------------------
              // EVENT NAME
              // ----------------------------------------------------
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 12),

              // ----------------------------------------------------
              // DATE + TIME
              // ----------------------------------------------------
              const Text(
                "Event Details:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 6),

              Text("📅 Date: $date"),
              Text("⏰ Time: $time ($displayTimeZone)"),

              const SizedBox(height: 18),

              // ----------------------------------------------------
              // TERMS & CONDITIONS
              // ----------------------------------------------------
              const Text(
                "Terms & Conditions:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 6),

              const Text("""
• You must attend on the specified date and time.
• Fees are non-refundable unless the organizer cancels the event.
• All event-related content belongs to Coach Hub.
• By joining, you confirm that you understand and agree to these terms.
""", style: TextStyle(height: 1.4)),

              const SizedBox(height: 18),

              // ----------------------------------------------------
              // PRICE SECTION
              // ----------------------------------------------------
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "💰 Total Amount to Pay: SAR 29.99",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),

        // ----------------------------------------------------------
        // CLOSE BUTTON
        // ----------------------------------------------------------
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Close",
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final displayTime = _extractTimeOnly(widget.event.time);
    final displayDate = _extractDateOnly(widget.event.time);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            // -----------------------------------------------------------
            // SCROLL HEADER
            // -----------------------------------------------------------
            SliverAppBar(
              expandedHeight: 250,
              pinned: true,
              backgroundColor: AppColors.primary,
              automaticallyImplyLeading: false,

              leading: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: isCollapsed
                    ? IconButton(
                        key: const ValueKey("collapsed"),
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      )
                    : Padding(
                        key: const ValueKey("expanded"),
                        padding: const EdgeInsets.all(8),
                        child: CircleAvatar(
                          backgroundColor: Colors.black54,
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ),
              ),

              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,

                background: Hero(
                  tag: widget.event.title,
                  child: Image.network(
                    widget.event.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),

                title: isCollapsed
                    ? SizedBox(
                        width: 180,
                        child: Text(
                          widget.event.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    : null,
                centerTitle: true,
              ),
            ),

            // -----------------------------------------------------------
            // MAIN CONTENT
            // -----------------------------------------------------------
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TITLE
                    Text(
                      widget.event.title,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // TIME + TIMEZONE
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _infoRow(Icons.access_time, displayTime),
                        _infoRow(Icons.language, displayTimeZone),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // DATE + PRICE
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _infoRow(Icons.calendar_month, displayDate),
                        Text(
                          displayPrice,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // DESCRIPTION
                    Text(
                      widget.event.description,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: AppColors.textDark,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // JOIN BUTTON
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
                              builder: (_) =>
                                  MockZoomMeetingPage(event: widget.event),
                            ),
                          );
                        },
                        child: const Text(
                          "Join Now",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // RICH TEXT SECTION
                    buildRichTextSection(),

                    const SizedBox(height: 40),

                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.description),
                        label: const Text("View Contract"),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          side: BorderSide(color: AppColors.primary),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () => _showContractDialog(
                          context,
                          widget.event.title,
                          displayTime,
                          displayDate,
                        ),
                      ),
                    ),

                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // -----------------------------------------------------------
  // SMALL INFO ROW
  // -----------------------------------------------------------
  Widget _infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.textLight),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(fontSize: 14, color: AppColors.textLight),
        ),
      ],
    );
  }

  // -----------------------------------------------------------
  // RICH TEXT (MATCHING PROFILE STYLE)
  // -----------------------------------------------------------
  Widget buildRichTextSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // HEADING
        Text(
          "Discover essential leadership principles based on 20+ years of experience",
          style: const TextStyle(
            fontSize: 22,
            height: 1.4,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),

        const SizedBox(height: 18),

        // PARAGRAPH
        RichText(
          text: const TextSpan(
            style: TextStyle(
              fontSize: 16,
              height: 1.6,
              color: AppColors.textDark,
            ),
            children: [
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

        const NumberedText(
          number: 1,
          text: "Core leadership insight explained.",
        ),
        const SizedBox(height: 14),
        const NumberedText(
          number: 2,
          text: "Another deep leadership takeaway.",
        ),

        const SizedBox(height: 25),

        // HIGHLIGHTED BOX
        Container(
          padding: const EdgeInsets.all(14),
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(color: AppColors.primary, width: 4),
            ),
          ),
          child: const Text(
            "A highlighted message written in italic style to deliver a powerful insight.",
            style: TextStyle(
              fontSize: 16,
              height: 1.6,
              fontStyle: FontStyle.italic,
              color: AppColors.textDark,
            ),
          ),
        ),
      ],
    );
  }
}

// ===========================================================================
// NUMBERED TEXT
// ===========================================================================
class NumberedText extends StatelessWidget {
  final int number;
  final String text;

  const NumberedText({super.key, required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$number.",
          style: const TextStyle(fontSize: 16, color: AppColors.textDark),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              height: 1.6,
              color: AppColors.textDark,
            ),
          ),
        ),
      ],
    );
  }
}
