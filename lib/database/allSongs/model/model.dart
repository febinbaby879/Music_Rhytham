import 'package:hive_flutter/adapters.dart';
part 'model.g.dart';
@HiveType(typeId: 1)
class allSongs extends HiveObject{
  @HiveField(0)
  String? songName;
  @HiveField(1)
  String? artist;
  @HiveField(2)
  int? duration;
  @HiveField(3)
  int? id;
  @HiveField(4)
  String? songurl;
  allSongs(
      {required this.songName,
      required this.artist,
      required this.duration,
      required this.id,
      required this.songurl});
}
