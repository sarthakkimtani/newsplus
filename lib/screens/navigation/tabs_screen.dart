import "package:flutter/material.dart";

import "./home_screen.dart";
import "./markets_screen.dart";
import "./saved_screen.dart";
import "./watchlist_screen.dart";
import "./members_screen.dart";
import "../../widgets/app_drawer.dart";
import "../../configs/custom_icons.dart";
import "../../services/notification_service.dart";

class TabsScreen extends StatefulWidget {
  static const routeName = "/tabs";

  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Map<String, Object>> _pages;

  int _selectedIndex = 0;
  bool _isInit = true;

  @override
  void initState() {
    super.initState();

    _pages = [
      {"page": const HomeScreen(), "title": "News+"},
      {"page": const MarketsScreen(), "title": "Markets"},
      {"page": const WatchlistScreen(), "title": "Watchlist"},
      {"page": const MembersScreen(), "title": "Members"},
      {"page": const SavedScreen(), "title": "Saved"},
    ];

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => NotificationService.initializeService(context),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, int>?;
      if (args != null && args.containsKey("initialIndex")) {
        _selectedIndex = args["initialIndex"]!;
      }
      _isInit = false;
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedIndex]["title"] as String),
      ),
      drawer: AppDrawer(),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages.map((data) => data["page"] as Widget).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        onTap: _selectPage,
        enableFeedback: false,
        showUnselectedLabels: true,
        unselectedLabelStyle: const TextStyle(fontFamily: "Poppins"),
        selectedLabelStyle: const TextStyle(fontFamily: "Poppins"),
        unselectedItemColor: const Color(0xFFa0b0ba),
        selectedItemColor: Theme.of(context).primaryColor,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CustomIcons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(CustomIcons.bar),
            label: "Markets",
          ),
          BottomNavigationBarItem(
            icon: Icon(CustomIcons.eye_outline),
            activeIcon: Icon(CustomIcons.eye),
            label: "Watchlist",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            activeIcon: Icon(Icons.people),
            label: "Members",
          ),
          BottomNavigationBarItem(
            icon: Icon(CustomIcons.bookmark_empty),
            activeIcon: Icon(CustomIcons.bookmark),
            label: "Saved",
          ),
        ],
      ),
    );
  }
}
