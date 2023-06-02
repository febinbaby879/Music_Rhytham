import 'package:hive/hive.dart';
part 'play_list_model.g.dart';
@HiveType(typeId: 2)
class playListClass extends HiveObject{
  @HiveField(0)
  String playListName;
  @HiveField(1)
  List<int> items=[];

  playListClass({required this.playListName});
}