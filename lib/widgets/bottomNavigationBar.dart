import 'package:flutter/material.dart';
import 'package:moon_walker/screens/homeList.dart';
import 'package:moon_walker/screens/mostplayed.dart';
import 'package:moon_walker/screens/recent_page.dart';
import 'package:moon_walker/screens/setting.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class musicAppBottomNav extends StatefulWidget {
  musicAppBottomNav({super.key});
  @override
  State<musicAppBottomNav> createState() => _musicAppBottomNavState();
}

class _musicAppBottomNavState extends State<musicAppBottomNav> {
  final pages = [
    MyHomePage(), 
    RecentList(), 
    MostPlayed(), 
    SettingsScreen()
    ];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          pages[_selectedIndex],
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Container(
          color: Colors.grey.shade400,
          child: GNav(
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            backgroundColor: Colors.grey,
            tabBackgroundColor: Colors.grey.shade400,
            padding: EdgeInsets.all(14),
            tabs: [
              GButton(
                icon: Icons.music_note_outlined,
                text: 'All songs',
              ),
              GButton(
                icon: Icons.recommend,
                text: 'Recent play',
              ),
              GButton(
                icon: Icons.motion_photos_off,
                text: 'Most songs',
              ),
              GButton(
                icon: Icons.settings,
                text: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
