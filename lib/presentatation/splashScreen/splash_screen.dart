import 'package:flutter/material.dart';
import 'package:moon_walker/widgets/bottomNavigationBar.dart';
import '../../infrastructure/functions/fetchsongs.dart';
import '../../infrastructure/functions/permissioncheck.dart';
import '../../core/contatants/const.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>  {
  @override
  void initState() {
    super.initState();
    initializeApp(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              MusicImages.instance.splashImage),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }


  Future<void> initializeApp(context) async {
    bool hasStoragePermission = false;
    hasStoragePermission = await CheckPermission.checkAndRequestPermissions();
    await Future.delayed(const Duration(seconds: 2));
    if (hasStoragePermission) {
      await songfetch();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => musicAppBottomNav(),
      ));
    }
  }
}
