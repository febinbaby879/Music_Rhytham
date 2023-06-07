import 'package:flutter/material.dart';

SnackBaaaar({
  required String text,
  required BuildContext context,
  required MaterialColor backgroundColor,
}) {
  return ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        width: 200,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: backgroundColor,
        content: Center(
          child: Text(text),            
        ),
      ),
    );
}
