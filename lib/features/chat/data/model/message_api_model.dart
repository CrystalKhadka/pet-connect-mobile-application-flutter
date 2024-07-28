import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/auth/data/model/auth_api_model.dart';
import 'package:final_assignment/features/chat/domain/entity/message_enttiy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message_api_model.g.dart';

final messageApiModelProvider = Provider<MessageApiModel>(
  (ref) => MessageApiModel.empty(),
);

@JsonSerializable()
class MessageApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String? message;
  final DateTime? timestamp;
  final AuthApiModel? sender;
  final AuthApiModel? receiver;
  final String? type;

  const MessageApiModel(
      {required this.id,
      required this.message,
      required this.timestamp,
      required this.sender,
      required this.receiver,
      required this.type});

  // Empty model
  factory MessageApiModel.empty() => MessageApiModel(
        id: '',
        message: '',
        timestamp: DateTime.now(),
        sender: const AuthApiModel.empty(),
        receiver: const AuthApiModel.empty(),
        type: '',
      );

  // To Json
  Map<String, dynamic> toJson() => _$MessageApiModelToJson(this);

  // From Json
  factory MessageApiModel.fromJson(Map<String, dynamic> json) =>
      _$MessageApiModelFromJson(json);

  // from entity
  factory MessageApiModel.fromEntity(MessageEntity entity) => MessageApiModel(
        id: entity.id,
        message: entity.message,
        timestamp: entity.timeStamp,
        sender: AuthApiModel.fromEntity(entity.sender),
        receiver: AuthApiModel.fromEntity(entity.receiver),
        type: entity.type,
      );

  // to entity
  MessageEntity toEntity() => MessageEntity(
        id: id,
        message: message,
        timeStamp: timestamp,
        sender: sender?.toEntity(),
        receiver: receiver?.toEntity(),
        type: type,
      );

  // from entity list
  List<MessageApiModel> fromEntityList(List<MessageEntity> entities) =>
      entities.map((e) => MessageApiModel.fromEntity(e)).toList();

  // to entity list
  List<MessageEntity> toEntityList(List<MessageApiModel> models) =>
      models.map((e) => e.toEntity()).toList();

  @override
  List<Object?> get props => [
        id,
        message,
        timestamp,
        sender,
        receiver,
        type,
      ];
}
