import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../config/theme.dart';

class CustomNumberField extends StatelessWidget {
  final String label;
  final String? suffix;
  final int? initialValue;
  final void Function(int?) onChanged;
  final String? Function(String?)? validator;
  
  const CustomNumberField({
    super.key,
    required this.label,
    this.suffix,
    this.initialValue,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        initialValue: initialValue?.toString(),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: AppTheme.inputDecoration.copyWith(
          labelText: label,
          suffixText: suffix,
        ),          validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Este campo es requerido';
          }
          final number = int.tryParse(value);
          if (number == null) {
            return 'Ingrese un número válido';
          }
          if (number < 0) {
            return 'El número debe ser mayor o igual a 0';
          }
          return null;
        },
        onChanged: (value) {
          final number = int.tryParse(value);
          onChanged(number);
        },
      ),
    );
  }
}
