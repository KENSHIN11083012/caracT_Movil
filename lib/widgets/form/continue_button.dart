import 'package:flutter/material.dart';

class ContinueButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool showPrevious;
  final VoidCallback? onPreviousPressed;

  const ContinueButton({
    super.key,
    required this.onPressed,
    this.showPrevious = false,
    this.onPreviousPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: showPrevious 
          ? MainAxisAlignment.spaceBetween 
          : MainAxisAlignment.end,
      children: [
        if (showPrevious)
          TextButton.icon(
            onPressed: onPreviousPressed ?? () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back),
            label: const Text('Anterior'),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF4CAF50),
            ),
          ),
        ElevatedButton.icon(
          onPressed: onPressed,
          icon: const Icon(Icons.arrow_forward),
          label: const Text('Continuar'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4CAF50),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }
}
