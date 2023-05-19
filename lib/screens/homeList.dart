import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moon_walker/screens/favouriteScreen.dart';
import 'package:moon_walker/screens/play_list.dart';
import 'package:moon_walker/widgets/listView.dart';
import 'package:shimmer/shimmer.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 20.0, top: 12, left: 20),
          child: Container(
            child: Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 200.0,
                        height: 60.0,
                        child: Shimmer.fromColors(
                          baseColor: Color.fromARGB(255, 206, 141, 136),
                          highlightColor: Color.fromARGB(255, 99, 93, 38),
                          child: Padding(
                            padding: const EdgeInsets.only(top:8.0),
                            child: Text(
                              "Lets' feel it",
                              style: GoogleFonts.aBeeZee(
                                fontSize: 30.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      Text('data'),
                      IconButton(
                        onPressed: () {
                        },
                        icon: Icon(
                          Icons.grid_view_rounded,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) => searchscreen(),
                          //   ),
                          // );
                        },
                        icon: Icon(
                          Icons.search,
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
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                              builder: (context) => favouriteScreen()),
                            );
                          },
                        ),
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
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => playList()),
                            );
                          },
                        ),
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
                  height: 10,
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
                  height: MediaQuery.of(context).size.height*.02,
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "All Songs",
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*.02,
                ),
                Expanded(
                  child: LiistView(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
