// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PetApiModel _$PetApiModelFromJson(Map<String, dynamic> json) => PetApiModel(
      id: json['_id'] as String?,
      petName: json['petName'] as String,
      petSpecies: json['petSpecies'] as String,
      petBreed: json['petBreed'] as String,
      petAge: (json['petAge'] as num).toInt(),
      petWeight: (json['petWeight'] as num).toDouble(),
      petColor: json['petColor'] as String,
      petDescription: json['petDescription'] as String,
      petImage: json['petImage'] as String,
      petStatus: json['petStatus'] as String,
      createdAt: json['createdAt'] as String,
      createdBy: json['createdBy'] as String,
    );

Map<String, dynamic> _$PetApiModelToJson(PetApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'petName': instance.petName,
      'petSpecies': instance.petSpecies,
      'petBreed': instance.petBreed,
      'petAge': instance.petAge,
      'petWeight': instance.petWeight,
      'petColor': instance.petColor,
      'petDescription': instance.petDescription,
      'petImage': instance.petImage,
      'petStatus': instance.petStatus,
      'createdAt': instance.createdAt,
      'createdBy': instance.createdBy,
    };
