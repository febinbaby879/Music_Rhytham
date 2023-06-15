import 'package:flutter/material.dart';
import 'package:moon_walker/screens/contatants/const.dart';
import 'package:moon_walker/splashScreen/desgnSide.dart';
import 'package:moon_walker/widgets/bottomNavigationBar.dart';

class firstStar extends StatelessWidget {
  const firstStar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CurvedSplashScreen(
        screensLength: 3,
        screenBuilder: (index) {
          // Define the content of each screen based on the index
          if (index == 0) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  image:
                    DecorationImage(image: AssetImage(musicImages.instance.scaffBackImg),fit: BoxFit.cover)),
              child: SizedBox(),
            );
          } else if (index == 1) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/peakpx-2.jpg'),
                      fit: BoxFit.cover)),
              child: SizedBox(
              )
            );
          } else {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                'assets/images/peakpx-3.jpg',
              ),fit: BoxFit.cover),),
              child: SizedBox(),
            );
          }
        },
        onSkipButton: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => musicAppBottomNav()),
          );
        },
        firstGradiantColor: Colors.green,
        secondGradiantColor: Colors.red,
        backText: 'Back',
        skipText: 'Skip',
        forwardColor: Colors.deepPurple.shade800,
        forwardIconColor: Colors.red,
        textColor: Colors.deepPurple.shade800,
      ),
    );
  }
}
