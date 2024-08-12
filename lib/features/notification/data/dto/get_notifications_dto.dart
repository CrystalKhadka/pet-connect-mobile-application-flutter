import 'package:final_assignment/features/notification/data/model/notification_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_notifications_dto.g.dart';

@JsonSerializable()
class GetNotificationsDto {
  final String message;
  final int count;
  final bool success;
  final List<NotificationApiModel> notifications;

  GetNotificationsDto(
      {required this.message,
      required this.count,
      required this.success,
      required this.notifications});

  factory GetNotificationsDto.fromJson(Map<String, dynamic> json) =>
      _$GetNotificationsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetNotificationsDtoToJson(this);
}
