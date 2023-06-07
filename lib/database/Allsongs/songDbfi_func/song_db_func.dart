import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:moon_walker/database/Allsongs/model/allSongModel.dart';

ValueNotifier<List<Songs>> allsongBodyNotifier = ValueNotifier([]);

addSongs(Songs allSongs) async {
  allsongBodyNotifier.value.insert(
      0,
      Songs(
          songname: allSongs.songname,
          artist: allSongs.artist,
          duration: allSongs.duration,
          songurl: allSongs.songurl,
          id: allSongs.id));
  final allDB = await Hive.openBox<Songs>('allsongs');
  Songs temp = Songs(
      songname: allSongs.songname,
      artist: allSongs.artist,
      duration: allSongs.duration,
      songurl: allSongs.songurl,
      id: allSongs.id);
  await allDB.put(allSongs.id, temp);
  //print(allDB.length);
}

getSongs() async {
  final allDB = await Hive.openBox<Songs>('allsongs');
  
}
