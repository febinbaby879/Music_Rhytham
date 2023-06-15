
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moon_walker/database/Allsongs/model/allSongModel.dart';
import 'package:moon_walker/screens/fetchPermission/fetch_songs.dart';

ValueNotifier<List<Songs>> recentList = ValueNotifier([]);

recentaddDB(Songs song) async {
  Box<int> recentDb = await Hive.openBox<int>('recent');
  List<int> temp = [];
  temp.addAll(recentDb.values);
  if (recentList.value.contains(song)) {
    recentList.value.remove(song);
    recentList.value.insert(0, song);
    for (int i = 0; i < temp.length; i++) {
      if (song.id == temp[i]) {
        recentDb.deleteAt(i);
        recentDb.add(song.id!);
      }
      //recentList.value.addAll(song.id);
    }
  } else {
    recentList.value.insert(0, song);
    recentDb.add(song.id!);
    if(recentList.value.length>10){
      recentList.value.removeAt(10);
    }
  }
  
  // print(recentDb.length);
  // recentfetch();
  recentList.notifyListeners();
}

recentfetch() async {
    Box<int> recentDb = await Hive.openBox('recent');

    // List<Songs> recenttemp = [];
    for (int element in recentDb.values) {
      for (Songs song in allSongs) {
        if (element == song.id) {
          // recenttemp.add(song);
    recentList.value.add(song);

          break;
        }
      }
    }
// log(recenttemp.length.toString());
log("ui list ${recentList.value.length}");
recentList.notifyListeners();
    //recentList.value = recenttemp.reversed.toList();
  }
