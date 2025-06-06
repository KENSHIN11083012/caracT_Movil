import 'package:flutter/material.dart';
import '../../config/theme.dart';

class AutocompleteField extends StatelessWidget {
  final String label;
  final List<String> options;
  final String? initialValue;
  final void Function(String) onSelected;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const AutocompleteField({
    super.key,
    required this.label,
    required this.options,
    this.initialValue,
    required this.onSelected,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: RawAutocomplete<String>(
        textEditingController: controller,
        focusNode: FocusNode(),
        optionsBuilder: (TextEditingValue textEditingValue) {
          return options.where((option) =>
            option.toLowerCase().contains(textEditingValue.text.toLowerCase())
          ).toList();
        },
        onSelected: onSelected,
        fieldViewBuilder: (
          BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted,
        ) {
          return TextFormField(
            controller: textEditingController,
            focusNode: focusNode,
            decoration: AppTheme.inputDecoration.copyWith(
              labelText: label,
              suffixIcon: const Icon(Icons.search),
              hintText: 'Escriba para buscar...',
            ),
            onChanged: (value) {
              // Permitir la búsqueda mientras escribe
              if (value.isNotEmpty) {
                onSelected(value);
              }
            },
            validator: validator ?? (value) {
              if (value == null || value.isEmpty) {
                return 'Este campo es requerido';
              }
              if (!options.contains(value)) {
                return 'Seleccione una opción válida';
              }
              return null;
            },
          );
        },
        optionsViewBuilder: (
          BuildContext context,
          AutocompleteOnSelected<String> onSelected,
          Iterable<String> options,
        ) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              elevation: 4.0,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 200),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: options.length,
                  itemBuilder: (BuildContext context, int index) {
                    final option = options.elementAt(index);
                    return ListTile(
                      title: Text(option),
                      onTap: () {
                        onSelected(option);
                      },
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
