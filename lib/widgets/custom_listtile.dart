import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:moon_walker/screens/const.dart';
import 'package:moon_walker/screens/fetchPermission/convert_audio.dart';
import 'package:moon_walker/screens/fetchPermission/fetch_songs.dart';
import 'package:moon_walker/screens/mini_player.dart';
import 'package:moon_walker/widgets/popup_main.dart';
import 'package:on_audio_query/on_audio_query.dart';

class CustomListTile extends StatefulWidget {
  const CustomListTile({super.key, required this.songIndex});
  final int songIndex;

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    List<Audio> songAudioList = convertToAudioList(FetchSongss.allSongs);
    Size size = MediaQuery.of(context).size;
    final SongModel song = FetchSongss.allSongs[widget.songIndex];
    return InkWell(
      onTap: () async {
        await assetsAudioPlayer.stop();
        await assetsAudioPlayer.open(
          showNotification: true,
            Playlist(
              audios: songAudioList,
            ),
            loopMode: LoopMode.playlist //loop the full playlist
            );

        await assetsAudioPlayer.playlistPlayAtIndex(
        widget.songIndex);
       // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>));
        showMiniPlayer(
        context: context,
        allSongsAudioList: songAudioList,
        songIndex: widget.songIndex);
      },
      child: SizedBox(
        height: 70,
        width: double.infinity,
        child: Card(
          color: Color.fromARGB(255, 171, 143, 143),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          child: ListTile(
            leading: LeadingAvathar(song: song),
            title: SongDetails(size: size, song: song),
            trailing: popupAllSongs(),
          ),
        ),
      ),
    );
  }
}

class SongDetails extends StatelessWidget {
  const SongDetails({
    super.key,
    required this.size,
    required this.song,
  });
  final SongModel song;
  final Size size;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
            width: size.width * 0.6,
            child: Text(
              song.displayName,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            height: 20,
            width: size.width * 0.6,
            child: Text(
              maxLines: 1,
              song.artist ?? '<Unknown>',
              overflow: TextOverflow.fade,
            ),
          ),
        ],
      ),
    );
  }
}

class LeadingAvathar extends StatelessWidget {
  const LeadingAvathar({
    super.key,
    required this.song,
  });
  final SongModel song;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: Material(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 175, 31, 31),
              borderRadius: BorderRadius.circular(10)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: QueryArtworkWidget(
              artworkClipBehavior: Clip.none,
              nullArtworkWidget: Image.asset(
                'assets/images/best websites for free music1640190686306255.jpg',
                fit: BoxFit.cover,
              ),
              // controller: audioQuery,
              id: song.id,
              type: ArtworkType.AUDIO,
            ),
          ),
        ),
      ),
    );
  }
}

