// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_notifications_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetNotificationsDto _$GetNotificationsDtoFromJson(Map<String, dynamic> json) =>
    GetNotificationsDto(
      message: json['message'] as String,
      count: (json['count'] as num).toInt(),
      success: json['success'] as bool,
      notifications: (json['notifications'] as List<dynamic>)
          .map((e) => NotificationApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetNotificationsDtoToJson(
        GetNotificationsDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'count': instance.count,
      'success': instance.success,
      'notifications': instance.notifications,
    };
