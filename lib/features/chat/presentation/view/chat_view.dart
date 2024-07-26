import 'package:final_assignment/features/chat/presentation/view/user.dart';
import 'package:final_assignment/features/chat/presentation/viewmodel/chat_view_model.dart';
import 'package:final_assignment/features/chat/presentation/widgets/chat_header.dart';
import 'package:final_assignment/features/chat/presentation/widgets/chat_input.dart';
import 'package:final_assignment/features/chat/presentation/widgets/chat_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatView extends ConsumerStatefulWidget {
  const ChatView({super.key, this.receiverId});

  final String? receiverId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatViewState();
}

class _ChatViewState extends ConsumerState<ChatView> {
  bool darkMode = false;
  List<Message> messages = [];
  User? currentUser;
  User? chatPartner;
  bool isTyping = false;
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await ref
          .read(
            chatViewModelProvider.notifier,
          )
          .init(
            widget.receiverId!,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          Switch(
            value: darkMode,
            onChanged: (value) {
              setState(() {
                darkMode = value;
              });
            },
          ),
        ],
      ),
      body: chatState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                ChatHeader(user: chatState.receiver!),
                Expanded(
                  child: ChatMessages(
                    messages: messages,
                    isTyping: isTyping,
                    darkMode: darkMode,
                    currentUser: chatState.user!,
                    onEditMessage: (message) {
                      // Implement edit message logic
                    },
                    onDeleteMessage: (messageId) {
                      // Implement delete message logic
                    },
                  ),
                ),
                ChatInput(
                  onSendMessage: (message) {
                    ref
                        .read(
                          chatViewModelProvider.notifier,
                        )
                        .sendMessage(message);
                  },
                  onTyping: () {
                    // Implement typing indicator logic
                  },
                  onFileUpload: (file) {
                    // Implement file upload logic
                  },
                  darkMode: darkMode,
                ),
              ],
            ),
    );
  }
}
