import 'package:flutter/material.dart';

class OptionsContainer extends StatelessWidget {
  final List<Widget> children;
  final String? title;
  final IconData? titleIcon;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  
  const OptionsContainer({
    super.key,
    required this.children,
    this.title,
    this.titleIcon,
    this.margin,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, 2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header con título si se proporciona
          if (title != null) ...[
            Container(
              padding: padding ?? const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF4CAF50).withValues(alpha: 0.05),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  if (titleIcon != null) ...[
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4CAF50).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        titleIcon,
                        color: const Color(0xFF4CAF50),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    child: Text(
                      title!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          
          // Opciones
          Padding(
            padding: padding ?? const EdgeInsets.all(16),
            child: Column(
              children: _buildChildrenWithDividers(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildChildrenWithDividers() {
    if (children.isEmpty) return [];
    
    final List<Widget> result = [];
    
    for (int i = 0; i < children.length; i++) {
      // Envolver cada child en un contenedor con animación
      result.add(
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          child: children[i],
        ),
      );
      
      // Agregar divisor si no es el último elemento
      if (i < children.length - 1) {
        result.add(
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.grey.withValues(alpha: 0.2),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        );
      }
    }
    
    return result;
  }
}
