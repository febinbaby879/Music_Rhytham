import 'package:hive_flutter/hive_flutter.dart';
import 'package:moon_walker/database/play_lists/model/play_list_model.dart';
import 'package:moon_walker/screens/playlist/add_toplaList.dart';
import 'package:moon_walker/screens/playlist/play_list_class.dart';

Future playlistCreating(playlistName) async {
  playListNotifier.value.insert(0, EachPlayList(name: playlistName),);
  Box<playListClass> playlistdb = await Hive.openBox('playlist');
  playlistdb.add(playListClass(playListName: playlistName),);
}
