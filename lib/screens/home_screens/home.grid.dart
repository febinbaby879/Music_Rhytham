import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moon_walker/screens/home_screens/homeList.dart';
import 'package:moon_walker/widgets/bottomNavigationBar.dart';
import 'package:moon_walker/widgets/gridviewhome.dart';

class homeGrid extends StatelessWidget {
  const homeGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0B054B),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            child: Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      Text("Let's feel it", style: TextStyle(color: Colors.white)),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (ctx) => MyHomePage(),
                            ),
                          );
                        },
                        icon: Icon(
                          FontAwesomeIcons.list,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Row(
                    children: [
                      Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width * .4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              image: AssetImage(
                              'assets/images/best websites for free music1640190686306255.jpg'),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Spacer(),
                      Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width * .4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                          image: AssetImage(
                          'assets/images/166142112-mans-hands-playing-acoustic-guitar-close-up-acoustic-guitars-playing-music-concept-guitars.jpg'),
                          fit: BoxFit.cover),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*.01,
                ),
                Container(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text('Favourites'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 130.0),
                        child: Text(
                          'Playlist',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "All Songs",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*.02,
                ),
                Expanded(
                  child: gridHome(),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: musicAppBottomNav(),
    );
  }
}
