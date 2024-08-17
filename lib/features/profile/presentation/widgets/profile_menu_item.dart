import 'package:flutter/material.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final Color? textColor;

  const ProfileMenuItem(
      {super.key,
      required this.icon,
      required this.text,
      required this.onTap,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: onTap,
    );
  }
}