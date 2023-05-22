
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selecteditems = 0;

  List<Widget> screens = [
    AllSongs(),
    HomePage(),
    Favourites(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      backgroundColor: Color.fromARGB(255, 173, 168, 246),
      appBar: PreferredSize(
          preferredSize:
              Size(double.infinity, MediaQuery.of(context).size.height * 0.05),
          child: CustomAppBar(
              iconnButton: selecteditems == 2 ? false : true,
              title: selecteditems == 1
                  ? 'HOME'
                  : selecteditems == 0
                      ? 'ALL SONGS'
                      : 'FAVOURITES')),
      body: screens[selecteditems],
      bottomNavigationBar: CurvedNavigationBar(
        index: selecteditems,
        backgroundColor: Color.fromARGB(255, 173, 168, 246),
        color: Color.fromARGB(255, 108, 99, 255),
        items: const [
          Icon(
            Icons.music_note_outlined,
            color: Colors.white,
            size: 40,
          ),
          Icon(
            Icons.home,
            color: Colors.white,
            size: 40,
          ),
          Icon(
            Icons.favorite,
            color: Colors.white,
            size: 40,
          )
        ],
        onTap: (int i) {
          setState(() {
            selecteditems = i;
          });
        },
      ),
    );
  }
}

class SideBar extends StatelessWidget {
  const SideBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Color.fromARGB(255, 211, 208, 255),
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color.fromARGB(255, 3, 3, 3),
                Color.fromARGB(0, 114, 107, 249)
              ], 
              begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              child: Center(
                child: Text(
                  'M U Z O',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontFamily: 'KumbhSans',
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                children: [
                  settings(
                    title: 'Share Muzo',
                    icon: Icons.share,
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  settings(
                    title: 'Privacy Policy',
                    icon: Icons.privacy_tip_outlined),
                  SizedBox(
                    height: 7,
                  ),
                  settings(title: 'Terms & Conditions', icon: Icons.gavel),
                  SizedBox(
                    height: 7,
                  ),
                  settings(
                    title: 'About Us',
                    icon: Icons.info_outline,
                    toNextPage: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Column(
                              children: [
                                Icon(
                                  Icons.info,
                                  color: Color.fromARGB(255, 248, 70, 70),
                                ),
                                Text(
                                  'MUZO',
                                  style: TextStyle(
                                    fontFamily: 'KumbhSans', fontSize: 20),
                                )
                              ],
                            ),
                            content: Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,'),
                            actions: [
                              TextButton.icon(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  ),
                                  label: Text('OK'))
                            ],
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            ),),
            Expanded(
                child: Stack(
              children: [
                Positioned(
                    bottom: -100,
                    child: Ellipse(color: Color.fromARGB(54, 89, 52, 255))),
                Positioned(
                    left: -100,
                    bottom: -30,
                    child: Ellipse(color: Color.fromRGBO(158, 158, 158, 0.249)))
              ],
            ),)
          ],
        ));
  }

  ListTile settings(
  {required String title, required IconData icon, Function()? toNextPage}) {
    return ListTile(
      onTap: toNextPage,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          color: Color.fromARGB(255, 255, 255, 255),
          fontFamily: 'KumbhSans',
        ),
      ),
      leading: CircleAvatar(
        radius: 20,
        child: Icon(
          icon,
          color: Colors.grey,
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}