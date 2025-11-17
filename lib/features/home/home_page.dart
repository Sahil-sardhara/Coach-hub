import 'package:coach_hub/features/zoom/mock_zoom_meeting_page.dart';
import 'package:coach_hub/features/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/dark_mode.dart';
import 'package:coach_hub/model/Event_Model.dart';
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
          "**Relive the excitement!** This highly-anticipated annual event featured 15 top student-led startups annual event featured 15 top student-led startups annual event featured 15 top student-led startups",
      imageUrl: "https://picsum.photos/400/200?random=4",
    ),
    Event(
      title: "AI Trends & Ethical Governance Talk (LIVE)",
      time: "4:30 PM, Nov 14 2025",
      description:
          "**Happening now!** Join leading expert Dr. Ben Carter Join leading expert Dr. Ben Carter Join leading expert Dr. Ben Carter Join leading expert Dr. Ben Carter",
      imageUrl: "https://picsum.photos/400/200?random=5",
    ),
    Event(
      title: "Tech Seminar: Next-Gen Flutter & Flow Development",
      time: "3 PM, Nov 15 2025",
      description:
          "Discover the future of cross-platform development the future of cross-platform development the future of cross-platform development the future of cross-platform development",
      imageUrl: "https://picsum.photos/400/200?random=1",
    ),
  ];

  List<Event> displayedEvents = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    displayedEvents = List.from(allEvents);
  }

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

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return _eventsList();
      case 1:
        return MockZoomMeetingPage();
      case 2:
        return ProfilePage();
      default:
        return _eventsList();
    }
  }

  Widget _eventsList() {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;

    return Column(
      children: [
        Padding(padding: const EdgeInsets.all(16), child: _buildSearchField()),

        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 20),
            itemCount: displayedEvents.length,
            itemBuilder: (context, index) {
              return _eventCard(displayedEvents[index]);
            },
          ),
        ),
      ],
    );
  }

  // SEARCH FIELD (Neumorphic)
  Widget _buildSearchField() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: AppColors.lightShadow,
            blurRadius: 6,
            offset: Offset(-4, -4),
          ),
          BoxShadow(
            color: AppColors.darkShadow,
            blurRadius: 6,
            offset: Offset(4, 4),
          ),
        ],
      ),
      child: TextField(
        controller: searchController,
        onChanged: _filterEvents,
        decoration: InputDecoration(
          hintText: "Search events...",
          hintStyle: const TextStyle(color: AppColors.textLight),
          prefixIcon: const Icon(Icons.search, color: AppColors.textLight),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 18,
          ),
        ),
        style: const TextStyle(color: AppColors.textDark),
      ),
    );
  }

  // EVENT CARD (Neumorphic)
  Widget _eventCard(Event event) {
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
          color: AppColors.background, // same as profile
          borderRadius: BorderRadius.circular(22),
          boxShadow: const [
            // Light top-left shadow
            BoxShadow(
              color: AppColors.lightShadow,
              offset: Offset(-4, -4),
              blurRadius: 8,
            ),
            // Dark bottom-right shadow
            BoxShadow(
              color: AppColors.darkShadow,
              offset: Offset(4, 4),
              blurRadius: 8,
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event Image
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.network(
                event.imageUrl,
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 16),

            // Title
            Text(
              event.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),

            const SizedBox(height: 6),

            // Time + Date
            Row(
              children: [
                const Icon(
                  Icons.access_time,
                  size: 16,
                  color: AppColors.textLight,
                ),
                const SizedBox(width: 6),
                Text(
                  event.time,
                  style: const TextStyle(color: AppColors.textLight),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Description
            Text(
              event.description,
              maxLines: 8,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                height: 1.4,
                color: AppColors.textLight,
              ),
            ),

            const SizedBox(height: 16),

            // Button
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
                      MaterialPageRoute(
                        builder: (_) => EventDetailPage(event: event),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(appBarTitles[_currentIndex]),
      ),
      body: _buildBody(),
    );
  }
}
