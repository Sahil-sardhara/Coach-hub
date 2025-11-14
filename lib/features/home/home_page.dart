import 'package:coach_hub/features/auth/zoom/mock_zoom_meeting_page.dart';
import 'package:coach_hub/features/home/event_card.dart';
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
  int _currentIndex = 0; // Tracks selected tab
  final appBarTitles = ["My Events", "Zoom Meetings", "My Profile"];

  final List<Event> allEvents = [
    // --- 1. PAST EVENT (Completed) ---
    Event(
      title: "Startup Pitch Day & Networking Mixer",
      time: "10:00 AM, Oct 28 2025",
      description:
          "**Relive the excitement!** This highly-anticipated annual event featured 15 top student-led startups pitching their innovative ideas to a panel of venture capitalists and industry leaders. Keynote speaker Dr. Anya Sharma discussed 'Scaling Tech in a Post-AI World'. Attendees enjoyed a spirited networking session afterward. Check the archives for winner announcements!",
      imageUrl: "https://picsum.photos/400/200?random=4",
    ),

    // --- 2. LIVE EVENT (Currently Happening) ---
    Event(
      title: "AI Trends & Ethical Governance Talk (LIVE)",
      // Current time is 5:06 PM IST, so this event is running.
      time: "4:30 PM, Nov 14 2025",
      description:
          "**Happening now!** Join leading expert Dr. Ben Carter for a real-time, deep-dive discussion on the trajectory of Artificial Intelligence. We're covering critical topics like regulatory frameworks, bias mitigation in LLMs, and achieving transparent machine learning. Participants can submit questions live via the chat feature. Don't miss the Q&A session starting at 5:30 PM!",
      imageUrl: "https://picsum.photos/400/200?random=5",
    ),

    // --- 3. UPCOMING EVENT (Tomorrow) ---
    Event(
      title: "Tech Seminar: Next-Gen Flutter & Flow Development",
      time: "3 PM, Nov 15 2025",
      description:
          "Discover the future of cross-platform development. This seminar focuses on leveraging **Flutter Flow's visual builders** and advanced integration techniques to deploy powerful mobile and web applications faster than ever. We will cover state management best practices and how to use custom widgets efficiently. Ideal for developers looking to accelerate their workflow.",
      imageUrl: "https://picsum.photos/400/200?random=1",
    ),

    // --- 4. UPCOMING EVENT (The Day After) ---
    Event(
      title: "National Career Fair & Portfolio Review",
      time: "11 AM, Nov 16 2025",
      description:
          "Maximize your career potential! Over **50 Fortune 500 companies and growing startups** will be here recruiting for full-time roles and summer internships in engineering, design, and business. Bring your updated resume and portfolio for on-the-spot reviews and one-on-one sessions with hiring managers. Free headshots available for the first 100 attendees!",
      imageUrl: "https://picsum.photos/400/200?random=2",
    ),

    // --- 5. UPCOMING EVENT (Detailed time) ---
    Event(
      title: "Advanced Data Science Summit: MLOps Focus",
      time: "9:30 AM, Dec 1 2025",
      description:
          "A full-day technical summit dedicated to **MLOps (Machine Learning Operations)**. Sessions will cover deploying, managing, and scaling machine learning models in production environments using Kubernetes and cloud services (AWS/GCP). Prerequisite: familiarity with Python and basic ML concepts. Lunch and coffee breaks included.",
      imageUrl: "https://picsum.photos/400/200?random=6",
    ),

    // --- 6. UPCOMING EVENT (Workshop) ---
    Event(
      title: "Hands-On UI/UX Design Workshop",
      time: "6:00 PM, Dec 5 2025",
      description:
          "Learn the fundamental principles of user interface and user experience design. This interactive workshop will use **Figma** to teach prototyping, user flow mapping, and effective wireframing. Bring your laptop and be ready to design! Limited seating available; registration is mandatory.",
      imageUrl: "https://picsum.photos/400/200?random=7",
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
      setState(() {
        displayedEvents = List.from(allEvents);
      });
      return;
    }

    final filtered = allEvents.where((event) {
      final titleLower = event.title.toLowerCase();
      final searchLower = query.toLowerCase();
      return titleLower.contains(searchLower);
    }).toList();

    setState(() {
      displayedEvents = filtered;
    });
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0: // Events Tab
        return _eventsList();
      case 1: // Zoom Tab
        return MockZoomMeetingPage(); // Zoom Meeting Page
      case 2: // Profile Tab
        return ProfilePage(); // Profile Page
      default:
        return _eventsList(); // Default is Events List
    }
  }

  Widget _eventsList() {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_buildSearchField(isDark)],
          ),
        ),

        // 👇 THIS FIXES THE OVERFLOW
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 20),
            itemCount: displayedEvents.length,
            itemBuilder: (context, index) {
              final event = displayedEvents[index];
              return EventCard(
                title: event.title,
                time: event.time,
                imageUrl: event.imageUrl,
                description: event.description,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchField(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.3)
                : Colors.grey.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: searchController,
        onChanged: _filterEvents,
        decoration: InputDecoration(
          hintText: "Search events...",
          prefixIcon: Icon(
            Icons.search,
            color: isDark ? Colors.white70 : Colors.grey,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 16,
          ),
        ),
        style: TextStyle(color: isDark ? Colors.white : Colors.black87),
      ),
    );
  }

  Widget _eventCard(Event event, bool isDark) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => EventDetailPage(event: event)),
        );
      },
      child: Hero(
        tag: event.title,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: isDark
                  ? [Colors.grey[800]!, Colors.grey[850]!]
                  : [Colors.white, Colors.grey[50]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.2),
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
                child: Image.network(
                  event.imageUrl,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 16,
                          color: isDark ? Colors.white70 : Colors.grey,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          event.time,
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark ? Colors.white70 : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      event.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark ? Colors.white70 : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MockZoomMeetingPage(event: event),
                            ),
                          );
                        },
                        child: const Text(
                          "Join Now",
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
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitles[_currentIndex]),
        backgroundColor: AppColors.primary,
      ),

      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.event), label: "Events"),
          BottomNavigationBarItem(icon: Icon(Icons.video_call), label: "Zoom"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
