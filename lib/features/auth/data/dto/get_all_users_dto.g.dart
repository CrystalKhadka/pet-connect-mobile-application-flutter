// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_users_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllUsersDto _$GetAllUsersDtoFromJson(Map<String, dynamic> json) =>
    GetAllUsersDto(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => AuthApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllUsersDtoToJson(GetAllUsersDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
