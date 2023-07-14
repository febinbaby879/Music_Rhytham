import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moon_walker/infrastructure/dbfunc/most/mostlyplayed.dart';
import 'package:moon_walker/core/contatants/const.dart';
import 'package:moon_walker/presentatation/now_mini/now_playing.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../infrastructure/dbfunc/recent/recentdb.dart';

class miniLast extends StatefulWidget {
  miniLast({super.key});

  @override
  State<miniLast> createState() => _miniLastState();
}

class _miniLastState extends State<miniLast> {
  
  @override
  Widget build(BuildContext context) {   
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => nowPlaying(),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 3,
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.width * 0.18,
          width: MediaQuery.of(context).size.width * 1,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(MusicImages.instance.miniIMG),fit: BoxFit.cover,opacity: 190),
              gradient: LinearGradient(
                colors: miniplayerColor,
                begin: Alignment.bottomLeft,
                end: Alignment.bottomRight),
            ),
            child: assetsAudioPlayer.builderCurrent(
              builder: (context, playing) {
               int id= int.parse(playing.audio.audio.metas.id!);
               currentPlayingfinder(id);
               mostlyPlayedaddTodb(id);
                return Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.width * .15,
                        width: MediaQuery.of(context).size.width * .15,
                        child: ClipOval(
                          child: QueryArtworkWidget(
                            id: id,
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget: Image.asset(
                              MusicImages.instance.queryImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
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
                    ),
                    IconButton(
                      icon:const Icon(
                        Icons.skip_previous),
                      onPressed: () {
                        assetsAudioPlayer.previous();
                      },
                    ),
                    InkWell(
                      onTap: () {
                        assetsAudioPlayer.playOrPause();
                      },
                      child: PlayerBuilder.isPlaying(
                        player: assetsAudioPlayer,
                        builder: (context, isPlaying) {
                          if (isPlaying) {
                            return const Icon(Icons.pause);
                          } else {
                            return const Icon(Icons.play_arrow);
                          }
                        },
                      ),
                    ),
                    IconButton(
                      icon:const Icon(Icons.skip_next),
                      onPressed: () {
                        assetsAudioPlayer.next();
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
  
}
