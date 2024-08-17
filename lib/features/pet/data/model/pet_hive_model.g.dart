// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PetHiveModelAdapter extends TypeAdapter<PetHiveModel> {
  @override
  final int typeId = 1;

  @override
  PetHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PetHiveModel(
      id: fields[0] as String?,
      petName: fields[1] as String,
      petSpecies: fields[2] as String,
      petBreed: fields[3] as String,
      petAge: fields[4] as int,
      petWeight: fields[5] as double,
      petColor: fields[6] as String,
      petDescription: fields[7] as String,
      petImage: fields[8] as String?,
      petStatus: fields[9] as String,
      createdAt: fields[10] as String,
      createdBy: fields[11] as AuthHiveModel?,
    );
  }

  @override
  void write(BinaryWriter writer, PetHiveModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.petName)
      ..writeByte(2)
      ..write(obj.petSpecies)
      ..writeByte(3)
      ..write(obj.petBreed)
      ..writeByte(4)
      ..write(obj.petAge)
      ..writeByte(5)
      ..write(obj.petWeight)
      ..writeByte(6)
      ..write(obj.petColor)
      ..writeByte(7)
      ..write(obj.petDescription)
      ..writeByte(8)
      ..write(obj.petImage)
      ..writeByte(9)
      ..write(obj.petStatus)
      ..writeByte(10)
      ..write(obj.createdAt)
      ..writeByte(11)
      ..write(obj.createdBy);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PetHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
