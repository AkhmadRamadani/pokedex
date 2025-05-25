// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteHiveModelAdapter extends TypeAdapter<FavoriteHiveModel> {
  @override
  final typeId = 1;

  @override
  FavoriteHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteHiveModel(
      entityId: fields[0] as String,
      addedAt: fields[1] as DateTime,
      order: (fields[2] as num?)?.toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteHiveModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.entityId)
      ..writeByte(1)
      ..write(obj.addedAt)
      ..writeByte(2)
      ..write(obj.order);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
