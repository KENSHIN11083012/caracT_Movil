import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomNumberField extends StatefulWidget {
  final String label;
  final String? suffix;
  final int? initialValue;
  final void Function(int?) onChanged;
  final String? Function(String?)? validator;
  final int? minValue;
  final int? maxValue;
  final String? hintText;
  final IconData? prefixIcon;
  final bool enabled;
  
  const CustomNumberField({
    super.key,
    required this.label,
    this.suffix,
    this.initialValue,
    required this.onChanged,
    this.validator,
    this.minValue,
    this.maxValue,
    this.hintText,
    this.prefixIcon,
    this.enabled = true,
  });

  @override
  State<CustomNumberField> createState() => _CustomNumberFieldState();
}

class _CustomNumberFieldState extends State<CustomNumberField> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color?> _colorAnimation;
  late TextEditingController _controller;
  
  bool _isFocused = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue?.toString());
    
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

  void _increment() {
    final currentValue = int.tryParse(_controller.text) ?? 0;
    final newValue = currentValue + 1;
    if (widget.maxValue == null || newValue <= widget.maxValue!) {
      _controller.text = newValue.toString();
      widget.onChanged(newValue);
    }
  }

  void _decrement() {
    final currentValue = int.tryParse(_controller.text) ?? 0;
    final newValue = currentValue - 1;
    if (widget.minValue == null || newValue >= widget.minValue!) {
      _controller.text = newValue >= 0 ? newValue.toString() : '0';
      widget.onChanged(newValue >= 0 ? newValue : 0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Row(
              children: [
                Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: _isFocused ? 15 : 14,
                    fontWeight: FontWeight.w600,
                    color: _isFocused 
                        ? const Color(0xFF4CAF50)
                        : const Color(0xFF424242),
                  ),
                ),
                if (widget.suffix != null) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4CAF50).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      widget.suffix!,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF4CAF50),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: _isFocused ? [
                    BoxShadow(
                      color: const Color(0xFF4CAF50).withValues(alpha: 0.15),
                      offset: const Offset(0, 4),
                      blurRadius: 12,
                      spreadRadius: 0,
                    ),
                  ] : [],
                ),
                child: TextFormField(
                  controller: _controller,
                  focusNode: _focusNode,
                  keyboardType: TextInputType.number,
                  enabled: widget.enabled,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF2C3E50),
                  ),
                  decoration: InputDecoration(
                    hintText: widget.hintText ?? 'Ingrese ${widget.label.toLowerCase()}',
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
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: widget.enabled ? _decrement : null,
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Icon(
                                Icons.remove,
                                color: widget.enabled 
                                    ? (_isFocused 
                                        ? const Color(0xFF4CAF50)
                                        : Colors.grey.shade600)
                                    : Colors.grey.shade400,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 20,
                          color: Colors.grey.shade300,
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: widget.enabled ? _increment : null,
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Icon(
                                Icons.add,
                                color: widget.enabled 
                                    ? (_isFocused 
                                        ? const Color(0xFF4CAF50)
                                        : Colors.grey.shade600)
                                    : Colors.grey.shade400,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
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
                  validator: widget.validator ?? (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es requerido';
                    }
                    final number = int.tryParse(value);
                    if (number == null) {
                      return 'Ingrese un número válido';
                    }
                    if (widget.minValue != null && number < widget.minValue!) {
                      return 'El valor mínimo es ${widget.minValue}';
                    }
                    if (widget.maxValue != null && number > widget.maxValue!) {
                      return 'El valor máximo es ${widget.maxValue}';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    final number = int.tryParse(value);
                    widget.onChanged(number);
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
