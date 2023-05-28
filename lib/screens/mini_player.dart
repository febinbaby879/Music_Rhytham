import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:moon_walker/screens/const.dart';
import 'package:moon_walker/screens/fetchPermission/fetch_songs.dart';
import 'package:moon_walker/screens/now_playing.dart';

// class MiniPlayerWidget extends StatefulWidget {
//   final List<Audio> allSongsAudioList;
//   final int songIndex;

//   MiniPlayerWidget({
//     required this.allSongsAudioList,
//     required this.songIndex,
//   });

//   @override
//   _MiniPlayerWidgetState createState() => _MiniPlayerWidgetState();
// }

// class _MiniPlayerWidgetState extends State<MiniPlayerWidget> {
//   bool isPlaying = false;

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shape: BeveledRectangleBorder(
//         borderRadius: BorderRadius.circular(14),
//       ),
//       child: Container(
//         color: Color.fromARGB(255, 196, 196, 196),
//         height: MediaQuery.of(context).size.height * .089,
//         width: MediaQuery.of(context).size.width,
//         child: ListTile(
//           onTap: () {
//             Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => nowPlaying()));
//           },
//           leading: Image.asset(
//             'assets/images/7053026-silhouette-music-men-play-a-guitar-with-color-ink-splat-background-illustration-more-background.jpg',
//           ),
//           title: Text(
//             FetchSongss.allSongs[widget.songIndex].displayName,
//             overflow: TextOverflow.ellipsis,
//           ),
//           subtitle: Text(
//             FetchSongss.allSongs[widget.songIndex].artist ?? '<unknown>',
//             overflow: TextOverflow.ellipsis,
//           ),
//           trailing: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               InkWell(
//                 onTap: () {
//                   assetsAudioPlayer.stop();
//                   Navigator.of(context).pop();
//                 },
//                 child: Icon(Icons.stop),
//               ),
//               SizedBox(width: 10.0),
//               InkWell(
//                 onTap: () {
//                   setState(() {
//                     isPlaying = !isPlaying;
//                   });
//                   assetsAudioPlayer.playOrPause();
//                 },
//                 child: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
//               ),
//               SizedBox(width: 10.0),
//               InkWell(
//                 onTap: () {
//                   assetsAudioPlayer.next();
//                 },
//                 child: Icon(Icons.skip_next),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

void showMiniPlayer({
  required BuildContext context,
  required List<Audio> allSongsAudioList,
  required int songIndex,
}) {
  showBottomSheet(
    enableDrag: false,
    context: context,
    builder: (ctx) {
      return Card(
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: Container(
          color: Color.fromARGB(255, 196, 196, 196),
          height: MediaQuery.of(context).size.height * .089,
          width: MediaQuery.of(context).size.width,
          child: ListTile(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => nowPlaying()));
            },
            leading: Image.asset(
                'assets/images/7053026-silhouette-music-men-play-a-guitar-with-color-ink-splat-background-illustration-more-background.jpg'),
            title: Text(
              FetchSongss.allSongs[songIndex].displayName,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              FetchSongss.allSongs[songIndex].artist ?? '<unknown>',
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    assetsAudioPlayer.stop();
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.stop),
                ),
                SizedBox(width: 10.0),
                InkWell(
                  onTap: () {
                    assetsAudioPlayer.playOrPause();
                  },
                  child: PlayerBuilder.isPlaying(
                      player: assetsAudioPlayer,
                      builder: (context, isPlaying) {
                       if(isPlaying){
                        return Icon(Icons.pause);
                       }
                       else{
                        return Icon(Icons.play_arrow);
                       }
                      }),
                ),
                SizedBox(width: 10.0),
                InkWell(
                  onTap: () {
                    assetsAudioPlayer.next();
                  },
                  child: Icon(Icons.skip_next),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
