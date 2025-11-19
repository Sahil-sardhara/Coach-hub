import 'package:coach_hub/features/home/upcoming_events_page.dart';
import 'package:coach_hub/features/zoom/mock_zoom_meeting_page.dart';
import 'package:coach_hub/features/profile/profile_page.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'package:coach_hub/model/event_model.dart';
import 'EventDetailPage.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final appBarTitles = ["My Events", "Zoom Meetings", "My Profile"];

  final List<Event> allEvents = [
    Event(
      title: "Startup Pitch Day & Networking Mixer",
      time: "10:00 AM, Oct 28 2025",
      description:
          "**Relive the excitement!** This annual event brought together 15 innovative student-led startups...",
      imageAsset: "assets/images/image.1.jpg",
      price: 0.0, // FREE
      slots: 40,
    ),

    Event(
      title: "AI Trends & Ethical Governance Talk (LIVE)",
      time: "4:30 PM, Nov 14 2025",
      description:
          "**Happening now!** Join renowned AI expert Dr. Ben Carter as he explores the future of ethical AI...",
      imageAsset: "assets/images/image.2.jpg",
      price: 49.99, // PAID
      slots: 25,
    ),

    Event(
      title: "Tech Seminar: Next-Gen Flutter Development",
      time: "03:00 PM, Nov 15 2025",
      description:
          "Discover future-proof Flutter strategies including Flutter 4.0 updates...",
      imageAsset: "assets/images/image.3.jpg",
      price: 19.99, // PAID
      slots: 5,
    ),

    Event(
      title: "Cloud Expo: AWS, Azure & Google Cloud",
      time: "11:00 AM, Dec 5 2025",
      description:
          "Learn about multi-cloud solutions, serverless computing, Kubernetes...",
      imageAsset: "assets/images/image.4.jpg",
      price: 0.0, // FREE
      slots: 80,
    ),

    Event(
      title: "Cybersecurity Workshop & CTF Challenge",
      time: "09:30 AM, Dec 18 2025",
      description:
          "Hands-on cybersecurity lab covering ethical hacking, OWASP vulnerabilities...",
      imageAsset: "assets/images/image.5.jpg",
      price: 79.99, // PAID
      slots: 10,
    ),
  ];

  List<Event> displayedEvents = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    displayedEvents = List.from(allEvents);
  }

  // FILTER EVENTS
  void _filterEvents(String query) {
    if (query.length < 2) {
      setState(() => displayedEvents = List.from(allEvents));
      return;
    }

    setState(() {
      displayedEvents = allEvents
          .where(
            (event) => event.title.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    });
  }

  // BODY
  Widget _buildBody(BuildContext context) {
    switch (_currentIndex) {
      case 0:
        return _eventsList(context);
      case 1:
        return MockZoomMeetingPage();
      case 2:
        return ProfilePage();
      default:
        return _eventsList(context);
    }
  }

  // EVENTS LIST
  Widget _eventsList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SEARCH stays fixed
        Padding(padding: const EdgeInsets.all(16), child: _buildSearchField()),

        // SCROLLABLE CONTENT BELOW
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // UPCOMING BANNER (scrolls)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _comingSoonBanner(),
                ),

                const SizedBox(height: 16),

                // MAIN EVENT LIST (scrolls)
                ListView.builder(
                  padding: const EdgeInsets.only(bottom: 20),
                  shrinkWrap: true, // IMPORTANT
                  physics: const NeverScrollableScrollPhysics(), // IMPORTANT
                  itemCount: displayedEvents.length,
                  itemBuilder: (context, index) {
                    return _eventCard(displayedEvents[index]);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _comingSoonBanner() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 450),
            reverseTransitionDuration: const Duration(milliseconds: 350),

            pageBuilder: (_, animation, __) {
              final curved = CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              );

              return FadeTransition(
                opacity: curved,
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.94, end: 1.0).animate(curved),
                  child: UpcomingEventsPage(events: allEvents),
                ),
              );
            },
          ),
        );
      },

      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.background,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: isDark ? AppColors.darkLightShadow : AppColors.lightShadow,
              offset: const Offset(-4, -4),
              blurRadius: 8,
            ),
            BoxShadow(
              color: isDark ? AppColors.darkDarkShadow : AppColors.darkShadow,
              offset: const Offset(4, 4),
              blurRadius: 8,
            ),
          ],
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Coming Soon",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.darkText : AppColors.textDark,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                children: [
                  Text(
                    "Explore Upcoming Events",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Icon(Icons.arrow_forward, color: AppColors.primary, size: 18),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // SEARCH FIELD (NEUMORPHIC DARK + LIGHT)
  Widget _buildSearchField() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkBackground : AppColors.background,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: isDark ? AppColors.darkLightShadow : AppColors.lightShadow,
            blurRadius: 6,
            offset: const Offset(-4, -4),
          ),
          BoxShadow(
            color: isDark ? AppColors.darkDarkShadow : AppColors.darkShadow,
            blurRadius: 6,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: TextField(
        controller: searchController,
        onChanged: _filterEvents,
        decoration: InputDecoration(
          hintText: "Search events...",
          hintStyle: TextStyle(
            color: isDark ? AppColors.darkSubText : AppColors.textLight,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: isDark ? AppColors.darkSubText : AppColors.textLight,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 18,
          ),
        ),
        style: TextStyle(
          color: isDark ? AppColors.darkText : AppColors.textDark,
        ),
      ),
    );
  }

  // EVENT CARD (NEUMORPHIC)
  Widget _eventCard(Event event) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => EventDetailPage(event: event)),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.background,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: isDark ? AppColors.darkLightShadow : AppColors.lightShadow,
              offset: const Offset(-4, -4),
              blurRadius: 8,
            ),
            BoxShadow(
              color: isDark ? AppColors.darkDarkShadow : AppColors.darkShadow,
              offset: const Offset(4, 4),
              blurRadius: 8,
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: event.imageAsset != null
                  ? Image.asset(
                      event.imageAsset!,
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      event.imageUrl!,
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
            ),

            const SizedBox(height: 16),

            // TITLE
            Text(
              event.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.darkText : AppColors.textDark,
              ),
            ),

            const SizedBox(height: 6),

            // TIME
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 16,
                  color: isDark ? AppColors.darkSubText : AppColors.textLight,
                ),
                const SizedBox(width: 6),
                Text(
                  event.time,
                  style: TextStyle(
                    color: isDark ? AppColors.darkSubText : AppColors.textLight,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // DESCRIPTION
            Text(
              event.description,
              maxLines: 8,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                height: 1.4,
                color: isDark ? AppColors.darkSubText : AppColors.textLight,
              ),
            ),

            const SizedBox(height: 16),

            // BUTTON
            SizedBox(
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary.withOpacity(0.9),
                      AppColors.primary,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 500),
                        pageBuilder: (_, __, ___) =>
                            EventDetailPage(event: event),
                        transitionsBuilder: (_, animation, __, child) {
                          var curve = CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeOutCubic,
                          );

                          return Transform.scale(
                            scale: 0.88 + (0.12 * curve.value),
                            child: FadeTransition(opacity: curve, child: child),
                          );
                        },
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    "View Detail",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // MAIN BUILD
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(appBarTitles[_currentIndex]),
      ),
      body: _buildBody(context),
    );
  }
}
