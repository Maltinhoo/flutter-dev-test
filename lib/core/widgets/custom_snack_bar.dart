import 'package:flutter/material.dart';

class CustomSnackBar {
  static void show(BuildContext context, {required Widget content}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
          decoration: BoxDecoration(
            color: const Color(0xff212229),
            borderRadius: BorderRadius.circular(10),
          ),
          child: content,
        ),
      ),
    );
  }
}
