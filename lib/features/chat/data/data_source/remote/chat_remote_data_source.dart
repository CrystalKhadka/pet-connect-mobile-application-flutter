import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_assignment/app/constants/api_endpoints.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/networking/remote/http_service.dart';
import 'package:final_assignment/features/chat/data/model/message_api_model.dart';
import 'package:final_assignment/features/chat/domain/entity/message_enttiy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatRemoteDataSourceProvider = Provider<ChatRemoteDataSource>(
  (ref) => ChatRemoteDataSource(
    messageApiModel: ref.watch(messageApiModelProvider),
    dio: ref.watch(httpServiceProvider),
  ),
);

class ChatRemoteDataSource {
  final MessageApiModel messageApiModel;
  final Dio dio;

  ChatRemoteDataSource({
    required this.messageApiModel,
    required this.dio,
  });

  Future<Either<Failure, bool>> sendMessage(
      MessageEntity message, String token) async {
    try {
      final response = await dio.post(
        ApiEndpoints.sendMessage,
        data: MessageApiModel.fromEntity(message).toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.error.toString()));
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
