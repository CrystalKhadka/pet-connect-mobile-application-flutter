import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.controller,
    required this.text,
    this.keyboardType,
    this.prefixIcon,
    this.obscureText,
    this.suffixIcon,
    this.inputFormatters,
    this.validator,
  });

  final TextEditingController controller;
  final String text;
  final TextInputType? keyboardType;
  final Icon? prefixIcon;
  final bool? obscureText;
  final IconButton? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;

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
      obscureText: obscureText ?? false,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
    );
  }
}
