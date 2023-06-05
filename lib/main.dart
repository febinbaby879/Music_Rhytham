import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moon_walker/database/Favourite/model/model.dart';
import 'package:moon_walker/database/play_lists/model/play_list_model.dart';
import 'package:moon_walker/screens/splash_screen.dart';
import 'package:moon_walker/screens/dark_mode/theme.dart';
import 'package:provider/provider.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if(!Hive.isAdapterRegistered(playListClassAdapter().typeId)){
    Hive.registerAdapter(playListClassAdapter());
  }
  // if(!Hive.isAdapterRegistered(SongsAllAdapter().typeId)){
  //   Hive.registerAdapter(SongsAllAdapter());
  // }
  //await Hive.openBox<Songs>(boxname);
  if(!Hive.isAdapterRegistered(FavmodelAdapter().typeId)){
    Hive.registerAdapter(FavmodelAdapter(),);
  }
  if(!Hive.isAdapterRegistered(playListClassAdapter().typeId)){
    Hive.registerAdapter(playListClassAdapter());
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
