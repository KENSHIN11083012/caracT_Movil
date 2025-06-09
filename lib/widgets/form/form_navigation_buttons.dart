import 'package:flutter/material.dart';

class FormNavigationButtons extends StatelessWidget {
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final String nextLabel;
  final bool showPrevious;

  const FormNavigationButtons({
    super.key,
    required this.onPrevious,
    required this.onNext,
    this.nextLabel = 'Continuar',
    this.showPrevious = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (showPrevious)
            OutlinedButton.icon(
              onPressed: onPrevious,
              icon: const Icon(Icons.arrow_back),
              label: const Text('Anterior'),
            )
          else
            const SizedBox.shrink(),
          ElevatedButton.icon(
            onPressed: onNext,
            icon: const Icon(Icons.arrow_forward),
            label: Text(nextLabel),
          ),
        ],
      ),
    );
  }
}
