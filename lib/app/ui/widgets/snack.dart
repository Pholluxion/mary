import 'package:flutter/material.dart';

void showSimpleSnackBar({
  void Function()? onPressed,
  required BuildContext context,
  required String message,
}) {
  final snackBar = SnackBar(
    content: Text(message),
    action: SnackBarAction(
      label: "Ok",
      onPressed: onPressed ?? () {},
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
