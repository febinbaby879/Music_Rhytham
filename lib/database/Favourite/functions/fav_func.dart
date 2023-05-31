import 'package:hive_flutter/hive_flutter.dart';
import 'package:moon_walker/database/Allsongs/model/allSongModel.dart';
import 'package:moon_walker/database/Favourite/model/model.dart';
import 'package:moon_walker/screens/favaouriteScreen/favouriteScreen.dart';


Future<void> addFavourat(SongsAll songs)async{
favarotList.value.insert(0, songs);
 Box <Favmodel> favDB=await Hive.openBox('Favarout');
 Favmodel temp=Favmodel(id: songs.id!);
 favDB.add(temp);
 print('add');
 favarotList.notifyListeners();
}
removeFavourite(SongsAll song) async {
  print('remo');
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
  favarotList.notifyListeners();
  }