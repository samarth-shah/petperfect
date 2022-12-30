// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StoreDataAdapter extends TypeAdapter<StoreData> {
  @override
  final int typeId = 0;

  @override
  StoreData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StoreData()..imageUrl = fields[0] as String;
  }

  @override
  void write(BinaryWriter writer, StoreData obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoreDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
