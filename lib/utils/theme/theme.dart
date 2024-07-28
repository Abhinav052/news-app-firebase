import 'package:flutter/material.dart';
import 'package:newzbuzz/utils/theme/app_input_decoration_theme.dart';
import 'package:newzbuzz/utils/theme/app_text_theme.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      inputDecorationTheme: AppInputDecorationTheme.inputDecorationTheme,
      textTheme: AppTextTheme.textTheme,
      colorScheme: ColorScheme.fromSwatch(backgroundColor: Color(0xfff5f9fd)),
    );
  }
}
