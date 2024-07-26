import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/auth/data/model/auth_api_model.dart';
import 'package:final_assignment/features/chat/domain/entity/message_enttiy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final messageApiModelProvider = Provider<MessageApiModel>(
  (ref) => MessageApiModel.empty(),
);

class MessageApiModel extends Equatable {
  final String? id;
  final String? message;
  final DateTime? timeStamp;
  final AuthApiModel? sender;
  final AuthApiModel? receiver;
  final String? type;

  const MessageApiModel(
      {required this.id,
      required this.message,
      required this.timeStamp,
      required this.sender,
      required this.receiver,
      required this.type});

  // Empty model
  factory MessageApiModel.empty() => MessageApiModel(
        id: '',
        message: '',
        timeStamp: DateTime.now(),
        sender: const AuthApiModel.empty(),
        receiver: const AuthApiModel.empty(),
        type: '',
      );

  // To Json
  Map<String, dynamic> toJson() => {
        '_id': id,
        'message': message,
        'timeStamp': timeStamp,
        'sender': sender?.id ?? '',
        'receiver': receiver?.id ?? '',
        'type': type,
      };

  // From Json
  factory MessageApiModel.fromJson(Map<String, dynamic> json) =>
      MessageApiModel(
        id: json['_id'],
        message: json['message'],
        timeStamp: DateTime.parse(json['timeStamp']),
        sender: AuthApiModel.fromJson(json['sender']),
        receiver: AuthApiModel.fromJson(json['receiver']),
        type: json['type'],
      );

  // from entity
  factory MessageApiModel.fromEntity(MessageEntity entity) => MessageApiModel(
        id: entity.id,
        message: entity.message,
        timeStamp: entity.timeStamp,
        sender: AuthApiModel.fromEntity(entity.sender),
        receiver: AuthApiModel.fromEntity(entity.receiver),
        type: entity.type,
      );

  // to entity
  MessageEntity toEntity() => MessageEntity(
        id: id,
        message: message,
        timeStamp: timeStamp,
        sender: sender?.toEntity(),
        receiver: receiver?.toEntity(),
        type: type,
      );

  // from entity list
  static List<MessageApiModel> fromEntityList(List<MessageEntity> entities) =>
      entities.map((e) => MessageApiModel.fromEntity(e)).toList();

  // to entity list
  static List<MessageEntity> toEntityList(List<MessageApiModel> models) =>
      models.map((e) => e.toEntity()).toList();

  @override
  List<Object?> get props => [
        id,
        message,
        timeStamp,
        sender,
        receiver,
        type,
      ];
}
