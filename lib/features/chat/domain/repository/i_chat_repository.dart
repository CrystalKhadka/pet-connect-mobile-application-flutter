import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/chat/data/repository/chat_remote_repository.dart';
import 'package:final_assignment/features/chat/domain/entity/message_enttiy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatRepositoryProvider = Provider<IChatRepository>(
  (ref) => ref.watch(chatRemoteRepositoryProvider),
);

abstract class IChatRepository {
  Future<Either<Failure, bool>> sendMessage(
      MessageEntity message, String token);

  Future<Either<Failure, List<MessageEntity>>> getMessages(
    String receiverId,
    String token,
    int page,
  );

//   downloadFile(String url) async {
  Future<Either<Failure, bool>> downloadFile(String fileName);

  Future<Either<Failure, MessageEntity>> getMessage(Map<String, dynamic> data);
}
