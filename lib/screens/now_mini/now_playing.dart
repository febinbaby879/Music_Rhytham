import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moon_walker/screens/contatants/const.dart';
import 'package:on_audio_query/on_audio_query.dart';

class nowPlaying extends StatefulWidget {
  nowPlaying({super.key});

  @override
  State<nowPlaying> createState() => _nowPlayingState();
}

class _nowPlayingState extends State<nowPlaying> {
  bool isShuffleEnabled = false;
  bool isRepeatenabled = false;
  bool isfav = false;

  double volume = 0.3;
  void setVolume(double value) {
    setState(() {
      volume = value;
    });
    assetsAudioPlayer.setVolume(value);
  }

  void enableRepeat() {
  assetsAudioPlayer.setLoopMode(LoopMode.single);
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'NOW PLAYING',
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(top: 13.0, left: 20),
          child: InkWell(
            child: const FaIcon(FontAwesomeIcons.angleLeft),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(musicImages.instance.scaffBackImg),
              fit: BoxFit.cover,
              opacity: 230),
          gradient: LinearGradient(
              colors: ScafBack,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: SafeArea(
          child: Column(
            children: [
              assetsAudioPlayer.builderCurrent(
                builder: (context, playing) {
                  int id = int.parse(playing.audio.audio.metas.id!);
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * .45,
                          decoration: const BoxDecoration(),
                          child: ClipOval(
                            child: QueryArtworkWidget(
                              id: id,
                              type: ArtworkType.AUDIO,
                              nullArtworkWidget: Image.asset(
                                musicImages.instance.queryImage,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                             const Icon(Icons.volume_down_sharp),
                              SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  trackHeight:
                                      1.0, // Adjust the height of the slider track
                                  thumbShape: const RoundSliderThumbShape(
                                      enabledThumbRadius:
                                          7.0), // Adjust the size of the thumb
                                  activeTrackColor: Colors.deepPurple[
                                      300], // Set the color of the active track
                                  inactiveTrackColor: Colors.deepPurple[
                                      200], // Set the color of the inactive track
                                  thumbColor: Colors
                                      .deepPurpleAccent, // Set the color of the thumb
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
                          child: SizedBox(
                            child: Column(
                              children: [
                                Text(
                                  assetsAudioPlayer.getCurrentAudioTitle,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .01,
                                ),
                                Text(assetsAudioPlayer.getCurrentAudioArtist),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .03,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: PlayerBuilder.currentPosition(
                              player: assetsAudioPlayer,
                              builder: (context, duration) {
                                final totalDuration = assetsAudioPlayer
                                    .current.value?.audio.duration;
                                return ProgressBar(
                                  progress: duration,
                                  total: totalDuration!,
                                  progressBarColor: Colors.deepPurple[400],
                                  baseBarColor: Colors.deepPurple[200],
                                  bufferedBarColor:
                                      Colors.blue.withOpacity(0.24),
                                  thumbColor: Colors.deepPurpleAccent,
                                  barHeight: 3.0,
                                  thumbRadius: 7.0,
                                  onSeek: (duration) {
                                    assetsAudioPlayer.seek(duration);
                                  },
                                );
                              }),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .02,
                        ),
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              colors: miniplayerColor,
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          width: 150,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                tooltip: 'Shuffle',
                                onPressed: () {
                                  assetsAudioPlayer.toggleShuffle();
                                  setState(() {
                                    isShuffleEnabled = !isShuffleEnabled;
                                    
                                  });
                                },
                                icon: Icon(
                                  isShuffleEnabled
                                      ? Icons.shuffle_on_sharp
                                      : Icons.shuffle,
                                  color: Colors.deepPurpleAccent,
                                ),
                              ),
                              IconButton(
                                tooltip: 'Favaurite',
                                onPressed: () {
                                  setState(() {
                                    isfav = !isfav;
                                  });
                                },
                                icon: Icon(
                                  isfav
                                      ? Icons.favorite_sharp
                                      : Icons.favorite_border_sharp,
                                  color: Colors.deepPurpleAccent,
                                ),
                              ),
                              IconButton(
                                tooltip: 'Repeat',
                                onPressed: () {
                                  enableRepeat();
                                  setState(() {
                                    isRepeatenabled = !isRepeatenabled;
                                    
                                  });
                                },
                                icon: Icon(
                                  isRepeatenabled
                                      ? Icons.repeat_on
                                      : Icons.repeat,
                                  color: Colors.deepPurpleAccent,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .03,
                        ),
                        Container(
                          height: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(21),
                            gradient: LinearGradient(
                              colors: miniplayerColor,
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                onPressed: () {
                                  assetsAudioPlayer.previous();
                                },
                                icon: Icon(
                                  FontAwesomeIcons.backward,
                                  color: Colors.deepPurple[400],
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  skipBackward(const Duration(seconds: 10));
                                },
                                icon: Icon(Icons.replay_10,
                                    size: 30, color: Colors.deepPurple[300]),
                              ),
                              InkWell(
                                onTap: () {
                                  assetsAudioPlayer.playOrPause();
                                },
                                child: SizedBox(
                                  child: PlayerBuilder.isPlaying(
                                    player: assetsAudioPlayer,
                                    builder: (context, isPlaying) {
                                      if (isPlaying) {
                                        return const Icon(
                                          Icons.pause,
                                          size: 38,
                                          color: Colors.deepPurple,
                                        );
                                      } else {
                                        return Icon(
                                          Icons.play_arrow,
                                          color: Colors.deepPurple[400],
                                          size: 38,
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  skipForward(const Duration(seconds: 10));
                                },
                                icon: Icon(
                                  Icons.forward_10,
                                  size: 30,
                                  color: Colors.deepPurple[300],
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  assetsAudioPlayer.next();
                                },
                                icon: Icon(FontAwesomeIcons.forward,
                                    color: Colors.deepPurple[400]),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .03,
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(
                width: MediaQuery.of(context).size.height,
              ),
            ],
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
}
