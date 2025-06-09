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
  Widget build(BuildContext context) {    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),child: Row(
        children: [
          if (showPrevious)
            Expanded(
              child: OutlinedButton(
                onPressed: onPrevious,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: Color(0xFF4CAF50)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_back, color: Color(0xFF4CAF50)),
                    SizedBox(width: 8),
                    Text(
                      'Anterior',
                      style: TextStyle(
                        color: Color(0xFF4CAF50),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (showPrevious) const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    nextLabel,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
