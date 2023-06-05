import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:moon_walker/database/Allsongs/model/allSongModel.dart';
import 'package:moon_walker/screens/const.dart';

List<Audio> allSongsAudioList = [];
bool notification = true;
playingAudio(List<Songs> songs, int index) async {
  //currentlyplaying = songs[index];
  assetsAudioPlayer.stop();
  allSongsAudioList.clear();
  for (int i = 0; i < songs.length; i++) {
    allSongsAudioList.add(
      Audio.file(
        songs[i].songurl!,
        metas: Metas(
          title: songs[i].songname,
          artist: songs[i].artist,
          id: songs[i].id.toString(),
        ),
      ),
    );
  }
  await assetsAudioPlayer.open(
      Playlist(audios: allSongsAudioList, startIndex: index),
      //showNotification: notification,
      notificationSettings: const NotificationSettings(stopEnabled: false));
  assetsAudioPlayer.setLoopMode(LoopMode.playlist);
}
