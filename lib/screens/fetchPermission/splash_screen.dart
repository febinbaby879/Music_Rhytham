
import 'package:flutter/material.dart';
import 'package:moon_walker/screens/fetchPermission/fetch.dart';
import 'package:moon_walker/widgets/bottomNavigationBar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}



class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    goToHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/7053026-silhouette-music-men-play-a-guitar-with-color-ink-splat-background-illustration-more-background.jpg',
              fit: BoxFit.cover,
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 2 - 50,
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text('Feel the power of\nRytham',
                      style: TextStyle(
                        color: Color.fromARGB(255, 204, 231, 47),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
    );
  }

  goToHome() async {
    FetchSongs fetchsong = FetchSongs();
    await fetchsong.songfetch();
    await Future.delayed(const Duration(seconds: 5),);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: ((context) => musicAppBottomNav()),
      ),
    );
  }
}
