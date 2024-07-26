import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/chat/data/data_source/remote/chat_remote_data_source.dart';
import 'package:final_assignment/features/chat/domain/entity/message_enttiy.dart';
import 'package:final_assignment/features/chat/domain/repository/i_chat_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatRemoteRepositoryProvider = Provider<IChatRepository>(
  (ref) => ChatRemoteRepository(
    ref.watch(chatRemoteDataSourceProvider),
  ),
);

class ChatRemoteRepository implements IChatRepository {
  final ChatRemoteDataSource chatRemoteDataSource;

  ChatRemoteRepository(this.chatRemoteDataSource);
  @override
  Future<Either<Failure, bool>> sendMessage(
      MessageEntity message, String token) {
    return chatRemoteDataSource.sendMessage(message, token);
  }
}
