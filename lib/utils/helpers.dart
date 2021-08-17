import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

mixin Helpers {
  void showSnackBar(
      {required BuildContext context,
      required String content,
      bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          content,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: error ? Colors.red : Colors.green,
      ),
    );
  }
}
