import 'package:assets_audio_player/assets_audio_player.dart';

List<Audio>convertToAudioList(List<dynamic> allSongs){
//Convertinh=g audio to embty list
//We can reusse this list becouse every separated list we 
//create embty list so we add this function to add
//that file aseparatly 
  List<Audio> allSongsAudioList=[];

  for(var x=0;x<allSongs.length;x++){
    allSongsAudioList.add(Audio.file(
      allSongs[x].uri!,metas: Metas(
        title: allSongs[x].displayName,
        artist: allSongs[x].artist,
        id: allSongs[x].id.toString(),
      ),
    ),);
  }
  return allSongsAudioList;
}