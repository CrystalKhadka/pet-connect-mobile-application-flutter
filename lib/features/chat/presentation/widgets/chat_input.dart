import 'dart:io';

import 'package:flutter/material.dart';

class ChatInput extends StatefulWidget {
  final Function(String) onSendMessage;
  final VoidCallback onTyping;
  final Function(File) onFileUpload;
  final bool darkMode;

  const ChatInput({
    super.key,
    required this.onSendMessage,
    required this.onTyping,
    required this.onFileUpload,
    required this.darkMode,
  });

  @override
  _ChatInputState createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: widget.darkMode ? Colors.grey[800] : Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Type a message',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onChanged: (value) => widget.onTyping(),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.emoji_emotions),
            onPressed: () {
              // Implement emoji picker
            },
          ),
          IconButton(
            icon: const Icon(Icons.attach_file),
            onPressed: () async {
              // Implement file picker
              // FilePickerResult? result = await FilePicker.platform.pickFiles();
              // if (result != null) {
              //   File file = File(result.files.single.path!);
              //   widget.onFileUpload(file);
              // }
            },
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                widget.onSendMessage(_controller.text);
                _controller.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
