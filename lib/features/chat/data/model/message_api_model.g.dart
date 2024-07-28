// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageApiModel _$MessageApiModelFromJson(Map<String, dynamic> json) =>
    MessageApiModel(
      id: json['_id'] as String?,
      message: json['message'] as String?,
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
      sender: json['sender'] == null
          ? null
          : AuthApiModel.fromJson(json['sender'] as Map<String, dynamic>),
      receiver: json['receiver'] == null
          ? null
          : AuthApiModel.fromJson(json['receiver'] as Map<String, dynamic>),
      type: json['type'] as String?,
    );

Map<String, dynamic> _$MessageApiModelToJson(MessageApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'message': instance.message,
      'timestamp': instance.timestamp?.toIso8601String(),
      'sender': instance.sender,
      'receiver': instance.receiver,
      'type': instance.type,
    };
