import 'package:flutter/material.dart';
import 'package:moon_walker/screens/contatants/const.dart';
import 'package:moon_walker/screens/fetchPermission/fetch_songs.dart';
import 'package:moon_walker/splashScreen/ImageScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  @override
  void initState() {
    super.initState();
    initializeApp();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(musicImages.instance.scaffBackImg),
            fit: BoxFit.cover,
            opacity: 230,
          ),
          gradient: LinearGradient(
            colors: ScafBack,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: _fadeAnimation,
            builder: (context, child) {
              return Opacity(
                opacity: _fadeAnimation.value,
                child: const Text(
                  'Feel the power of \n      RHYTHAM',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> initializeApp() async {
    bool hasStoragePermission = false;
    hasStoragePermission = await CheckPermission.checkAndRequestPermissions();
    await Future.delayed(const Duration(seconds: 4));
    if (hasStoragePermission) {
      await songfetch();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const firstStar(),
      ));
    }
  }
}
