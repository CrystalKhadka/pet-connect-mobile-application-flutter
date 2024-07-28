import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:final_assignment/app/constants/api_endpoints.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/networking/remote/http_service.dart';
import 'package:final_assignment/features/chat/data/dto/get_all_messages_dto.dart';
import 'package:final_assignment/features/chat/data/model/message_api_model.dart';
import 'package:final_assignment/features/chat/domain/entity/message_enttiy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

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

  Future<Either<Failure, List<MessageEntity>>> getMessages(
      String receiverId, String token, int page) async {
    try {
      final response = await dio.get(
        '${ApiEndpoints.getMessages}$receiverId',
        queryParameters: {
          'page': page,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        final getAllMessageDto = GetAllMessagesDto.fromJson(response.data);
        // print(getAllMessageDto.messages);
        if (getAllMessageDto.messages == null) {
          return const Right([]);
        }
        final messages =
            messageApiModel.toEntityList(getAllMessageDto.messages!);
        return Right(messages);
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

//   download file from server
  Future<Either<Failure, bool>> downloadFile(String fileName) async {
    try {
      // Request storage permission
      var status = await Permission.storage.request();
      if (!status.isGranted) {
        throw Exception('Storage permission not granted');
      }

      // Use file picker to get file path
      String? result = await FilePicker.platform.getDirectoryPath();
      if (result == null) {
        throw Exception('No file selected');
      }
      // get directory path from result
      String directory = result;

      String fullPath = '$directory/$fileName';

      Response response = await dio.download(
          '${ApiEndpoints.messageFileUrl}$fileName', fullPath);

      if (response.statusCode == 200) {
        print('File downloaded successfully to $fullPath');
        return const Right(true);
      } else {
        print('File download failed with status: ${response.statusCode}');
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
      print(e);
      return Left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, MessageEntity>> getMessage(
      Map<String, dynamic> data) async {
    try {
      final model = MessageApiModel.fromJson(data);
      final message = model.toEntity();
      return Right(message);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
