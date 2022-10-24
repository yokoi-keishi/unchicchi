// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toilet_level.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ToiletLevelAdapter extends TypeAdapter<ToiletLevel> {
  @override
  final int typeId = 3;

  @override
  ToiletLevel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ToiletLevel(
      fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ToiletLevel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToiletLevelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
