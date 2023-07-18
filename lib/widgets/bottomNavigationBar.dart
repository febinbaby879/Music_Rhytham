import 'package:ff_navigation_bar_plus/ff_navigation_bar_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moon_walker/application/nav_bar/nav_bar_bloc.dart';
import 'package:moon_walker/presentatation/recentsongs/recentJUstcheck.dart';
import 'package:moon_walker/presentatation/home_screens/homeList.dart';
import 'package:moon_walker/presentatation/settings/setting.dart';

class musicAppBottomNav extends StatelessWidget {
  musicAppBottomNav({super.key});
  final pages = [
    const RecentPage(),
    const MyHomePage(),
    const SettingsScreen(),
  ];


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LandingPageBloc, LandingPageState>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              pages[state.tabIndex],
            ],
          ),
          bottomNavigationBar: FFNavigationBar(
            theme: FFNavigationBarTheme(
                barBackgroundColor: Colors.white,
                selectedItemBackgroundColor: Colors.purple,
                selectedItemIconColor: Colors.white,
                selectedItemLabelColor: Colors.purple,
                unselectedItemIconColor: Colors.purple.shade200,
                unselectedItemLabelColor: Colors.purple.shade300),
            selectedIndex: state.tabIndex,
            // onSelectTab: (index) {
            //   setState(() {
            //     _selectedIndex = index;
            //   });
            // },
            onSelectTab: (index){
              BlocProvider.of<LandingPageBloc>(context)
                  .add(TabChange(tabIndex: index));
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
      },
    );
  }
}
