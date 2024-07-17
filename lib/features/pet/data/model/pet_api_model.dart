import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/auth/data/model/auth_api_model.dart';
import 'package:final_assignment/features/pet/domain/entity/pet_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pet_api_model.g.dart';

final petApiModelProvider = Provider<PetApiModel>((ref) {
  return const PetApiModel.empty();
});

@JsonSerializable()
class PetApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String petName;
  final String petSpecies;
  final String petBreed;
  final int petAge;
  final double petWeight;
  final String petColor;
  final String petDescription;
  final String petImage;
  final String petStatus;
  final String createdAt;
  final AuthApiModel? createdBy;

  // Constructing the PetApiModel class
  const PetApiModel({
    required this.id,
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
    this.createdBy,
  });

  // Empty constructor
  const PetApiModel.empty()
      : id = '',
        petName = '',
        petSpecies = '',
        petBreed = '',
        petAge = 0,
        petWeight = 0.0,
        petColor = '',
        petDescription = '',
        petImage = '',
        petStatus = '',
        createdBy = null,
        createdAt = '';

  // JSON deserialization
  factory PetApiModel.fromJson(Map<String, dynamic> json) =>
      _$PetApiModelFromJson(json);

  // JSON serialization
  Map<String, dynamic> toJson() => _$PetApiModelToJson(this);

  // To entity
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
        createdBy: createdBy?.toEntity());
  }

  // From entity
  factory PetApiModel.fromEntity(PetEntity entity) {
    return PetApiModel(
      id: entity.id,
      petName: entity.petName,
      petSpecies: entity.petSpecies,
      petBreed: entity.petBreed,
      petAge: entity.petAge,
      petWeight: entity.petWeight,
      petColor: entity.petColor,
      petDescription: entity.petDescription,
      petImage: entity.petImage,
      petStatus: entity.petStatus,
      createdAt: entity.createdAt,
    );
  }

  // To list of entity
  List<PetEntity> toEntities(List<PetApiModel> pets) {
    return pets.map((pet) => pet.toEntity()).toList();
  }

  // From list of entity
  List<PetApiModel> fromEntities(List<PetEntity> pets) {
    return pets.map((pet) => PetApiModel.fromEntity(pet)).toList();
  }

  @override
  List<Object?> get props => [
        id,
        petName,
        petSpecies,
        petBreed,
        petAge,
        petWeight,
        petColor,
        petDescription,
        petImage,
        petStatus,
        createdAt,
      ];
}
