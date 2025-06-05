import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      primaryColor: const Color(0xFF4CAF50),
      scaffoldBackgroundColor: Colors.white,
      useMaterial3: true,
    );
  }
}