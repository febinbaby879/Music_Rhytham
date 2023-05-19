import 'package:flutter/material.dart';
import 'package:moon_walker/screens/fetchPermission/splash_screen.dart';
import 'package:moon_walker/screens/theme.dart';
import 'package:provider/provider.dart';

Future<void> main(List<String> args) async {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: Provider.of<ThemeModel>(context).currentThemeMode ==
        ThemeModeType.light
          ? ThemeMode.light
          : ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
