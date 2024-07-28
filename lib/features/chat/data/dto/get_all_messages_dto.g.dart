// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_messages_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllMessagesDto _$GetAllMessagesDtoFromJson(Map<String, dynamic> json) =>
    GetAllMessagesDto(
      message: json['message'] as String?,
      success: json['success'] as bool?,
      messages: (json['messages'] as List<dynamic>?)
          ?.map((e) => MessageApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllMessagesDtoToJson(GetAllMessagesDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'success': instance.success,
      'messages': instance.messages,
    };
