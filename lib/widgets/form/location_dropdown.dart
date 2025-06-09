import 'package:flutter/material.dart';

class LocationDropdown extends StatefulWidget {
  final String label;
  final String? value;
  final String? placeholder;
  final List<String> items;
  final Function(String?) onChanged;
  final String? Function(String?)? validator;
  final IconData? prefixIcon;
  final bool enabled;
  final String? parentSelection;

  const LocationDropdown({
    super.key,
    required this.label,
    this.value,
    this.placeholder,
    required this.items,
    required this.onChanged,
    this.validator,
    this.prefixIcon,
    this.enabled = true,
    this.parentSelection,
  });

  @override
  State<LocationDropdown> createState() => _LocationDropdownState();
}

class _LocationDropdownState extends State<LocationDropdown> {  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              widget.label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF424242),
              ),
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              return DropdownButtonFormField<String>(
                value: widget.value,
                isExpanded: true, // Evita overflow horizontal
                decoration: InputDecoration(
                  hintText: widget.placeholder ?? 'Seleccionar ${widget.label}',
                  prefixIcon: widget.prefixIcon != null 
                      ? Icon(widget.prefixIcon, color: const Color(0xFF4CAF50))
                      : null,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  filled: true,
                  fillColor: widget.enabled ? Colors.grey.shade50 : Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Color(0xFF4CAF50), width: 2.0),
                  ),
                ),
                items: widget.items.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: SizedBox(
                      width: constraints.maxWidth - 32, // Asegura espacio adecuado
                      child: Text(
                        item,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: widget.enabled ? widget.onChanged : null,
                validator: widget.validator,
              );
            },
          ),
        ],
      ),
    );
  }
}
