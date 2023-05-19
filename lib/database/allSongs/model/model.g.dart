// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class allSongsAdapter extends TypeAdapter<allSongs> {
  @override
  final int typeId = 1;

  @override
  allSongs read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return allSongs(
      songName: fields[0] as String?,
      artist: fields[1] as String?,
      duration: fields[2] as int?,
      id: fields[3] as int?,
      songurl: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, allSongs obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.songName)
      ..writeByte(1)
      ..write(obj.artist)
      ..writeByte(2)
      ..write(obj.duration)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.songurl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is allSongsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
