import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/notification/domain/repository/i_notification_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../entity/notification_entity.dart';

final notificationUsecaseProvider = Provider<NotificationUsecase>((ref) {
  final notificationRepository = ref.read(notificationRepositoryProvider);
  final userSharedPrefs = ref.read(userSharedPrefsProvider);
  return NotificationUsecase(
      notificationRepository: notificationRepository,
      userSharedPrefs: userSharedPrefs);
});

class NotificationUsecase {
  final INotificationRepository notificationRepository;
  final UserSharedPrefs userSharedPrefs;

  NotificationUsecase(
      {required this.notificationRepository, required this.userSharedPrefs});

  Future<Either<Failure, List<NotificationEntity>>> getNotifications() async {
    String? token;
    final data = await userSharedPrefs.getUserToken();
    data.fold((l) => null, (r) => token = r);

    if (token != null) {
      return notificationRepository.getNotifications(token!);
    } else {
      return Left(Failure(error: 'Token not found'));
    }
  }

  Future<Either<Failure, int>> getNotificationsCount() async {
    String? token;
    final data = await userSharedPrefs.getUserToken();
    data.fold((l) => null, (r) => token = r);

    if (token != null) {
      return notificationRepository.getNotificationsCount(token!);
    } else {
      return Left(Failure(error: 'Token not found'));
    }
  }
}
