import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

final AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
final OnAudioQuery audioQuery = OnAudioQuery();


List<Color> miniplayerColor = [
  Colors.deepPurple.shade800.withOpacity(.5),
  Colors.white12,
  Colors.deepPurple.shade800.withOpacity(.5),
];
List<Color> scafBack = [
  Colors.deepPurple.shade800.withOpacity(.8),
  Colors.deepPurple.shade200.withOpacity(.3)
];

class MusicImages{

  static MusicImages instance = MusicImages();
  final String splashImage='assets/images/peakpx-2.jpg';
  final String scaffBackImg="assets/images/abcd.jpg";
  final String favBoxImg="assets/images/hsdbkc.jpeg";
  final String playImg="assets/images/air.webp";
  final String mostBoxImg='assets/images/images.jpeg';
  final String queryImage='assets/images/musizz.jpg';
  final String miniIMG='assets/images/Unknown.34.jpeg';
  final String playListImg='assets/images/img2.jpg';
}