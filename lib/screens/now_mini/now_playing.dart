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
  bool isRepeatenabled=false;
  bool isfav=false;
  double volume = 0.3;
  void setVolume(double value) {
    setState(() {
      volume = value;
    });
    assetsAudioPlayer.setVolume(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        elevation: 0,
        title: const Text(
          'NOW PLAYING',
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(top: 13.0, left: 20),
          child: InkWell(
            child: FaIcon(FontAwesomeIcons.angleLeft),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: assetsAudioPlayer.builderCurrent(
          builder: (context, playing) {
            // ValueNotifier<bool> isLoopOn = ValueNotifier(false);
            // ValueNotifier<bool> isShuffleOn = ValueNotifier(false);
            // ValueNotifier<bool> isFavOn = ValueNotifier(false);
            return Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .45,
                    decoration: BoxDecoration(),
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
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackHeight:
                                1.0, // Adjust the height of the slider track
                            thumbShape: RoundSliderThumbShape(
                                enabledThumbRadius:
                                    7.0), // Adjust the size of the thumb
                            activeTrackColor: Colors
                                .red, // Set the color of the active track
                            inactiveTrackColor: Colors
                                .grey, // Set the color of the inactive track
                            thumbColor:
                                Colors.lightGreen, // Set the color of the thumb
                          ),
                          child: Slider(
                            value: volume,
                            min: 0.0,
                            max: 1.0,
                            onChanged: setVolume,
                          ),
                        ),
                        Text('${(volume * 100).toStringAsFixed(0)}%'),
                      ],
                    ),
                  ),
                   SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                  Center(
                    child: Container(
                      child: Column(
                        children: [
                          Text(
                            assetsAudioPlayer.getCurrentAudioTitle,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .01,
                          ),
                          Text(assetsAudioPlayer.getCurrentAudioArtist),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .03,
                  ),
                  PlayerBuilder.currentPosition(
                      player: assetsAudioPlayer,
                      builder: (context, duration) {
                        final totalDuration =
                        assetsAudioPlayer.current.value?.audio.duration;
                        return ProgressBar(
                          progress: duration,
                          total: totalDuration!,
                          progressBarColor: Colors.red,
                          baseBarColor: Colors.grey,
                          bufferedBarColor: Colors.blue.withOpacity(0.24),
                          thumbColor: Colors.lightGreen,
                          barHeight: 3.0,
                          thumbRadius: 7.0,
                          onSeek: (duration) {
                            assetsAudioPlayer.seek(duration);
                          },
                        );
                      }),
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
                            Icons.replay_10,size: 30,
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
                          icon: Icon(Icons.forward_10,size: 30,),
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .03,
                  ),
                  Container(
                    width: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(tooltip: 'Shuffle',
                          onPressed: () {
                           setState(() {
                            isShuffleEnabled=!isShuffleEnabled;
                             assetsAudioPlayer.toggleShuffle();
                           });
                          },
                          icon: Icon(isShuffleEnabled? Icons.shuffle:Icons.shuffle_on_sharp),
                        ),
                        IconButton(tooltip: 'Favaurite',
                          onPressed: () {
                            setState(() {
                              isfav=!isfav;
                            });
                          },
                          icon: Icon(isfav?Icons.favorite_sharp:Icons.favorite_border_sharp),
                        ),
                        IconButton(tooltip: 'Repeat',
                          onPressed: () {
                            setState(() {
                              isRepeatenabled=!isRepeatenabled;
                            });
                          },
                          icon: Icon(
                            isRepeatenabled?Icons.repeat:Icons.repeat_on
                          ),
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
    );
  }

  void skipForward(Duration duration) {
    assetsAudioPlayer.seekBy(duration);
  }

  void skipBackward(Duration duration) {
    assetsAudioPlayer.seekBy(-duration);
  }
}
