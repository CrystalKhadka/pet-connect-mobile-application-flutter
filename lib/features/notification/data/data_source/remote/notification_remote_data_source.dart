import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_assignment/app/constants/api_endpoints.dart';
import 'package:final_assignment/core/networking/remote/http_service.dart';
import 'package:final_assignment/features/notification/data/dto/get_notifications_dto.dart';
import 'package:final_assignment/features/notification/data/model/notification_api_model.dart';
import 'package:final_assignment/features/notification/domain/entity/notification_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/failure/failure.dart';

final notificationRemoteDataSourceProvider =
    Provider<NotificationRemoteDataSource>((ref) {
  final dio = ref.watch(httpServiceProvider);
  final notificationApiModel = ref.watch(notificationApiModelProvider);
  return NotificationRemoteDataSource(
    dio: dio,
    notificationApiModel: notificationApiModel,
  );
});

class NotificationRemoteDataSource {
  final Dio dio;
  final NotificationApiModel notificationApiModel;

  NotificationRemoteDataSource({
    required this.dio,
    required this.notificationApiModel,
  });

  Future<Either<Failure, List<NotificationEntity>>> getNotifications(
      String token) async {
    try {
      final response = await dio.get(ApiEndpoints.getNotifications,
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));

      if (response.statusCode == 200) {
        final getNotificationsDto = GetNotificationsDto.fromJson(response.data);
        return Right(
          NotificationApiModel.toEntities(
            getNotificationsDto.notifications,
          ),
        );
      }
      return Left(Failure(
        error: response.data['message'],
        statusCode: response.statusCode.toString(),
      ));
    } on DioException catch (e) {
      return Left(Failure(
        error: e.error.toString(),
      ));
    }
  }

  Future<Either<Failure, int>> getNotificationsCount(String token) async {
    try {
      final response = await dio.get(ApiEndpoints.getNotifications,
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));

      if (response.statusCode == 200) {
        final getNotificationsDto = GetNotificationsDto.fromJson(response.data);
        return Right(
          getNotificationsDto.count,
        );
      }
      return Left(Failure(
        error: response.data['message'],
        statusCode: response.statusCode.toString(),
      ));
    } on DioException catch (e) {
      return Left(Failure(
        error: e.error.toString(),
      ));
    }
  }
}
