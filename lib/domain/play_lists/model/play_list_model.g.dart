// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'play_list_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class playListClassAdapter extends TypeAdapter<playListClass> {
  @override
  final int typeId = 2;

  @override
  playListClass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return playListClass(
      playListName: fields[0] as String,
    )..items = (fields[1] as List).cast<int>();
  }

  @override
  void write(BinaryWriter writer, playListClass obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.playListName)
      ..writeByte(1)
      ..write(obj.items);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is playListClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
