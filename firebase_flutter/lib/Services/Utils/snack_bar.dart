import 'package:flutter/material.dart';

void openSnackbar(context, snackMsg, color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      action: SnackBarAction(
        label: "Ok",
        textColor: Colors.white,
        onPressed: () {},
      ),
      content: Text(
        snackMsg,
        style: const TextStyle(fontSize: 15),
      ),
    ),
  );
}
