import 'package:flutter/material.dart';

class AppInputDecorationTheme {
  static InputDecorationTheme get inputDecorationTheme {
    final InputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide.none,
    );
    return InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      hintStyle: TextStyle(color: Colors.grey), // Use existing color
      contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
      border: border,
      enabledBorder: border,
      focusedBorder: border,
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Colors.red, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Colors.red, width: 1),
      ),
      labelStyle: TextStyle(color: Colors.black),
      errorStyle: TextStyle(color: Colors.red, fontSize: 14),
    );
  }
}
