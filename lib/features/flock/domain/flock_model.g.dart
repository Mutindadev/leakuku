// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flock_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FlockModelAdapter extends TypeAdapter<FlockModel> {
  @override
  final int typeId = 1;

  @override
  FlockModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FlockModel(
      id: fields[0] as String,
      farmerId: fields[1] as String,
      location: fields[2] as String,
      chickenType: fields[3] as String,
      startDate: fields[4] as DateTime,
      batchSize: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, FlockModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.farmerId)
      ..writeByte(2)
      ..write(obj.location)
      ..writeByte(3)
      ..write(obj.chickenType)
      ..writeByte(4)
      ..write(obj.startDate)
      ..writeByte(5)
      ..write(obj.batchSize);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FlockModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
