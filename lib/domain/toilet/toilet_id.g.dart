// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toilet_id.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ToiletIdAdapter extends TypeAdapter<ToiletId> {
  @override
  final int typeId = 2;

  @override
  ToiletId read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ToiletId(
      fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ToiletId obj) {
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
      other is ToiletIdAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
