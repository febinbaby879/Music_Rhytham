

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moon_walker/database/Allsongs/model/allSongModel.dart';
import 'package:moon_walker/database/Recent/recentDB/recentdb.dart';
import 'package:moon_walker/screens/fetchPermission/fetch_songs.dart';

ValueNotifier<List<Songs>> mostplay = ValueNotifier([]);

// mostlyPlayDBadd(Songs song) async {
//   final Box<int> mostPlayDB = await Hive.openBox('most');
//   int cnt = (mostPlayDB.get(song.id) ?? 0) + 1;
//   mostPlayDB.put(song.id, cnt);
//   if (cnt > 3 && mostplay.value.contains(song.id)) {
//     mostplay.value.remove(song);
//     mostplay.value.add(song);
//     mostplay.notifyListeners();
//   }
//   if (mostplay.value.length > 9) {
//     mostplay.value = mostplay.value.sublist(0, 9);
//   }

//   mostplay.notifyListeners();
//   log("${mostPlayDB.length}");
//    mostplayFetch();
// }


// mostplayFetch() async {
//   final Box<int> mostPlayDB = await Hive.openBox('most');
//   if (mostPlayDB.isEmpty) {
//     for (Songs element in allSongs) {
//       mostPlayDB.put(element.id, 0);
//     }
//   } else {
//     for (int id in mostPlayDB.keys) {
//       int cnt = mostPlayDB.get(id) ?? 0;
//       if (cnt > 3) {
//         for (Songs element in allSongs) {
//           if (element.id == id) {
//             mostplay.value.add(element);
//             break;
//           }
//         }
//       }
//     }
//     if (mostplay.value.length > 8) {
//       mostplay.value = mostplay.value.sublist(0, 8);
//     }
//     mostplay.notifyListeners();
//   }
// }


Songs? currentlyplaying;
currentPlayingfinder(int playigid) {
  for (Songs songs in allSongs) {
    if (songs.id == playigid) {
      currentlyplaying = songs;
    }
  }
  // mostlyPlayDBadd(currentlyplaying!);
  recentaddDB(currentlyplaying!);
}




// -----adding to mostly playeddb
mostlyPlayedaddTodb(int id) async {
  Box<int> mostplayeddb = await Hive.openBox('mostplayed');
  int count = mostplayeddb.get(id)!;
  mostplayeddb.put(id, count + 1);
  await mostlyplayedaddtolist();
}

// mostly played list refreshing ----

mostlyplayedaddtolist() async {
  Box<int> mostplayedDb = await Hive.openBox('mostplayed');
  mostplay.value.clear();

  List<List<int>> mostplayedTemp = [];

  for (Songs song in allSongs) {
    int count = mostplayedDb.get(song.id)!;
    mostplayedTemp.add([song.id!, count]);
  }
  for (int i = 0; i < mostplayedTemp.length - 1; i++) {
    for (int j = i; j < mostplayedTemp.length; j++) {
      if (mostplayedTemp[i][1] < mostplayedTemp[j][1]) {
        List<int> temp = mostplayedTemp[i];
        mostplayedTemp[i] = mostplayedTemp[j];
        mostplayedTemp[j] = temp;
      }
    }
  }
  List<List<int>> temp = [];
  for (int i = 0; i < mostplayedTemp.length && i < 10; i++) {
    temp.add(mostplayedTemp[i]);
  }

  mostplayedTemp = temp;
  for (List<int> element in mostplayedTemp) {
    for (Songs song in allSongs) {
      if (element[0] == song.id && element[1] > 3) {
        mostplay.value.add(song);
      }
    }
  }
}

mostplayedfetch() async {
    Box<int> mostplayedDb = await Hive.openBox('mostplayed');
    if (mostplayedDb.isEmpty) {
      for (Songs song in allSongs) {
        mostplayedDb.put(song.id, 0);
      }
    } else {
      List<List<int>> mostplayedTemp = [];
      for (Songs song in allSongs) {
        int count = mostplayedDb.get(song.id)!;
        mostplayedTemp.add([song.id!, count]);
      }
      for (int i = 0; i < mostplayedTemp.length - 1; i++) {
        for (int j = i; j < mostplayedTemp.length; j++) {
          if (mostplayedTemp[i][1] < mostplayedTemp[j][1]) {
            List<int> temp = mostplayedTemp[i];
            mostplayedTemp[i] = mostplayedTemp[j];
            mostplayedTemp[j] = temp;
          }
        }
      }

      List<List<int>> temp = [];
      for (int i = 0; i < mostplayedTemp.length && i < 10; i++) {
        temp.add(mostplayedTemp[i]);
      }

      mostplayedTemp = temp;
      for (List<int> element in mostplayedTemp) {
        for (Songs song in allSongs) {
          if (element[0] == song.id && element[1] > 3) {
            mostplay.value.add(song);
          }
        }
      }
    }
  }