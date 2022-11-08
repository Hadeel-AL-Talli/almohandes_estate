import 'package:flutter/material.dart';



mixin Helpers {
  void showSnackBar({
    required BuildContext context,
    required String message,
    int time=1,
    bool error = false,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: error ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: time),
      ),
    );
  }
}
