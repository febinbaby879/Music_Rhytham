import 'package:flutter/material.dart';

enum ThemeModeType { light, dark }

class ThemeModel extends ChangeNotifier {
  ThemeModeType _currentThemeMode = ThemeModeType.light;

  ThemeModeType get currentThemeMode => _currentThemeMode;

  void toggleTheme() {
    _currentThemeMode = _currentThemeMode == ThemeModeType.light
      ? ThemeModeType.dark
      : ThemeModeType.light;
    notifyListeners();
  }
}
