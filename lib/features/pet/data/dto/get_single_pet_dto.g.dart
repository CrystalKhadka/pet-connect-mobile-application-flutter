// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_single_pet_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSinglePetDto _$GetSinglePetDtoFromJson(Map<String, dynamic> json) =>
    GetSinglePetDto(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: PetApiModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetSinglePetDtoToJson(GetSinglePetDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
