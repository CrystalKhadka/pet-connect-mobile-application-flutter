import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';

class NotificationEntity extends Equatable {
  final String? id;
  final AuthEntity? receiver;
  final String? message;
  final DateTime? timeStamp;
  final bool? isRead;

  const NotificationEntity(
      {this.id, this.receiver, this.message, this.timeStamp, this.isRead});

  @override
  List<Object?> get props => [id, receiver, message, timeStamp, isRead];
}
