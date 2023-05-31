import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:moon_walker/database/Allsongs/model/allSongModel.dart';
List<Audio> allSongsAudioList = [];
List<Audio> convertToAudioList(List<SongsAll> allSongs) {
//Convertinh=g audio to embty list
//We can reusse this list becouse every separated list we
//create embty list so we add this function to add
//that file aseparatly


  for (var x = 0; x < allSongs.length; x++) {
    allSongsAudioList.add(
      Audio.file(
        allSongs[x].songurl!,
        metas: Metas(
          title: allSongs[x].songname,
          artist: allSongs[x].artist,
          id: allSongs[x].id.toString(),
          
        ),
      ),
    );
  }
  return allSongsAudioList;
}


// playingAudio(List<SongsAll> songs, int index) async {
//   currentlyplaying = songs[index];
//   assetsAudioPlayer.stop();
//   allSongsAudioList.clear();
//   for (int i = 0; i < songs.length; i++) {
//     allSongsAudioList.add(Audio.file(songs[i].songurl!,
//         metas: Metas(
//           title: songs[i].displayName,
//           artist: songs[i].artist,
//           id: songs[i].id.toString(),
//         )));
//   }
//   await assetsAudioPlayer.open(Playlist(audios: allSongsAudioList, startIndex: index),
//       showNotification: notification,
//       notificationSettings: const NotificationSettings(stopEnabled: false));
//   assetsAudioPlayer.setLoopMode(LoopMode.playlist);
// }

// currentsongFinder(int? playingId) {
//   for (SongsAll song in allSongs) {
//     if (song.id == playingId) {
//       currentlyplaying = song;
//       break;
//     }
//   }
//   //recentadd(currentlyplaying!);
// }