import 'package:hive_flutter/hive_flutter.dart';
part 'allSongModel.g.dart';
@HiveType(typeId: 0)
class Songs {
  @HiveField(0)
  String? songname;
  @HiveField(1)
  String? artist;
  @HiveField(2)
  int? duration;
  @HiveField(3)
  String? songurl;
  @HiveField(4)
  int? id;
  Songs(
    {required this.songname,
    required this.artist,
    required this.duration,
    required this.songurl,
    required this.id});
}
