import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../data/repository/notification_remote_repository.dart';
import '../entity/notification_entity.dart';

final notificationRepositoryProvider = Provider<INotificationRepository>((ref) {
  return ref.read(notificationRemoteRepositoryProvider);
});

abstract class INotificationRepository {
  Future<Either<Failure, List<NotificationEntity>>> getNotifications(
      String token);

  Future<Either<Failure, int>> getNotificationsCount(String token);
}
