import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/chat/domain/entity/message_enttiy.dart';
import 'package:final_assignment/features/chat/domain/repository/i_chat_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatUseCaseProvider = Provider<ChatUseCase>((ref) {
  return ChatUseCase(
    userSharedPrefs: ref.watch(userSharedPrefsProvider),
    chatRepository: ref.watch(chatRepositoryProvider),
  );
});

class ChatUseCase {
  final UserSharedPrefs userSharedPrefs;
  final IChatRepository chatRepository;

  ChatUseCase({
    required this.userSharedPrefs,
    required this.chatRepository,
  });

  Future<Either<Failure, bool>> sendMessage(MessageEntity message) async {
    String? token;
    final data = await userSharedPrefs.getUserToken();
    data.fold(
      (l) => token = null,
      (r) => token = r,
    );
    return chatRepository.sendMessage(message, token ?? '');
  }

  Future<Either<Failure, List<MessageEntity>>> getMessages(
      String receiverId, int page) async {
    String? token;
    final data = await userSharedPrefs.getUserToken();
    data.fold(
      (l) => token = null,
      (r) => token = r,
    );
    return chatRepository.getMessages(receiverId, token ?? '', page);
  }

  Future<Either<Failure, bool>> downloadFile(String fileName) {
    return chatRepository.downloadFile(fileName);
  }

  Future<Either<Failure, MessageEntity>> getMessage(
      Map<String, dynamic> data) async {
    return chatRepository.getMessage(data);
  }
}
