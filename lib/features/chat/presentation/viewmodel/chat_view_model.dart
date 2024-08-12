import 'package:final_assignment/core/common/widgets/my_snackbar.dart';
import 'package:final_assignment/features/auth/domain/usecases/auth_use_case.dart';
import 'package:final_assignment/features/chat/domain/entity/message_enttiy.dart';
import 'package:final_assignment/features/chat/domain/usecases/chat_use_case.dart';
import 'package:final_assignment/features/chat/presentation/state/chat_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/networking/socket/socket_service.dart';
import '../../data/model/message_api_model.dart';

final chatViewModelProvider = StateNotifierProvider<ChatViewModel, ChatState>(
  (ref) => ChatViewModel(
    authUseCase: ref.watch(authUseCaseProvider),
    chatUseCase: ref.watch(chatUseCaseProvider),
  ),
);

class ChatViewModel extends StateNotifier<ChatState> {
  ChatViewModel({
    required this.authUseCase,
    required this.chatUseCase,
  }) : super(ChatState.initial());

  final AuthUseCase authUseCase;
  final ChatUseCase chatUseCase;
  final socket = SocketService.socket;

  Future<void> init(String receiverId) async {
    if (state.receiver?.id != receiverId) {
      offSocket();
      await setReceiverUser(receiverId);
      await setCurrentUser();
      getMessages();
      await initSocket();
    }
  }

  Future<void> initSocket() async {
    socket.on("message", handleNewMessage);
    socket.on("typingNow", handleTypingIndicator);
  }

  void offSocket() {
    socket.off("message");
    socket.off("typingNow");
  }

  void handleNewMessage(data) {
    final model = MessageApiModel.fromJson(data);
    final message = model.toEntity();
    state = state.copyWith(
      messages: [message, ...state.messages],
    );
    showMySnackBar(
        message: "${message.sender?.firstName ?? ""} sent a message");
  }

  void handleTyping() {
    socket.emit(
      "typing",
      {'receiver': state.receiver?.id, 'sender': state.user?.id},
    );
  }

  void handleTypingIndicator(data) {
    state = state.copyWith(isTyping: true);
    //   set delay
    Future.delayed(Duration(seconds: 2), () {
      state = state.copyWith(isTyping: false);
    });
  }

  Future<void> setReceiverUser(String receiverId) async {
    state = state.copyWith(isLoading: true);
    final result = await authUseCase.getUser(receiverId);
    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );
        showMySnackBar(message: failure.error);
      },
      (receiver) {
        state = state.copyWith(
          isLoading: false,
          receiver: receiver,
        );
      },
    );
  }

  Future<void> setCurrentUser() async {
    final result = await authUseCase.getCurrentUser();
    result.fold(
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

  Future<void> sendMessage(String message) async {
    state = state.copyWith(isLoading: true);
    final messageEntity = MessageEntity(
      message: message,
      receiver: state.receiver!,
      type: state.type,
    );
    final result = await chatUseCase.sendMessage(messageEntity);
    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );
        showMySnackBar(message: failure.error);
      },
      (success) {
        state = state.copyWith(isLoading: false);
      },
    );
  }

  Future<void> getMessages() async {
    if (state.hasReachedMax) {
      showMySnackBar(message: 'No more messages');
      return;
    }

    state = state.copyWith(isLoading: true);
    final page = state.page + 1;

    final result = await chatUseCase.getMessages(state.receiver!.id!, page);
    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );
        showMySnackBar(message: failure.error);
      },
      (messages) {
        if (messages.isEmpty) {
          state = state.copyWith(hasReachedMax: true);
          showMySnackBar(message: 'No more messages');
        } else {
          state = state.copyWith(
            messages: [...state.messages, ...messages],
            page: page,
            isLoading: false,
          );
        }
      },
    );
  }

  Future<void> downloadFile(String fileName) async {
    final result = await chatUseCase.downloadFile(fileName);
    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );
        showMySnackBar(message: failure.error);
      },
      (success) {
        state = state.copyWith(isLoading: false);
        showMySnackBar(message: 'File downloaded successfully');
      },
    );
  }

  void reset() {
    state = state.copyWith(
      messages: [],
      page: 0,
      hasReachedMax: false,
    );
    getMessages();
  }

  @override
  void dispose() {
    offSocket();
    super.dispose();
  }
}
