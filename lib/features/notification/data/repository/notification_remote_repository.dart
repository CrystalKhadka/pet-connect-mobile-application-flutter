import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/notification/data/data_source/remote/notification_remote_data_source.dart';
import 'package:final_assignment/features/notification/domain/entity/notification_entity.dart';
import 'package:final_assignment/features/notification/domain/repository/i_notification_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final notificationRemoteRepositoryProvider =
    Provider<INotificationRepository>((ref) {
  final notificationRemoteDataSource =
      ref.watch(notificationRemoteDataSourceProvider);
  return NotificationRemoteRepository(
      notificationRemoteDataSource: notificationRemoteDataSource);
});

class NotificationRemoteRepository implements INotificationRepository {
  final NotificationRemoteDataSource notificationRemoteDataSource;

  NotificationRemoteRepository({required this.notificationRemoteDataSource});

  @override
  Future<Either<Failure, List<NotificationEntity>>> getNotifications(
      String token) {
    return notificationRemoteDataSource.getNotifications(token);
  }

  @override
  Future<Either<Failure, int>> getNotificationsCount(String token) {
    // TODO: implement getNotificationsCount
    return notificationRemoteDataSource.getNotificationsCount(token);
  }
}
