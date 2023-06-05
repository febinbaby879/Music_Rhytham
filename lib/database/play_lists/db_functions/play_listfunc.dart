import 'package:hive_flutter/hive_flutter.dart';
import 'package:moon_walker/database/Allsongs/model/allSongModel.dart';
import 'package:moon_walker/database/play_lists/model/play_list_model.dart';
import 'package:moon_walker/screens/playlist/playListUnique.dart';
import 'package:moon_walker/screens/playlist/play_list.dart';
import 'package:moon_walker/screens/playlist/play_list_class.dart';

Future playlistCreating(playlistName) async {
  playListNotifier.value.insert(0, EachPlayList(name: playlistName),);
  Box<playListClass> playlistdb = await Hive.openBox('playlist');
  playlistdb.add(playListClass(playListName: playlistName),);
}


Future playlistrename(int index, String newname) async {
  String playlistname = playListNotifier.value[index].name;
  Box<playListClass> playlistdb = await Hive.openBox('playlist');
  for (playListClass element in playlistdb.values) {
    if (element.playListName == playlistname) {
      var key = element.key;
      element.playListName = newname;
      playlistdb.put(key, element);
    }
  }
  playListNotifier.value[index].name = newname;
  playListNotifier.notifyListeners();
  playlistBodyNotifier.notifyListeners();
}

Future playlistAddDB(Songs addingSong, String playlistName) async {
  Box<playListClass> playlistdb = await Hive.openBox('playlist');

  for (playListClass element in playlistdb.values) {
    if (element.playListName == playlistName) {
      var key = element.key;
      playListClass ubdatePlaylist = playListClass(playListName: playlistName);
      ubdatePlaylist.items.addAll(element.items);
      ubdatePlaylist.items.add(addingSong.id!);
      playlistdb.put(key, ubdatePlaylist);
      break;
    }
  }
  plusiconNotifier.notifyListeners();
}


Future playlistdelete(int index) async {
  String playlistname = playListNotifier.value[index].name;
  Box<playListClass> playlistdb = await Hive.openBox('playlist');
  for (playListClass element in playlistdb.values) {
    if (element.playListName == playlistname) {
      var key = element.key;
      playlistdb.delete(key);
      break;
    }
  }
  playListNotifier.value.removeAt(index);
  playListNotifier.notifyListeners();
  playlistBodyNotifier.notifyListeners();
}

Future playlistRemoveDB(Songs removingSong, String playlistName) async {
  Box<playListClass> playlistdb = await Hive.openBox('playlist');
  for (playListClass element in playlistdb.values) {
    if (element.playListName == playlistName) {
      var key = element.key;
      playListClass ubdatePlaylist = playListClass(playListName: playlistName);
      for (int item in element.items) {
        if (item == removingSong.id) {
          continue;
        }
        ubdatePlaylist.items.add(item);
      }
      playlistdb.put(key, ubdatePlaylist);
      break;
    }
  }
}