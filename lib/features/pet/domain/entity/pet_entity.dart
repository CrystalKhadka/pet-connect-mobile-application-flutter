import 'package:equatable/equatable.dart';

class PetEntity extends Equatable {
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
  final String createdBy;

  const PetEntity(
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
        createdBy
      ];
}