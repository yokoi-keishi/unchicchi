// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toilet.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ToiletAdapter extends TypeAdapter<Toilet> {
  @override
  final int typeId = 1;

  @override
  Toilet read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Toilet(
      fields[0] as ToiletId,
      fields[1] as ToiletLevel,
      fields[2] as ToiletDate,
    );
  }

  @override
  void write(BinaryWriter writer, Toilet obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.toiletId)
      ..writeByte(1)
      ..write(obj.toiletLevel)
      ..writeByte(2)
      ..write(obj.toiletDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToiletAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
