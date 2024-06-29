// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationDto _$PaginationDtoFromJson(Map<String, dynamic> json) =>
    PaginationDto(
      success: json['success'] as bool,
      message: json['message'] as String,
      pets: (json['pets'] as List<dynamic>)
          .map((e) => PetApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PaginationDtoToJson(PaginationDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'pets': instance.pets,
    };
