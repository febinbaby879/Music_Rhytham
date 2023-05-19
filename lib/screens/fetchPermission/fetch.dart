
import 'package:permission_handler/permission_handler.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FetchSongs {
  final OnAudioQuery audioquerry = OnAudioQuery();
  requestPermission() async {
    PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  songfetch() async {
    bool status = await requestPermission();
    if (status) {
      List<SongModel> fetchsongs = await audioquerry.querySongs(
      ignoreCase: true,
      orderType: OrderType.ASC_OR_SMALLER,
      sortType: null,
      uriType: UriType.EXTERNAL);


      List<Songs> allSongs = [];

      for (SongModel element in fetchsongs) {
        if (element.fileExtension == "mp3") {
          allSongs.add(
            Songs(
              songname: element.displayNameWOExt,
              artist: element.artist,
              duration: element.duration!,
              id: element.id,
              songurl: element.uri!),  
          );
        }
      }
    }
  }
}

class Songs {
  String songname;
  String? artist;
  int duration;
  int id;
  String songurl;

  Songs(
      {required this.songname,
      required this.artist,
      required this.duration,
      required this.id,
      required this.songurl});
}
