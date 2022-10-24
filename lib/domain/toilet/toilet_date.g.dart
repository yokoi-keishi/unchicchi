// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toilet_date.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ToiletDateAdapter extends TypeAdapter<ToiletDate> {
  @override
  final int typeId = 4;

  @override
  ToiletDate read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ToiletDate(
      fields[0] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ToiletDate obj) {
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
      other is ToiletDateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
