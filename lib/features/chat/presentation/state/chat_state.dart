import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/chat/domain/entity/message_enttiy.dart';

class ChatState {
  final List<MessageEntity> messages;
  final bool isLoading;
  final bool isTyping;
  final AuthEntity? user;
  final AuthEntity? receiver;
  final String type;

  final String error;

  ChatState(
      {required this.messages,
      required this.isLoading,
      required this.isTyping,
      required this.user,
      required this.receiver,
      required this.type,
      required this.error});

  factory ChatState.initial() {
    return ChatState(
      messages: [],
      isLoading: false,
      isTyping: false,
      user: null,
      receiver: null,
      type: 'text',
      error: '',
    );
  }

  ChatState copyWith({
    List<MessageEntity>? messages,
    bool? isLoading,
    bool? isTyping,
    AuthEntity? user,
    AuthEntity? receiver,
    String? type,
    String? error,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      isTyping: isTyping ?? this.isTyping,
      user: user ?? this.user,
      receiver: receiver ?? this.receiver,
      type: type ?? this.type,
      error: error ?? this.error,
    );
  }
}
