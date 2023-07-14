
import 'package:on_audio_query/on_audio_query.dart';
import '../../core/contatants/const.dart';
import '../../domain/Allsongs/model/allSongModel.dart';
import '../dbfunc/favourite/fav_func.dart';
import '../dbfunc/most/mostlyplayed.dart';
import '../dbfunc/playlist/play_listfunc.dart';
import '../dbfunc/recent/recentdb.dart';

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
          id: element.id,
        ),
      );
    }
  }
  await getFAvourite();
  await getplayList();
  await mostplayedfetch();
  await recentfetch();
}
