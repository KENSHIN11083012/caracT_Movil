import 'package:flutter/material.dart';
import '../../config/theme.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final int? maxLines;
  final String? initialValue;  // Añadir initialValue
  
  const CustomTextField({
    super.key,
    required this.label,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.maxLines = 1,
    this.initialValue,  // Añadir al constructor
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        initialValue: controller == null ? initialValue : null, // Usar initialValue solo si no hay controller
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: AppTheme.inputDecoration.copyWith(
          labelText: label,
          hintText: hintText,
        ),
        validator: validator ?? (value) {
          if (value == null || value.isEmpty) {
            return 'Este campo es requerido';
          }
          return null;
        },
        onChanged: onChanged,
      ),
    );
  }
}
