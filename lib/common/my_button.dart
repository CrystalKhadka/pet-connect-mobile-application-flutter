import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Widget child;
  final Color? bgColor;
  final Color? fgColor;

  const MyButton(
      {super.key,
      required this.onPressed,
      required this.child,
      this.fgColor,
      this.bgColor,});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: fgColor,
      ),
      
      child: child,
    );
  }
}
