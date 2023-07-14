import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moon_walker/presentatation/dark_mode/theme.dart';
import 'package:moon_walker/presentatation/splashScreen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'domain/Allsongs/model/allSongModel.dart';
import 'domain/Favourite/model/model.dart';
import 'domain/play_lists/model/play_list_model.dart';



Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if(!Hive.isAdapterRegistered(SongsAdapter().typeId)){
    Hive.registerAdapter(SongsAdapter());
  }
  if(!Hive.isAdapterRegistered(playListClassAdapter().typeId)){
    Hive.registerAdapter(playListClassAdapter());
  }
  if(!Hive.isAdapterRegistered(FavmodelAdapter().typeId)){
    Hive.registerAdapter(FavmodelAdapter());
  }
  
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeModel(),
      child: const MyApp(),
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
      home:const SplashScreen(),
    );
  }
}
