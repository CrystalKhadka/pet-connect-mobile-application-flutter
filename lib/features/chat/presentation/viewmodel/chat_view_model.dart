import 'package:final_assignment/core/common/my_snackbar.dart';
import 'package:final_assignment/features/auth/domain/usecases/auth_use_case.dart';
import 'package:final_assignment/features/chat/domain/entity/message_enttiy.dart';
import 'package:final_assignment/features/chat/domain/usecases/chat_use_case.dart';
import 'package:final_assignment/features/chat/presentation/state/chat_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatViewModelProvider = StateNotifierProvider<ChatViewModel, ChatState>(
  (ref) => ChatViewModel(
    authUseCase: ref.watch(authUseCaseProvider),
    chatUseCase: ref.watch(chatUseCaseProvider),
  ),
);

class ChatViewModel extends StateNotifier<ChatState> {
  ChatViewModel({required this.authUseCase, required this.chatUseCase})
      : super(ChatState.initial());

  final AuthUseCase authUseCase;
  final ChatUseCase chatUseCase;

  Future<void> init(String receiverId) async {
    await setReceiverUser(receiverId);
    await setCurrentUser();
    // await getMessages();
  }

  setReceiverUser(String receiverId) async {
    state = state.copyWith(isLoading: true);
    final data = await authUseCase.getUser(receiverId);
    data.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );
        showMySnackBar(message: failure.error);
      },
      (receiverId) {
        print(receiverId);
        state = state.copyWith(
          isLoading: false,
          receiver: receiverId,
        );
      },
    );
  }

  setCurrentUser() async {
    final data = await authUseCase.getCurrentUser();
    data.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );
        showMySnackBar(message: failure.error);
      },
      (currentUser) {
        state = state.copyWith(
          isLoading: false,
          user: currentUser,
        );
      },
    );
  }

  sendMessage(String message) async {
    state = state.copyWith(isLoading: true);
    final messageEntity = MessageEntity(
      message: message,
      receiver: state.receiver!,
      type: state.type,
    );
    final data = await chatUseCase.sendMessage(messageEntity);
    data.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );
        showMySnackBar(message: failure.error);
      },
      (success) {
        print(success);
        state = state.copyWith(
          isLoading: false,
        );
      },
    );
  }
}
