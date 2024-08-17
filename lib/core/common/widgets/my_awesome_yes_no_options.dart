import 'package:flutter/material.dart';

import '../../../app/navigator_key/navigator_key.dart';

Future<String> myAwesomeYesNoOptions({
  required String title,
  required List<String> options,
}) async {
  String result = '';
  await showDialog(
    context: AppNavigator.navigatorKey.currentContext!,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: options.map((option) {
            return ListTile(
              title: Text(option),
              onTap: () {
                Navigator.pop(context, option);
              },
            );
          }).toList(),
        ),
      );
    },
  ).then((value) {
    result = value.toString();
  });

  return result;
}
