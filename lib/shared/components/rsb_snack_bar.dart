import 'package:flutter/material.dart';

class RSBSnackBar {
  void show({
    required context,
    required String message,
    Color? color = Colors.green,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(message),
      ),
    );
  }
}
