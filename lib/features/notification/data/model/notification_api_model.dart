import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/auth/data/model/auth_api_model.dart';
import 'package:final_assignment/features/notification/domain/entity/notification_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_api_model.g.dart';

final notificationApiModelProvider = Provider<NotificationApiModel>((ref) {
  return const NotificationApiModel();
});

@JsonSerializable()
class NotificationApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final AuthApiModel? receiver;
  final String? message;
  final DateTime? timeStamp;
  final bool? isRead;

  const NotificationApiModel({
    this.id,
    this.receiver,
    this.message,
    this.timeStamp,
    this.isRead,
  });

  NotificationApiModel.empty()
      : id = '',
        receiver = const AuthApiModel.empty(),
        message = '',
        timeStamp = DateTime.now(),
        isRead = false;

  factory NotificationApiModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationApiModelToJson(this);

  NotificationEntity toEntity() {
    return NotificationEntity(
      id: id,
      receiver: receiver?.toEntity(),
      message: message,
      timeStamp: timeStamp,
      isRead: isRead,
    );
  }

  factory NotificationApiModel.fromEntity(NotificationEntity entity) {
    return NotificationApiModel(
      id: entity.id,
      receiver: AuthApiModel.fromEntity(entity.receiver!),
      message: entity.message,
      timeStamp: entity.timeStamp,
      isRead: entity.isRead,
    );
  }

  // to list of entites
  static List<NotificationEntity> toEntities(
      List<NotificationApiModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }

  // from list of entities
  static List<NotificationApiModel> fromEntities(
      List<NotificationEntity> entities) {
    return entities
        .map((entity) => NotificationApiModel.fromEntity(entity))
        .toList();
  }

  @override
  List<Object?> get props => [
        id,
        receiver,
        message,
        timeStamp,
        isRead,
      ];
}
