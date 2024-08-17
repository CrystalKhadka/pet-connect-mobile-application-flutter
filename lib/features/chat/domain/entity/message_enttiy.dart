import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';

class MessageEntity extends Equatable {
  final String? id;
  final String? message;
  final DateTime? timeStamp;
  final AuthEntity? sender;
  final AuthEntity? receiver;
  final String? type;

  const MessageEntity(
      {this.id,
      required this.message,
      this.timeStamp,
      this.sender,
      required this.receiver,
      required this.type});

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
