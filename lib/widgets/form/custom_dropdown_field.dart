import 'package:flutter/material.dart';
import '../../config/theme.dart';

class CustomDropdownField extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> items;
  final void Function(String?) onChanged;
  
  const CustomDropdownField({
    super.key,
    required this.label,
    this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: items.contains(value) ? value : null,
        decoration: AppTheme.inputDecoration.copyWith(
          labelText: label,
        ),
        items: items.map((item) => DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        )).toList(),
        onChanged: onChanged,
        isExpanded: true,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor seleccione una opción';
          }
          return null;
        },
      ),
    );
  }
}
