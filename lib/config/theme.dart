import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      primaryColor: const Color(0xFF4CAF50),
      scaffoldBackgroundColor: Colors.white,
      useMaterial3: true,
    );
  }

  static const primaryColor = Color(0xFF4CAF50);
  static const borderRadius = 30.0;
  static InputDecoration get inputDecoration => InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF4CAF50), width: 2),
        ),
        fillColor: Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      );

  static InputDecoration getInputDecorationWithTopLabel(String label) => InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF4CAF50), width: 2),
        ),
        fillColor: Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      );
}