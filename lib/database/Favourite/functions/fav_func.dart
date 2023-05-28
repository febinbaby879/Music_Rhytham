import 'package:hive_flutter/hive_flutter.dart';
import 'package:moon_walker/database/Favourite/model/model.dart';
import 'package:moon_walker/screens/favouriteScreen.dart';


Future<void> addFavourat(dynamic songs)async{
favarotList.value.insert(0, songs);
 final favDB=await Hive.openBox('Favarout');
 Favmodel temp=Favmodel(id: songs.id);
 favDB.add(temp);
 //print(favDB);
}