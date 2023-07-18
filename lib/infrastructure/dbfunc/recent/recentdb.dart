import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moon_walker/presentatation/recentsongs/recentJUstcheck.dart';
import '../../../domain/Allsongs/model/allSongModel.dart';
import '../../functions/fetchsongs.dart';

ValueNotifier<List<Songs>> recentList = ValueNotifier([]);

// recentaddDB(Songs song) async {
//   Box<int> recentDb = await Hive.openBox<int>('recent');
//   List<int> temp = [];
//   temp.addAll(recentDb.values);
//   if (recentList.value.contains(song)) {
//     recentList.value.remove(song);
//     recentList.value.insert(0, song);
//     for (int i = 0; i < temp.length; i++) {
//       if (song.id == temp[i]) {
//         recentDb.deleteAt(i);
//         recentDb.add(song.id!);
//       }
//     }
//   } else {
//     recentList.value.insert(0, song);
//     recentDb.add(song.id!);
//     if (recentList.value.length > 10) {
//       recentList.value.removeAt(10);
//     }
//   }

//   // print(recentDb.length);
//   // recentfetch();
//   recentList.notifyListeners();
// }

Future<List<Songs>> recentadd(Songs song) async {
  Box<int> recentDb = await Hive.openBox('recent');
  List<int> temp = [];
  temp.addAll(recentDb.values);
  if (recentlist.contains(song)) {
    recentlist.remove(song);
    recentlist.insert(0, song);
    for (int i = 0; i < temp.length; i++) {
      if (song.id == temp[i]) {
        recentDb.deleteAt(i);
        recentDb.add(song.id!);
      }
    }
  } else {
    recentlist.insert(0, song);
    recentDb.add(song.id!);
  }
  if (recentlist.length > 10) {
    recentlist = recentlist.sublist(0, 10);
    recentDb.deleteAt(0);
  }
  List<Songs> recent = [];
  recent.addAll(recentlist);

  return recent;
  // recentListNotifier.notifyListeners();
}

Future<List<Songs>> recentremove(Songs song) async {
  Box<int> recentDb = await Hive.openBox('recent');
  recentlist.remove(song);
  // recentDb.delete(song.id);
  List<int> temp = [];
  temp.addAll(recentDb.values);

  for (int i = 0; i < temp.length; i++) {
    if (song.id == temp[i]) {
      recentDb.deleteAt(i);
    }
  }

  List<Songs> recent = [];
  recent.addAll(recentlist);

  return recent;
}

// recentfetch() async {
//   Box<int> recentDb = await Hive.openBox('recent');

//   // List<Songs> recenttemp = [];
//   for (int element in recentDb.values) {
//     for (Songs song in allSongs) {
//       if (element == song.id) {
//         // recenttemp.add(song);
//         recentList.value.add(song);
//         break;
//       }
//     }
//   }
//   log("ui list ${recentList.value.length}");
//   recentList.notifyListeners();
// }

  Future<List<Songs>> recentfetchh() async {
    Box<int> recentDb = await Hive.openBox('recent');
    List<Songs> recenttemp = [];
    for (int element in recentDb.values) {
      for (Songs song in allSongs) {
        if (element == song.id) {
          recenttemp.add(song);
          break;
        }
      }
    }
    recentlist = recenttemp.reversed.toList();
    List<Songs> recentfetch = [];
    recentfetch.addAll(recentlist);
    return recentfetch;
  }

Songs? currentlyplaying;
currentPlayingfinder(int playigid) {
  for (Songs songs in allSongs) {
    if (songs.id == playigid) {
      currentlyplaying = songs;
    }
  }
  recentadd(currentlyplaying!);
}
