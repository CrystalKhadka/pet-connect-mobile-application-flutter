import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.controller,
    required this.text,
    this.keyboardType,
    this.prefixIcon,
    required this.obscureText,
    this.suffixIcon,
  });

  final TextEditingController controller;
  final String text;
  final TextInputType? keyboardType;
  final Icon? prefixIcon;
  final bool obscureText;
  final IconButton? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: text,
      ),
      obscureText: obscureText,
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
