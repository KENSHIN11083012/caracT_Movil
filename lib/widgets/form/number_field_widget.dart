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
  late TextEditingController _controller;
  late AnimationController _animationController;
  late Animation<Color?> _colorAnimation;
  bool _isFocused = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.initialValue?.toString() ?? '',
    );
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    
    _colorAnimation = ColorTween(
      begin: Colors.grey.shade300,
      end: const Color(0xFF4CAF50),
    ).animate(_animationController);
    
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
        if (_isFocused) {
          _animationController.forward();
        } else {
          _animationController.reverse();
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF2C3E50),
          ),
        ),
        const SizedBox(height: 8),
        AnimatedBuilder(
          animation: _colorAnimation,
          builder: (context, child) {
            return TextFormField(
              controller: _controller,
              focusNode: _focusNode,
              enabled: widget.enabled,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                if (widget.maxValue != null)
                  _NumberRangeFormatter(
                    min: widget.minValue ?? 0,
                    max: widget.maxValue!,
                  ),
              ],
              onChanged: (value) {
                final intValue = int.tryParse(value);
                widget.onChanged(intValue);
              },
              validator: widget.validator,
              decoration: InputDecoration(
                hintText: widget.hintText,
                suffixText: widget.suffix,
                prefixIcon: widget.prefixIcon != null
                    ? Icon(widget.prefixIcon, color: _colorAnimation.value)
                    : null,
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
                  borderSide: BorderSide(color: _colorAnimation.value!, width: 2),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.red, width: 2),
                ),
                filled: true,
                fillColor: widget.enabled ? Colors.grey.shade50 : Colors.grey.shade100,
              ),
            );
          },
        ),
      ],
    );
  }
}

class _NumberRangeFormatter extends TextInputFormatter {
  final int min;
  final int max;

  _NumberRangeFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final int? value = int.tryParse(newValue.text);
    if (value == null) {
      return oldValue;
    }

    if (value < min || value > max) {
      return oldValue;
    }

    return newValue;
  }
}