import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:final_assignment/app/navigator_key/navigator_key.dart';
import 'package:flutter/material.dart';

Future<bool> myAwesomeYesNoDialog({
  String? title,
  String? context,
}) async {
  bool result = false;
  await AwesomeDialog(
    context: AppNavigator.navigatorKey.currentState!.context,
    dialogType: DialogType.info,
    borderSide: const BorderSide(
      color: Colors.green,
      width: 2,
    ),
    width: 280,
    buttonsBorderRadius: const BorderRadius.all(
      Radius.circular(2),
    ),
    dismissOnTouchOutside: true,
    dismissOnBackKeyPress: false,
    onDismissCallback: (type) {
      ScaffoldMessenger.of(AppNavigator.navigatorKey.currentState!.context)
          .showSnackBar(
        SnackBar(
          content: Text('Dismissed by $type'),
        ),
      );
    },
    headerAnimationLoop: false,
    animType: AnimType.bottomSlide,
    title: title ?? 'This is Title',
    desc: context ?? 'This is Description',
    showCloseIcon: true,
    btnCancelOnPress: () {
      result = false;
    },
    btnOkOnPress: () {
      result = true;
    },
  ).show();
  return result;
}
