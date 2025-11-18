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

  // 🔥 FIRST TWO WORDS ONLY + ...
  String _shortTitle(String title) {
    final words = title.split(" ");
    if (words.length <= 3) return title;
    return "${words[0]} ${words[1]} ${words[2]} ...";
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final displayTime = _extractTimeOnly(widget.event.time);
    final displayDate = _extractDateOnly(widget.event.time);

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            // -------------------------------------------------------
            // SLIVER APP BAR
            // -------------------------------------------------------
            SliverAppBar(
              expandedHeight: 250,
              pinned: true,
              backgroundColor: AppColors.primary,
              automaticallyImplyLeading: false,

              leading: Padding(
                padding: const EdgeInsets.only(top: 13, left: 12),
                child: CircleAvatar(
                  backgroundColor: isCollapsed
                      ? Colors.transparent
                      : Colors.white.withOpacity(0.75),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: isCollapsed ? Colors.white : AppColors.primary,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),

              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                centerTitle: true,
                titlePadding: const EdgeInsets.only(bottom: 12),

                title: isCollapsed
                    ? Text(
                        _shortTitle(widget.event.title),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      )
                    : null,

                background: Hero(
                  tag: widget.event.title,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.network(
                          widget.event.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.30),
                                Colors.transparent,
                                Colors.black.withOpacity(0.30),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // -------------------------------------------------------
            // MAIN CONTENT
            // -------------------------------------------------------
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TITLE
                    Text(
                      widget.event.title,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppColors.darkText : AppColors.textDark,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _infoRow(Icons.access_time, displayTime, isDark),
                        _infoRow(Icons.language, "IST (UTC+5:30)", isDark),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _infoRow(Icons.calendar_month, displayDate, isDark),
                        const Text(
                          "SAR 29.99",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

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

                    // -------------------------------------------------------
                    // JOIN NOW BUTTON
                    // -------------------------------------------------------
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

                    // -------------------------------------------------------
                    // RECORDED SESSIONS (HORIZONTAL FULL CARDS)
                    // -------------------------------------------------------
                    const SizedBox(height: 30),

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
                            width: 240,
                            decoration: BoxDecoration(
                              color: isDark ? AppColors.darkCard : Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.12),
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // IMAGE WITH PLAY + DURATION INSIDE IMAGE
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(16),
                                  ),
                                  child: Stack(
                                    children: [
                                      Image.network(
                                        widget.event.imageUrl,
                                        height: 150,
                                        width: 240,
                                        fit: BoxFit.cover,
                                      ),

                                      // Dark overlay for better visibility
                                      Positioned.fill(
                                        child: Container(color: Colors.black26),
                                      ),

                                      // Play Icon (TOP LEFT)
                                      const Positioned(
                                        top: 10,
                                        left: 10,
                                        child: Icon(
                                          Icons.play_circle_fill,
                                          color: Colors.white,
                                          size: 34,
                                        ),
                                      ),

                                      // Duration (BOTTOM LEFT — INSIDE IMAGE)
                                      Positioned(
                                        bottom: 10,
                                        left: 10,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 4,
                                            horizontal: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.black87,
                                            borderRadius: BorderRadius.circular(
                                              6,
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

                                // VIDEO TITLE BELOW IMAGE
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    "Recorded Video ${index + 1}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 15,
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

                    // -------------------------------------------------------
                    // RICH TEXT (YOUR EXISTING SECTION - UNTOUCHED)
                    // -------------------------------------------------------
                    const SizedBox(height: 30),
                    buildRichTextSection(isDark),

                    // -------------------------------------------------------
                    // VIEW CONTRACT
                    // -------------------------------------------------------
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
                            builder: (_) => AlertDialog(
                              backgroundColor: isDark
                                  ? AppColors.darkCard
                                  : Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              title: Text(
                                widget.event.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isDark
                                      ? AppColors.darkText
                                      : AppColors.textDark,
                                ),
                              ),
                              content: Text(
                                "📅 Date: $displayDate\n"
                                "⏰ Time: $displayTime\n\n"
                                "Terms & Conditions:\n\n"
                                "• You must attend on the specified date.\n"
                                "• Fees are non-refundable unless cancelled.\n"
                                "• Content belongs to Coach Hub.\n"
                                "• By joining, you accept these terms.\n",
                                style: TextStyle(
                                  height: 1.4,
                                  color: isDark
                                      ? AppColors.darkSubText
                                      : AppColors.textDark,
                                ),
                              ),
                              actions: [
                                Center(
                                  child: TextButton(
                                    child: const Text(
                                      "Close",
                                      style: TextStyle(
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
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
          color: isDark ? AppColors.darkSubText : AppColors.textLight,
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: isDark ? AppColors.darkSubText : AppColors.textLight,
          ),
        ),
      ],
    );
  }

  // -------------------------------------------------------
  // YOUR EXISTING RICH TEXT SECTION
  // -------------------------------------------------------
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
            color: isDark ? AppColors.darkText : AppColors.textDark,
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
