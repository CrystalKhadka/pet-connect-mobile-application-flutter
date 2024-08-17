// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_adoptions_by_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAdoptionsByUserDto _$GetAdoptionsByUserDtoFromJson(
        Map<String, dynamic> json) =>
    GetAdoptionsByUserDto(
      success: json['success'] as bool,
      message: json['message'] as String,
      count: (json['count'] as num).toInt(),
      adoption: (json['adoption'] as List<dynamic>)
          .map((e) => AdoptionApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAdoptionsByUserDtoToJson(
        GetAdoptionsByUserDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'count': instance.count,
      'adoption': instance.adoption,
    };
