import 'package:hive_flutter/hive_flutter.dart';
import '../../../domain/Allsongs/model/allSongModel.dart';
import '../../../domain/play_lists/model/play_list_model.dart';
import '../../../presentatation/playlist/play_list.dart';
import '../../../presentatation/playlist/play_list_class.dart';
import '../../functions/fetchsongs.dart';




Future playlistCreating(playlistName) async {
  playListNotifier.value.insert(0, uniqueList(name: playlistName));
  Box<playListClass> playlistdb = await Hive.openBox('playlist');
  playlistdb.add(playListClass(playListName: playlistName));
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  playListNotifier.notifyListeners();
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  playlistBodyNotifier.notifyListeners();
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
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  playListNotifier.notifyListeners();
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  playlistBodyNotifier.notifyListeners();
}

getplayList() async {
  Box<playListClass> playlistdb = await Hive.openBox('PlayList');
  for (playListClass elements in playlistdb.values) {
    String playlistname = elements.playListName;
    uniqueList getplayList = uniqueList(name: playlistname);
    for (int id in elements.items) {
      for (Songs songs in allSongs) {
        if (id == songs.id) {
          getplayList.Container.add(songs);
          break;
        }
      }
    }
    playListNotifier.value.add(getplayList);
  }
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
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  playListNotifier.notifyListeners();
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  playlistBodyNotifier.notifyListeners();
}

Future playListSongDelete(Songs removingSong, String playlistName) async {
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
