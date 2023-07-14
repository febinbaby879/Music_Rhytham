
import 'package:hive_flutter/hive_flutter.dart';
part 'model.g.dart';
@HiveType(typeId: 1)
class Favmodel extends HiveObject{
  @HiveField(0)
  int? id;
  Favmodel({required this.id});
}