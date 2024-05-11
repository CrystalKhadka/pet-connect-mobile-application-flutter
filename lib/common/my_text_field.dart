import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        labelText: text,
        prefixIcon: prefixIcon,
      ),
      keyboardType: keyboardType,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    );
  }
}
