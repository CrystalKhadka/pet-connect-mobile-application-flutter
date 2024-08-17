import 'package:final_assignment/app/constants/hive_table_constant.dart';
import 'package:final_assignment/features/auth/data/model/auth_hive_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/entity/pet_entity.dart';

part 'pet_hive_model.g.dart';

final petHiveModelProvider = Provider((ref) => PetHiveModel.empty());

@HiveType(typeId: HiveTableConstant.petBoxId)
class PetHiveModel {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String petName;
  @HiveField(2)
  final String petSpecies;
  @HiveField(3)
  final String petBreed;
  @HiveField(4)
  final int petAge;
  @HiveField(5)
  final double petWeight;
  @HiveField(6)
  final String petColor;
  @HiveField(7)
  final String petDescription;
  @HiveField(8)
  final String? petImage;
  @HiveField(9)
  final String petStatus;
  @HiveField(10)
  final String createdAt;
  @HiveField(11)
  final AuthHiveModel? createdBy;

  PetHiveModel(
      {required this.id,
      required this.petName,
      required this.petSpecies,
      required this.petBreed,
      required this.petAge,
      required this.petWeight,
      required this.petColor,
      required this.petDescription,
      required this.petImage,
      required this.petStatus,
      required this.createdAt,
      required this.createdBy});

//   emtpy model
  PetHiveModel.empty()
      : this(
            id: '',
            petName: '',
            petSpecies: '',
            petBreed: '',
            petAge: 0,
            petWeight: 0.0,
            petColor: '',
            petDescription: '',
            petImage: '',
            petStatus: '',
            createdAt: '',
            createdBy: AuthHiveModel.empty());

//   from hive to entity
  PetEntity toEntity() {
    return PetEntity(
      id: id,
      petName: petName,
      petSpecies: petSpecies,
      petBreed: petBreed,
      petAge: petAge,
      petWeight: petWeight,
      petColor: petColor,
      petDescription: petDescription,
      petImage: petImage,
      petStatus: petStatus,
      createdAt: createdAt,
      createdBy: createdBy!.toEntity(),
    );
  }

//   from entity to hive
  factory PetHiveModel.fromEntity(PetEntity data) {
    return PetHiveModel(
      id: data.id,
      petName: data.petName,
      petSpecies: data.petSpecies,
      petBreed: data.petBreed,
      petAge: data.petAge,
      petWeight: data.petWeight,
      petColor: data.petColor,
      petDescription: data.petDescription,
      petImage: data.petImage,
      petStatus: data.petStatus,
      createdAt: data.createdAt,
      createdBy: AuthHiveModel.fromEntity(data.createdBy!),
    );
  }

  //   to entities
  List<PetEntity> toEntities(List<PetHiveModel> data) {
    return data.map((model) => model.toEntity()).toList();
  }

  //   from entities
  static List<PetHiveModel> fromEntities(List<PetEntity> data) {
    return data.map((entity) => PetHiveModel.fromEntity(entity)).toList();
  }
}
