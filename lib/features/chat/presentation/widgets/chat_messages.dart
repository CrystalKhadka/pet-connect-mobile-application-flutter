import 'package:final_assignment/app/constants/api_endpoints.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:flutter/material.dart';

import '../../domain/entity/message_enttiy.dart';

class ChatMessages extends StatelessWidget {
  final List<MessageEntity> messages;
  final bool isTyping;
  final bool darkMode;
  final AuthEntity currentUser;
  final Function(MessageEntity) onEditMessage;
  final Function(MessageEntity) onDeleteMessage;
  final ScrollController scrollController;
  final Function(String) downloadFile;

  const ChatMessages({
    super.key,
    required this.messages,
    required this.isTyping,
    required this.darkMode,
    required this.currentUser,
    required this.onEditMessage,
    required this.onDeleteMessage,
    required this.scrollController,
    required this.downloadFile,
  });

  @override
  Widget build(BuildContext context) {
    if (messages.isEmpty && !isTyping) {
      return const Center(
        child: Text('No messages yet'),
      );
    } else {
      return ListView.builder(
        reverse: true,
        controller: scrollController,
        itemCount: messages.length + (isTyping ? 1 : 0),
        itemBuilder: (context, index) {
          if (isTyping && index == 0) {
            return const TypingIndicator();
          }

          final message = isTyping ? messages[index - 1] : messages[index];
          final isOwnMessage = message.sender?.id == currentUser.id;

          return MessageBubble(
            message: message,
            isOwnMessage: isOwnMessage,
            darkMode: darkMode,
            onEdit: () => onEditMessage(message),
            onDelete: () => onDeleteMessage(message),
            downloadFile: () async {
              if (message.type == 'file') {
                await downloadFile(message.message!);
              }
            },
          );
        },
      );
    }
  }
}

class MessageBubble extends StatelessWidget {
  final MessageEntity message;
  final bool isOwnMessage;
  final bool darkMode;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback downloadFile;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isOwnMessage,
    required this.darkMode,
    required this.onEdit,
    required this.onDelete,
    required this.downloadFile,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isOwnMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isOwnMessage
              ? Colors.blue[500]
              : darkMode
                  ? Colors.grey[700]
                  : Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isOwnMessage ? 'You' : message.sender?.firstName ?? 'Unknown',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            if (message.type == 'image')
              GestureDetector(
                onDoubleTap: downloadFile,
                child: Image.network(
                  '${ApiEndpoints.messageImageUrl}${message.message}',
                ),
              )
            else if (message.type == 'file')
              TextButton(
                onPressed: downloadFile,
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red,
                ),
                child: Text(
                  message.message ?? 'File',
                  style: const TextStyle(
                    color: Colors.red,
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
            else
              Text(message.message ?? ''),
            const SizedBox(height: 4),
            Text(
              message.timeStamp.toString(),
              style: const TextStyle(fontSize: 10, color: Colors.grey),
            ),
            if (isOwnMessage)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, size: 16),
                    onPressed: onEdit,
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, size: 16),
                    onPressed: onDelete,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class TypingIndicator extends StatelessWidget {
  const TypingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: const Text(
        'Typing...',
        style: TextStyle(fontStyle: FontStyle.italic),
      ),
    );
  }
}
