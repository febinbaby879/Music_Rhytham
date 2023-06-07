import 'package:moon_walker/database/Allsongs/model/allSongModel.dart';
import 'package:moon_walker/database/Favourite/functions/fav_func.dart';
import 'package:moon_walker/database/play_lists/db_functions/play_listfunc.dart';
import 'package:moon_walker/screens/const.dart';
import 'package:on_audio_query/on_audio_query.dart';

class CheckPermission {
  //Permissin check cheyan vendi olla class Adym init state il vilikandeath ith anne
  //Becouse _hasPermission varieble nte result nokeet enam List lekk Song add cheyan

  static Future<bool> checkAndRequestPermissions({bool retry = false}) async {
    bool _hasPermission = false;
    _hasPermission = await audioQuery.checkAndRequest(
      retryRequest: retry,
    );
    //(!_hasPermission)? FetchSongss.fetchSongs:false;
    return _hasPermission;
  }
}

List<Songs> allSongs = [];
songfetch() async {
  List<SongModel> fetchsongs = await audioQuery.querySongs();
  for (SongModel element in fetchsongs) {
    if (element.fileExtension == "mp3") {
      allSongs.add(
        Songs(
            songname: element.displayNameWOExt,
            artist: element.artist,
            duration: element.duration,
            songurl: element.uri,
            id: element.id),
      );
    }
  }
  print(allSongs.length);
  //}
  await getFAvourite();
  //await recentfetch();
  //await playlistfetch();
  await getplayList();
}
