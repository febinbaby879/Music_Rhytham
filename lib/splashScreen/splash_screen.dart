
import 'package:flutter/material.dart';
import 'package:moon_walker/database/Recent/recentDB/recentdb.dart';
import 'package:moon_walker/screens/fetchPermission/fetch_songs.dart';
import 'package:moon_walker/splashScreen/ImageScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/cover.jpeg',
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
                        color: Color.fromARGB(255, 159, 24, 174),
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

  
  Future<void> initializeApp() async {
    bool hasStoragePermission = false;
    await Future.delayed(Duration(seconds: 2));
    hasStoragePermission = await CheckPermission.checkAndRequestPermissions();
    if (hasStoragePermission) {
      await songfetch();
     // await recentfetch();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>firstStar(),));
    }
  }
}
