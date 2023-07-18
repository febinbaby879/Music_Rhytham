import 'package:hive_flutter/hive_flutter.dart';
import 'package:moon_walker/presentatation/favaouriteScreen/favouriteScreen.dart';
import '../../../domain/Allsongs/model/allSongModel.dart';
import '../../../domain/Favourite/model/model.dart';
import '../../functions/fetchsongs.dart';



Future <List<Songs>> addFavourat(Songs songs)async{
  favouriteList.insert(0, songs);
//favarotList.value.insert(0, songs);
 Box <Favmodel>favDB=await Hive.openBox<Favmodel>('Favarout');
 Favmodel temp=Favmodel(id: songs.id);
 await favDB.add(temp);

 //favarotList.notifyListeners();
  //getFAvourite();

  List<Songs> addedList=[];
  addedList.addAll(favouriteList);
  getFAvourite();
  return addedList;
  
}


Future<List<Songs>> getFAvourite() async {
  //favarotList.value.clear();
  
  Box <Favmodel>favDb = await Hive.openBox<Favmodel>('Favarout');
  List<Favmodel> favSongCheck = [];
  favSongCheck.addAll(favDb.values);
  for (var favs in favSongCheck) {
    //int count = 0;
    for (var songs in allSongs) {
      if (favs.id == songs.id) {
        favouriteList.insert(0,songs);
        break;
      }
      //  else {
      //   count++;
      // }
    }
    // if (count == allSongs.length) {
    //   var key = favs.key;
    //   favDb.delete(key);
    // }
  }
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  //favarotList.notifyListeners();
  return favouriteList;
}
  
Future <List<Songs>> removeFavourite(Songs song) async {
  //favarotList.value.remove(song);
  favouriteList.remove(song);
  
  List<Favmodel> templist = [];
  Box<Favmodel> favdb = await Hive.openBox('Favarout');
  templist.addAll(favdb.values);
  for (var element in templist) {
    if (element.id == song.id) {
      var key = element.key;
     await favdb.delete(key);
      break;
    }
  }
  //favarotList.notifyListeners();
  //getFAvourite();

  List <Songs> addedList=[];
  addedList.addAll(favouriteList);
  return addedList;
}