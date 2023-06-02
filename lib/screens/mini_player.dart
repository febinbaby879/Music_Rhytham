import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moon_walker/screens/const.dart';
import 'package:moon_walker/screens/fetchPermission/fetch_songs.dart';
import 'package:moon_walker/screens/now_mini/now_playing.dart';

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
//             Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => nowPlaying(songIndex: widget.songIndex,)));
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
//                   assetsAudioPlayer.previous();
//                 },
//                 child: Icon(FontAwesomeIcons.backward),
//               ),
//               SizedBox(width: 10.0),
//               InkWell(
//                 onTap: () {
//                   setState(() {
//                     isPlaying = !isPlaying;
//                   });
//                   assetsAudioPlayer.playOrPause();
//                 },
//                 child: Icon(!isPlaying ? Icons.pause : Icons.play_arrow),
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
            // title: Text(
            //   allSongs[songIndex].displayName!,
            //   overflow: TextOverflow.ellipsis,
            // ),
            subtitle: Text(
              allSongs[songIndex].artist ?? '<unknown>',
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    assetsAudioPlayer.previous();
                  },
                  child: Icon(FontAwesomeIcons.backward),
                ),
                SizedBox(width: 12.0),
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
                      },),
                ),
                SizedBox(width: 12.0),
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



class MiniPLayer extends StatelessWidget {
  const MiniPLayer({super.key});

  @override
  Widget build(BuildContext context) {

    return assetsAudioPlayer.builderCurrent(
      builder: (context, playing) {
      return Container(
      height: 60,
      color: Colors.black.withOpacity(.1),
      child: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Row(
          children: [
            Container(
              width: 50,height: 50,
              child: Image.asset(
                'assets/images/lead.jpeg',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    assetsAudioPlayer.getCurrentAudioTitle,
                    style: GoogleFonts.oswald(),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    assetsAudioPlayer.getCurrentAudioArtist,
                    style: GoogleFonts.oswald(),
                    overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.skip_previous),
              onPressed: () {
               assetsAudioPlayer.previous();
              },
            ),
          //PlayForMini(),
            IconButton(
              icon: Icon(Icons.skip_next),
              onPressed: () {
                assetsAudioPlayer.next();
              },
            ),
          ],
        ),
      ),
    );
      },
    );
  }
}