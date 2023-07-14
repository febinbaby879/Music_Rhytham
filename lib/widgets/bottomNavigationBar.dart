import 'package:ff_navigation_bar_plus/ff_navigation_bar_plus.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moon_walker/presentatation/recentsongs/recentJUstcheck.dart';
import 'package:moon_walker/presentatation/home_screens/homeList.dart';
import 'package:moon_walker/presentatation/settings/setting.dart';

class musicAppBottomNav extends StatefulWidget {
  musicAppBottomNav({super.key});
  @override
  State<musicAppBottomNav> createState() => _musicAppBottomNavState();
}

class _musicAppBottomNavState extends State<musicAppBottomNav> {
  final pages = [
    
    //RecentList(),
    RecentPage(),
    MyHomePage(),
    SettingsScreen(),
  ];
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          pages[_selectedIndex],
        ],
      ),
      bottomNavigationBar: FFNavigationBar(
        theme: FFNavigationBarTheme(
          barBackgroundColor: Colors.white,
          selectedItemBackgroundColor: Colors.purple,
          selectedItemIconColor: Colors.white,
          selectedItemLabelColor: Colors.purple,
          unselectedItemIconColor: Colors.purple.shade200,
          unselectedItemLabelColor: Colors.purple.shade300
        ),
        selectedIndex: _selectedIndex,
        onSelectTab: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          FFNavigationBarItem(
            iconData: FontAwesomeIcons.recycle,
            label: 'Rececnts',
          ),
          FFNavigationBarItem(
            iconData: Icons.home_filled,
            label: 'Home',
          ),
          FFNavigationBarItem(
            iconData: Icons.settings,
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
