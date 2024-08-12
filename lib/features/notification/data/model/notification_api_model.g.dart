// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationApiModel _$NotificationApiModelFromJson(
        Map<String, dynamic> json) =>
    NotificationApiModel(
      id: json['_id'] as String?,
      receiver: json['receiver'] == null
          ? null
          : AuthApiModel.fromJson(json['receiver'] as Map<String, dynamic>),
      message: json['message'] as String?,
      timeStamp: json['timeStamp'] == null
          ? null
          : DateTime.parse(json['timeStamp'] as String),
      isRead: json['isRead'] as bool?,
    );

Map<String, dynamic> _$NotificationApiModelToJson(
        NotificationApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'receiver': instance.receiver,
      'message': instance.message,
      'timeStamp': instance.timeStamp?.toIso8601String(),
      'isRead': instance.isRead,
    };
