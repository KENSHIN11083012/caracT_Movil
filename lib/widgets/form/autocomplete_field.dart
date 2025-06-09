import 'package:flutter/material.dart';

class AutocompleteField extends StatefulWidget {
  final String label;
  final List<String> options;
  final String? initialValue;
  final void Function(String) onSelected;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final IconData? prefixIcon;
  final bool enabled;

  const AutocompleteField({
    super.key,
    required this.label,
    required this.options,
    this.initialValue,
    required this.onSelected,
    this.controller,
    this.validator,
    this.hintText,
    this.prefixIcon,
    this.enabled = true,
  });

  @override
  State<AutocompleteField> createState() => _AutocompleteFieldState();
}

class _AutocompleteFieldState extends State<AutocompleteField> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color?> _colorAnimation;
  
  bool _isFocused = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    
    _colorAnimation = ColorTween(
      begin: Colors.grey.shade300,
      end: const Color(0xFF4CAF50),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
    
    if (_isFocused) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _focusNode.dispose();
    super.dispose();
  }  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              widget.label,
              style: TextStyle(
                fontSize: _isFocused ? 15 : 14,
                fontWeight: FontWeight.w600,
                color: _isFocused 
                    ? const Color(0xFF4CAF50)
                    : const Color(0xFF424242),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),                  boxShadow: _isFocused ? [
                    BoxShadow(
                      color: const Color(0xFF4CAF50).withValues(alpha: 0.15),
                      offset: const Offset(0, 4),
                      blurRadius: 12,
                      spreadRadius: 0,
                    ),
                  ] : [],
                ),
                child: RawAutocomplete<String>(
                  textEditingController: widget.controller,
                  focusNode: _focusNode,
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text.isEmpty) {
                      return const Iterable<String>.empty();
                    }
                    return widget.options.where((option) =>
                      option.toLowerCase().contains(textEditingValue.text.toLowerCase())
                    ).toList();
                  },
                  onSelected: widget.onSelected,
                  fieldViewBuilder: (
                    BuildContext context,
                    TextEditingController textEditingController,
                    FocusNode focusNode,
                    VoidCallback onFieldSubmitted,
                  ) {
                    return TextFormField(
                      controller: textEditingController,
                      focusNode: focusNode,
                      enabled: widget.enabled,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF2C3E50),
                      ),
                      decoration: InputDecoration(
                        hintText: widget.hintText ?? 'Escriba para buscar...',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w400,
                        ),
                        prefixIcon: widget.prefixIcon != null ? Container(
                          margin: const EdgeInsets.only(left: 16, right: 12),
                          child: Icon(
                            widget.prefixIcon,
                            color: _isFocused 
                                ? const Color(0xFF4CAF50)
                                : Colors.grey.shade600,
                            size: 22,
                          ),
                        ) : null,
                        suffixIcon: Container(
                          margin: const EdgeInsets.only(right: 16, left: 12),
                          child: Icon(
                            Icons.search,
                            color: _isFocused 
                                ? const Color(0xFF4CAF50)
                                : Colors.grey.shade600,
                            size: 22,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: widget.prefixIcon != null ? 8 : 20,
                          vertical: 18,
                        ),
                        filled: true,
                        fillColor: widget.enabled 
                            ? (_isFocused 
                                ? Colors.white 
                                : Colors.grey.shade50)
                            : Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: _colorAnimation.value ?? Colors.grey.shade300,
                            width: 1.5,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: Color(0xFF4CAF50),
                            width: 2.0,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: Colors.red.shade400,
                            width: 1.5,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: Colors.red.shade400,
                            width: 2.0,
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1.0,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          widget.onSelected(value);
                        }
                      },
                      validator: widget.validator ?? (value) {
                        if (value == null || value.isEmpty) {
                          return 'Este campo es requerido';
                        }
                        if (!widget.options.contains(value)) {
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
                        elevation: 8.0,
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                        child: Container(
                          constraints: const BoxConstraints(
                            maxHeight: 250,
                            maxWidth: 300,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: ListView.builder(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              shrinkWrap: true,
                              itemCount: options.length,
                              itemBuilder: (BuildContext context, int index) {
                                final option = options.elementAt(index);
                                return Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () => onSelected(option),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16, 
                                        vertical: 12,
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.search,
                                            size: 16,
                                            color: Colors.grey.shade600,
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Text(
                                              option,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF2C3E50),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
