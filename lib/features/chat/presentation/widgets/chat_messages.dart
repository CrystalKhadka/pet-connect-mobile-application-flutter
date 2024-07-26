import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/chat/presentation/view/user.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  final List<Message> messages;
  final bool isTyping;
  final bool darkMode;
  final AuthEntity currentUser;
  final Function(Message) onEditMessage;
  final Function(String) onDeleteMessage;

  const ChatMessages({
    super.key,
    required this.messages,
    required this.isTyping,
    required this.darkMode,
    required this.currentUser,
    required this.onEditMessage,
    required this.onDeleteMessage,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      itemCount: messages.length + (isTyping ? 1 : 0),
      itemBuilder: (context, index) {
        if (isTyping && index == 0) {
          return const TypingIndicator();
        }
        final message = messages[isTyping ? index - 1 : index];
        return MessageBubble(
          message: message,
          isOwnMessage: message.sender.id == currentUser.id,
          darkMode: darkMode,
          onEdit: () => onEditMessage(message),
          onDelete: () => onDeleteMessage(message.id),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  final Message message;
  final bool isOwnMessage;
  final bool darkMode;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isOwnMessage,
    required this.darkMode,
    required this.onEdit,
    required this.onDelete,
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
              isOwnMessage ? 'You' : message.sender.firstName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(message.content),
            const SizedBox(height: 4),
            Text(
              message.timestamp.toString(),
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
      child: const Text('Typing...',
          style: TextStyle(fontStyle: FontStyle.italic)),
    );
  }
}
