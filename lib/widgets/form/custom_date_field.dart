import 'package:flutter/material.dart';

class CustomDateField extends StatefulWidget {
  final String label;
  final DateTime? initialDate;
  final void Function(DateTime) onDateSelected;
  final String? Function(String?)? validator;
  final String? hintText;
  final bool enabled;
  final IconData? prefixIcon;

  const CustomDateField({
    super.key,
    required this.label,
    this.initialDate,
    required this.onDateSelected,
    this.validator,
    this.hintText,
    this.enabled = true,
    this.prefixIcon,
  });

  @override
  State<CustomDateField> createState() => _CustomDateFieldState();
}

class _CustomDateFieldState extends State<CustomDateField> with SingleTickerProviderStateMixin {
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
  }
  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
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
                  readOnly: true,
                  focusNode: _focusNode,
                  enabled: widget.enabled,
                  initialValue: _formatDate(widget.initialDate),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF2C3E50),
                  ),
                  decoration: InputDecoration(
                    hintText: widget.hintText ?? 'Seleccione una fecha',
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
                        Icons.calendar_today,
                        color: _isFocused 
                            ? const Color(0xFF4CAF50)
                            : Colors.grey.shade600,
                        size: 20,
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
                  onTap: widget.enabled ? () async {
                    FocusScope.of(context).requestFocus(_focusNode);
                    
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: widget.initialDate ?? DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      locale: const Locale('es', ''),
                      builder: (context, child) {                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: const ColorScheme.light(
                              primary: Color(0xFF4CAF50),
                              onPrimary: Colors.white,
                              surface: Colors.white,
                              onSurface: Colors.black87,
                            ),
                            dialogTheme: const DialogThemeData(
                              backgroundColor: Colors.white,
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    
                    if (picked != null) {
                      widget.onDateSelected(picked);
                    }
                    
                    _focusNode.unfocus();
                  } : null,
                  validator: widget.validator ?? (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor seleccione una fecha';
                    }
                    return null;
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
