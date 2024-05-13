import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.controller,
    required this.text,
    this.keyboardType,
    this.prefixIcon,
  });

  final TextEditingController controller;
  final String text;
  final TextInputType? keyboardType;
  final Icon? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        prefixIcon: prefixIcon,
        hintText: text,
      ),
      keyboardType: keyboardType,
      // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your $text';
        }
        return null;
      },
    );
  }
}
