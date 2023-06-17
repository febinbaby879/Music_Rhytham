import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:moon_walker/database/Allsongs/model/allSongModel.dart';
import 'package:moon_walker/screens/contatants/const.dart';

List<Audio> allSongsAudioList = [];
bool notification = true;
double volume = 1;
AudioConvert(List<Songs> songs, int index) async {
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
    volume: volume,
    Playlist(audios: allSongsAudioList, startIndex: index),
    showNotification: notification,
    notificationSettings: const NotificationSettings(stopEnabled: false),
  );
  assetsAudioPlayer.setLoopMode(LoopMode.playlist);
}


