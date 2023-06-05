import 'package:moon_walker/database/Allsongs/model/allSongModel.dart';
import 'package:moon_walker/database/Favourite/functions/fav_func.dart';
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

// Future<void> fetchSongs() async {
//   List<SongModel> fetchSongs = await audioQuery.querySongs(
//     ignoreCase: true,
//     orderType: OrderType.ASC_OR_SMALLER,
//     sortType: null,
//     uriType: UriType.EXTERNAL,
//   );

//   List<SongModel> filteredSongs = [];

//   for (var element in fetchSongs) {
//     //if (element.fileExtension == 'mp3') {
//       filteredSongs.add(element);
//     //}
//   }

//   allSongs = filteredSongs.map((element) => SongsAll(
//     songname: element.displayName,
//     artist: element.artist,
//     duration: element.duration,
//     id: element.id,
//     songurl: element.uri,
//   )).toList();

//   allSongs.forEach((element) {
//     box.add(
//       element,
//     );
//   });

//   print('${box.values.length}');
// }

// final box = SongBox.getInstance();

List<Songs> allSongs = [];
songfetch() async {
  // bool status = await requestPermission();
  // if (status) {
  List<SongModel> fetchsongs = await audioQuery.querySongs(
      ignoreCase: true,
      orderType: OrderType.ASC_OR_SMALLER,
      sortType: null,
      uriType: UriType.EXTERNAL);
  for (SongModel element in fetchsongs) {
    //if (element.fileExtension == "mp3") {
      allSongs.add(Songs(
          songname: element.displayNameWOExt,
          artist: element.artist,
          duration: element.duration,
          songurl: element.uri,
          id: element.id));
    //}
  }print(allSongs.length);
  //}
  await favFetch();
  //await recentfetch();
  //await playlistfetch();
}
