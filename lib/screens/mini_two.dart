import 'package:flutter/material.dart';

class AppStyleModeNotifier extends ChangeNotifier {
  bool mode = true; //0 for light and 1 for dark
  Color primaryBackgroundColor = Colors.white;
  Color appBarBackgroundColor = Colors.cyan[200]!;
  Color boxColor = Colors.blue[50]!;
  Color boxTextColor = Colors.indigo;
  Color primaryTextColor = Colors.white;
  Color dashboardColor = Colors.cyan;
  Color dashboardTextColor = Colors.red[600]!;
  Color dashboardIconColor = Colors.yellow[200]!;
  //Color typeMessageBoxColor = Colors.grey[200];

  switchMode() {
    if (mode == true) {
      //if it is light mode currently switch to dark
      primaryBackgroundColor = Colors.grey[900]!;
      appBarBackgroundColor = Colors.grey[800]!;
      // boxColor = Colors.grey[600];
      boxColor = Colors.black;
      boxTextColor = Colors.grey[100]!;
      primaryTextColor = Colors.black;
      dashboardColor = Colors.grey[900]!;
      dashboardTextColor = Colors.grey[400]!;
      dashboardIconColor = Colors.white;
      //typeMessageBoxColor = Colors.grey[800];
      mode = false;
    } else {
      //if it is dark mode currently switch to light
      primaryBackgroundColor = Colors.white;
      appBarBackgroundColor = Colors.cyan[200]!;
      boxColor = Colors.tealAccent;
      boxTextColor = Colors.indigo;
      primaryTextColor = Colors.white;
      dashboardColor = Colors.cyan;
      dashboardTextColor = Colors.red[600]!;
      dashboardIconColor = Colors.yellow[200]!;
      //typeMessageBoxColor = Colors.grey[200];
      mode = true;
    }

    notifyListeners();
  }
}
