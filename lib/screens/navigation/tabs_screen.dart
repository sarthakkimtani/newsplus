// ignore_for_file: use_key_in_widget_constructors
import "package:flutter/material.dart";

import './home_screen.dart';
import './markets_screen.dart';
import './saved_screen.dart';
import './watchlist_screen.dart';
import '../../widgets/app_drawer.dart';
import '../../configs/custom_icons.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = "/tabs";
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Map<String, Object>> _pages;

  @override
  void initState() {
    _pages = [
      {"page": HomeScreen(), "title": "News+"},
      {"page": MarketsScreen(), "title": "Markets"},
      {"page": WatchlistScreen(), "title": "Watchlist"},
      {"page": SavedScreen(), "title": "Saved"},
    ];
    super.initState();
  }

  int _selectedIndex = 0;

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
        children: _pages.map((data) => data['page'] as Widget).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        onTap: _selectPage,
        enableFeedback: false,
        showUnselectedLabels: true,
        unselectedLabelStyle: const TextStyle(fontFamily: "Montserrat"),
        selectedLabelStyle: const TextStyle(fontFamily: "Montserrat"),
        unselectedItemColor: const Color(0xFFa0b0ba),
        selectedItemColor: Theme.of(context).primaryColor,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(CustomIcons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(CustomIcons.bar), label: "Markets"),
          BottomNavigationBarItem(
              icon: Icon(CustomIcons.eye_outline),
              activeIcon: Icon(CustomIcons.eye),
              label: "Watchlist"),
          BottomNavigationBarItem(
              icon: Icon(CustomIcons.bookmark_empty),
              activeIcon: Icon(CustomIcons.bookmark),
              label: "Saved"),
        ],
      ),
    );
  }
}
