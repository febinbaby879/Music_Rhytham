import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moon_walker/database/Allsongs/model/allSongModel.dart';
import 'package:moon_walker/database/Favourite/model/model.dart';
import 'package:moon_walker/screens/splash_screen.dart';
import 'package:moon_walker/screens/theme.dart';
import 'package:provider/provider.dart';

Future<void> main(List<String> args) async {
  await Hive.initFlutter();
  if(!Hive.isAdapterRegistered(SongsAllAdapter().typeId)){
    Hive.registerAdapter(SongsAllAdapter());
  }
  await Hive.openBox<SongsAll>(boxname);
  if(!Hive.isAdapterRegistered(FavmodelAdapter().typeId)){
    Hive.registerAdapter(FavmodelAdapter(),);
  }
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
     SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
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
