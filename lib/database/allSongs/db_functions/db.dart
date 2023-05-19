import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moon_walker/database/allSongs/model/model.dart';


ValueNotifier<List<allSongs>> songListNotifier=ValueNotifier([]);

Future<void> addSong(allSongs song) async {
  var box = await Hive.openBox<allSongs>('fullSong');
  await box.add(song);
  songListNotifier.notifyListeners();
  print(box.length);
}

Future<List<allSongs>> getAllSongs() async {
  var box = await Hive.openBox<allSongs>('fullSong');
  return box.values.toList();
  songListNotifier.notifyListeners();
}
