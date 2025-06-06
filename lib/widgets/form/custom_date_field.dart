import 'package:flutter/material.dart';
import '../../config/theme.dart';

class CustomDateField extends StatelessWidget {
  final String label;
  final DateTime? initialDate;
  final void Function(DateTime) onDateSelected;
  final String? Function(String?)? validator;

  const CustomDateField({
    super.key,
    required this.label,
    this.initialDate,
    required this.onDateSelected,
    this.validator,
  });
  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: AppTheme.inputDecoration.copyWith(
          labelText: label,
          hintText: 'dd/mm/aaaa',
          suffixIcon: Icon(
            Icons.calendar_today,
            color: Colors.grey.shade600,
          ),
        ),
        readOnly: true,
        controller: TextEditingController(
          text: _formatDate(initialDate),
        ),
        onTap: () async {
          final date = await showDatePicker(
            context: context,
            initialDate: initialDate ?? DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now(),
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                    primary: AppTheme.primaryColor,
                    onPrimary: Colors.white,
                    surface: Colors.white,
                    onSurface: Colors.black87,
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor: AppTheme.primaryColor,
                    ),
                  ),
                ),
                child: child!,
              );
            },
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
