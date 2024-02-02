import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String text, int snackBarType) {
  Color? color;
  switch (snackBarType) {
    case Type.success:
      color = Colors.green;
      break;
    case Type.failure:
      color = Colors.red;
      break;
    case Type.info:
      color = Colors.blue;
      break;
    default:
      color = Colors.blue;
      break;
  }
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      backgroundColor: color,
    ),
  );
}

class Type {
  static const int success = 200;
  static const int failure = 400;
  static const int info = 100;
}
