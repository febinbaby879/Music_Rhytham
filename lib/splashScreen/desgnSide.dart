import 'package:flutter/material.dart';
import 'package:moon_walker/screens/contatants/const.dart';

class CurvedSplashScreen extends StatefulWidget {
  /// Number of screens you want to add
  final int screensLength;
  final Widget Function(int index) screenBuilder;
  final Color firstGradiantColor;
  final Color secondGradiantColor;
  final String backText;
  final String skipText;
  final Color forwardColor;
  final Color forwardIconColor;
  final Color textColor;
  final Function onSkipButton;

  CurvedSplashScreen({
    Key? key,
    required this.screensLength,
    required this.screenBuilder,
    required this.onSkipButton,
    required this.firstGradiantColor,
    required this.secondGradiantColor,
    required this.backText,
    required this.skipText,
    required this.forwardColor,
    required this.forwardIconColor,
    required this.textColor,
  }) : super(key: key);

  @override
  _CurvedSplashScreenState createState() => _CurvedSplashScreenState();
}

class _CurvedSplashScreenState extends State<CurvedSplashScreen> {
  int currentPageIndex = 0;
  late PageController _pageController;

  @override
  Widget build(BuildContext context) {
    SizeConfig.initSize(context);
    _pageController = PageController(initialPage: 0);

    return Scaffold(
      body: PageView.builder(
        itemCount: widget.screensLength,
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        itemBuilder: (context, index) =>
            Center(child: widget.screenBuilder(index)),
      ),
      bottomSheet: CurvedSheet(
        totalPages: widget.screensLength,
        currentPage: currentPageIndex,
        firstGradiantColor: widget.firstGradiantColor,
        secondGradiantColor: widget.secondGradiantColor,
        backText: widget.backText,
        skipText: widget.skipText,
        forwardColor: widget.forwardColor,
        forwardIconColor: widget.forwardIconColor,
        textColor: widget.textColor,
        skip: () {
          widget.onSkipButton();
        },
        back: () {
          _pageController.jumpToPage(_pageController.page!.toInt() - 1);
        },
        onPressed: () {
          if (_pageController.page! < widget.screensLength - 1) {
            _pageController.animateToPage(
              _pageController.page!.toInt() + 1,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeIn,
            );
          } else {
            widget.onSkipButton();
          }
        },
      ),
    );
  }
}

class CurvedSheet extends StatelessWidget {
  final int totalPages;
  final int currentPage;
  final Function onPressed;
  final Function back;
  final Function skip;
  final Color firstGradiantColor;
  final Color secondGradiantColor;
  final String backText;
  final String skipText;
  final Color forwardColor;
  final Color forwardIconColor;
  final Color textColor;
  const CurvedSheet({
    Key? key,
    required this.totalPages,
    required this.currentPage,
    required this.onPressed,
    required this.back,
    required this.skip,
    required this.firstGradiantColor,
    required this.secondGradiantColor,
    required this.backText,
    required this.skipText,
    required this.forwardColor,
    required this.forwardIconColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: ScafBack,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
            height: 140,
          ),
        ),
        ForwardButtom(
            forwardColor: forwardColor,
            forwardIconColor: forwardIconColor,
            onPressed: onPressed),
        Positioned.fill(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: getRelativeWidth(0.05))
                .copyWith(bottom: getRelativeHeight(0.04)),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (back != null) {
                        back();
                      }
                    },
                    child: Text(
                      backText,
                      style: TextStyle(
                        color: textColor,
                        fontSize: getRelativeWidth(0.048),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: getSplashDots(totalPages, currentPage),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (skip != null) {
                        skip();
                      }
                    },
                    child: Text(
                      skipText,
                      style: TextStyle(
                        color: textColor,
                        fontSize: getRelativeWidth(0.048),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class ForwardButtom extends StatelessWidget {
  const ForwardButtom({
    Key? key,
    required this.onPressed,
    required this.forwardColor,
    required this.forwardIconColor,
  }) : super(key: key);

  final Function onPressed;
  final Color forwardColor;
  final Color forwardIconColor;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: GestureDetector(
        onTap: () {
          if (onPressed != null) {
            onPressed();
          }
        },
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: forwardColor,
            ),
            height: getRelativeWidth((1 / 5)),
            width: getRelativeWidth((1 / 5)),
            child: Icon(
              Icons.arrow_forward,
              size: getRelativeWidth((0.08)),
              color: forwardIconColor,
            ),
          ),
        ),
      ),
    );
  }
}

List<Widget> getSplashDots(int maxLength, int selectedDot) {
  List<Widget> dots = [];
  for (int i = 0; i < maxLength; i++) {
    dots.add(
      Row(
        children: [
          Container(
            height: getRelativeHeight(0.01),
            decoration: BoxDecoration(
                color: selectedDot == i
                    ? Colors.black.withOpacity(0.9)
                    : Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(15)),
            width: selectedDot == i
                ? getRelativeWidth(0.038)
                : getRelativeWidth(0.022),
          ),
          if (i < maxLength - 1) ...[
            SizedBox(width: getRelativeWidth(0.015)),
          ]
        ],
      ),
    );
  }
  return dots;
}

class SizeConfig {
  static double screenWidth = 100;
  static double screenHeight = 100;

  static initSize(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    screenWidth = mediaQuery.size.width;
    screenHeight = mediaQuery.size.height;
  }
}

double getRelativeHeight(double percentage) {
  return percentage * SizeConfig.screenHeight;
}

double getRelativeWidth(double percentage) {
  return percentage * SizeConfig.screenWidth;
}
