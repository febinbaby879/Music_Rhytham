
import 'package:moon_walker/database/Allsongs/model/allSongModel.dart';
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

// there is no relation to both function becouse one function return
// permission esult and this function add Songs to embty list.
class FetchSongss {
  static List<SongModel> allSongs = [];
  static Future<void> fetchSongs() async {
    //OnAudioQuery audioQuery = OnAudioQuery();
    allSongs.addAll(
      await audioQuery.querySongs(),
    );
    allSongs.forEach(
      (element) {
        if(element.fileExtension=='mp3'){
        box.add(SongsAll(
          songname: element.title,
          artist: element.artist,
          duration: element.duration,
          id: element.id,
          songurl: element.uri),
          );
        }
        //print(element.size);
      },
    );
    //print('${box.values.length}');
  }
}

final box = SongBox.getInstance();
