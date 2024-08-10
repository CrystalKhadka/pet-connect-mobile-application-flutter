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
    if (state.receiver?.id == receiverId) {
      offSocket();
    }
    await initSocket();
    await setReceiverUser(receiverId);
    await setCurrentUser();
    await getMessages();
  }

  initSocket() async {
    socket.on("message", handleNewMessage);
    socket.on("typingNow", handleTypingIndicator);
  }

  // off socket method
  offSocket() {
    socket.off("message");
    socket.off("typingNow");
  }

  handleNewMessage(data) {
    state = state.copyWith(isLoading: true);
    final model = MessageApiModel.fromJson(data);
    final message = model.toEntity();
    showMySnackBar(message: message.sender?.firstName ?? "");
    state = state
        .copyWith(messages: [message, ...state.messages], isLoading: false);
  }

  handleTyping() {
    state = state.copyWith(isLoading: true);

    socket.emit(
        "typing", {'receiver': state.receiver?.id!, 'sender': state.user?.id});
    state = state.copyWith(isLoading: false);
  }

  handleTypingIndicator(data) {
    state = state.copyWith(isLoading: true, isTyping: true);
    showMySnackBar(message: 'Typing');
    state = state.copyWith(isLoading: false, isTyping: false);
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

  getMessages() async {
    state = state.copyWith(isLoading: true);
    final currentStatus = state;
    final page = currentStatus.page + 1;
    final messages = currentStatus.messages;
    final hasReachedMax = currentStatus.hasReachedMax;

    if (hasReachedMax) {
      state = state.copyWith(isLoading: false);
      showMySnackBar(message: 'No more messages');
      return;
    } else {
      final data = await chatUseCase.getMessages(state.receiver!.id!, page);
      data.fold(
        (failure) {
          state = state.copyWith(
            isLoading: false,
            error: failure.error,
          );
          showMySnackBar(message: failure.error);
        },
        (data) {
          print(data);
          if (data.isEmpty) {
            state = state.copyWith(hasReachedMax: true);
            showMySnackBar(message: 'No more messages');
          } else {
            state = state.copyWith(
              messages: [...messages, ...data],
              page: page,
              isLoading: false,
            );
          }
        },
      );
    }
  }

  downloadFile(String fileName) async {
    final data = await chatUseCase.downloadFile(fileName);
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

  reset() {
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
