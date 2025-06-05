import 'package:flutter/material.dart';
import '../../config/theme.dart';

class CustomDateField extends StatelessWidget {
  final String label;
  final DateTime? initialDate;
  final void Function(DateTime) onDateSelected;

  const CustomDateField({
    super.key,
    required this.label,
    this.initialDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: AppTheme.inputDecoration.copyWith(
          labelText: label,
          suffixIcon: const Icon(Icons.calendar_today),
        ),
        readOnly: true,
        controller: TextEditingController(
          text: initialDate?.toString().split(' ')[0] ?? '',
        ),
        onTap: () async {
          final date = await showDatePicker(
            context: context,
            initialDate: initialDate ?? DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now(),
          );
          if (date != null) {
            onDateSelected(date);
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Este campo es requerido';
          }
          return null;
        },
      ),
    );
  }
}
