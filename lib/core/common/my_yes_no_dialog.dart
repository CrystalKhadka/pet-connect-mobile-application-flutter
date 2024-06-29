import 'package:final_assignment/app/navigator_key/navigator_key.dart';
import 'package:flutter/material.dart';

bool myYesNoDialog({required String title, Colors? color}) {
  bool result = false;
  showDialog(
    context: AppNavigator.navigatorKey.currentState!.context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        actions: [
          TextButton(
              onPressed: () {
                result = true;
                Navigator.pop(context);
              },
              child: const Text('Yes')),
          TextButton(
              onPressed: () {
                result = false;
                Navigator.pop(context);
              },
              child: const Text('No')),
        ],
      );
    },
  );
  return result;
}
