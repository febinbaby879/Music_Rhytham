import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moon_walker/screens/const.dart';
import 'package:on_audio_query/on_audio_query.dart';

class nowPlaying extends StatefulWidget {
  nowPlaying({super.key});

  @override
  State<nowPlaying> createState() => _nowPlayingState();
}

class _nowPlayingState extends State<nowPlaying> {
  bool isShuffleEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'NOW PLAYING',
          style: TextStyle(
              fontFamily: 'Peddana', fontWeight: FontWeight.w600, fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: assetsAudioPlayer.builderCurrent(
            builder: (context, playing) {
              return Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * .45,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                blurStyle: BlurStyle.outer,
                                blurRadius: 21,
                                color: Colors.blue),
                          ],
                        ),
                        child: ClipOval(
                          child: QueryArtworkWidget(
                            id: int.parse(playing.audio.audio.metas.id!),
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget: Image.asset(
                              'assets/images/musizz.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .04,
                    ),
                    Center(
                      child: Container(
                        child: Text(
                          assetsAudioPlayer.getCurrentAudioTitle,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    PlayerBuilder.currentPosition(
                        player: assetsAudioPlayer,
                        builder: (context, duration) {
                          final totalDuration =
                          assetsAudioPlayer.current.value?.audio.duration;
                          return ProgressBar(
                            progress: duration,
                            total: totalDuration!,
                            progressBarColor: Colors.blue,
                            baseBarColor: Colors.blue.withOpacity(0.24),
                            bufferedBarColor: Colors.blue.withOpacity(0.24),
                            thumbColor: Colors.blue,
                            barHeight: 4.0,
                            thumbRadius: 7.0,
                            onSeek: (duration) {
                              assetsAudioPlayer.seek(duration);
                            },
                          );
                        }),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .04,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(FontAwesomeIcons.shuffle),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              FontAwesomeIcons.repeat,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: () {
                              assetsAudioPlayer.previous();
                            },
                            icon: Icon(FontAwesomeIcons.backward),
                          ),
                          IconButton(
                            onPressed: () {
                              skipBackward(Duration(seconds: 10));
                            },
                            icon: Icon(
                              FontAwesomeIcons.backwardFast,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              assetsAudioPlayer.playOrPause();
                            },
                            child: PlayerBuilder.isPlaying(
                                player: assetsAudioPlayer,
                                builder: (context, isPlaying) {
                                  if (isPlaying) {
                                    return Icon(
                                      Icons.pause,
                                      size: 38,
                                      color: Colors.red,
                                    );
                                  } else {
                                    return Icon(
                                      Icons.play_arrow,
                                      size: 38,
                                    );
                                  }
                                }),
                          ),
                          IconButton(
                            onPressed: () {
                              skipForward(Duration(seconds: 10));
                            },
                            icon: Icon(FontAwesomeIcons.forwardFast),
                          ),
                          IconButton(
                            onPressed: () {
                              assetsAudioPlayer.next();
                            },
                            icon: Icon(FontAwesomeIcons.forward),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void skipForward(Duration duration) {
    assetsAudioPlayer.seekBy(duration);
  }

  void skipBackward(Duration duration) {
    assetsAudioPlayer.seekBy(-duration);
  }
// void toggleShuffle() {
//   isShuffleEnabled = !isShuffleEnabled;
//   assetsAudioPlayer.playlistAudioPlayer.setShuffleModeEnabled(isShuffleEnabled);
// }
}
