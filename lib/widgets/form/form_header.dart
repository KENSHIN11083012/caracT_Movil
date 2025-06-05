import 'package:flutter/material.dart';
import 'form_progress_bar.dart';

class FormHeader extends StatelessWidget {
  final String title;
  final int currentStep;
  final int totalSteps;

  const FormHeader({
    super.key,
    required this.title,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Paso $currentStep de $totalSteps',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
