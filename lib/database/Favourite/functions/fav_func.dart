import 'package:hive_flutter/hive_flutter.dart';
import 'package:moon_walker/database/Allsongs/model/allSongModel.dart';
import 'package:moon_walker/database/Favourite/model/model.dart';
import 'package:moon_walker/screens/favaouriteScreen/favouriteScreen.dart';
import 'package:moon_walker/screens/fetchPermission/fetch_songs.dart';


Future<void> addFavourat(SongsAll songs)async{
favarotList.value.insert(0, songs);
 Box <Favmodel>favDB=await Hive.openBox<Favmodel>('Favarout');
 Favmodel temp=Favmodel(id: songs.id);
 favDB.add(temp);
 
 print(favDB.length);
}

  favFetch() async {
  favarotList.value.clear();
  List<Favmodel> favSongCheck = [];
  final favDb = await Hive.openBox<Favmodel>('favouriteDB');
  favSongCheck.addAll(favDb.values);
  for (var favs in favSongCheck) {
    int count = 0;
    for (var songs in allSongs) {
      if (favs.id == songs.id) {
        favarotList.value.add(songs);
        break;
      } else {
        count++;
      }
    }
    if (count == allSongs.length) {
      var key = favs.key;
      favDb.delete(key);
    }
  }
  favarotList.notifyListeners();
}
  


removeFavourite(SongsAll song) async {
  favarotList.value.remove(song);
  List<Favmodel> templist = [];
  Box<Favmodel> favdb = await Hive.openBox('favorite');
  templist.addAll(favdb.values);
  for (var element in templist) {
    if (element.id == song.id) {
      var key = element.key;
      favdb.delete(key);
      break;
    }
  }
}