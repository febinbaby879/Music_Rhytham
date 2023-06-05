import 'package:flutter/material.dart';

// class CustomSnackbar {
//   static void show({
//     required BuildContext context,
//     required String text,
//     Duration duration = const Duration(seconds: 2),
//     Color backgroundColor = Colors.black,
//     Color textColor = Colors.white,
//   }) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           text,
//           style: TextStyle(color: textColor),
//         ),
//         backgroundColor: backgroundColor,
//         duration: duration,
//       ),
//     );
//   }
// }

SnackBar createCustomSnackbar({
  required String text,
  required BuildContext context,
  Duration duration = const Duration(seconds: 2),
  Color backgroundColor = Colors.blue,
  Color textColor = Colors.amber,
}) {
  return SnackBar(
    content: Text(
      text,
      style: TextStyle(color: textColor),
    ),
    backgroundColor: backgroundColor,
    duration: duration,
  );
}

snackbarAdding({
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
        duration: const Duration(seconds: 1),
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
