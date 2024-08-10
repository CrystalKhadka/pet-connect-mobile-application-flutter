import 'package:final_assignment/core/common/widgets/my_snackbar.dart';
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
  User? currentUser;
  User? chatPartner;
  bool isTyping = false;
  TextEditingController messageController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    Future.microtask(() async {
      await ref
          .read(
            chatViewModelProvider.notifier,
          )
          .init(
            widget.receiverId!,
          );
    });
    super.initState();
  }

  @override
  void dispose() {
    // dispose while changing bottom navigation
    showMySnackBar(message: 'Chat Disposed');
    ref.read(chatViewModelProvider.notifier).offSocket();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatViewModelProvider);
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification &&
            _scrollController.position.extentAfter == 0) {
          ref.read(chatViewModelProvider.notifier).getMessages();
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Chat'),
          actions: [
            IconButton(
                onPressed: () {
                  print(chatState.messages);
                  ref
                      .read(
                        chatViewModelProvider.notifier,
                      )
                      .reset();
                },
                icon: const Icon(Icons.refresh)),
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
        body: Column(
          children: [
            ChatHeader(user: chatState.receiver!),
            chatState.isLoading
                ? const CircularProgressIndicator()
                : const SizedBox(),
            Expanded(
              child: ChatMessages(
                messages: chatState.messages,
                isTyping: chatState.isTyping,
                darkMode: darkMode,
                currentUser: chatState.user!,
                scrollController: _scrollController,
                onEditMessage: (message) {
                  // Implement edit message logic
                },
                onDeleteMessage: (messageId) {
                  // Implement delete message logic
                },
                downloadFile: (fileName) async {
                  ref
                      .read(
                        chatViewModelProvider.notifier,
                      )
                      .downloadFile(fileName);
                },
              ),
            ),
            chatState.isTyping
                ? const LinearProgressIndicator()
                : const SizedBox(),
            ChatInput(
              onSendMessage: (message) {
                ref
                    .read(
                      chatViewModelProvider.notifier,
                    )
                    .sendMessage(message);
              },
              onTyping: () {
                ref.read(chatViewModelProvider.notifier).handleTyping();
              },
              onFileUpload: (file) {
                // Implement file upload logic
              },
              darkMode: darkMode,
            ),
          ],
        ),
      ),
    );
  }
}
