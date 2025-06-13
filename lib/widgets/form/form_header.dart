import 'package:flutter/material.dart';

class FormHeader extends StatelessWidget {
  final String title;
  final int currentStep;
  final int totalSteps;
  final String? subtitle;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;

  const FormHeader({
    super.key,
    required this.title,
    required this.currentStep,
    required this.totalSteps,
    this.subtitle,
    this.onBackPressed,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF4CAF50),
            Color(0xFF45A049),
          ],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            children: [
              // Header superior
              Row(
                children: [
                  if (onBackPressed != null)
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: onBackPressed,
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    )
                  else
                    const SizedBox(width: 36),
                  
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Paso $currentStep de $totalSteps',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        if (subtitle != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            subtitle!,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.8),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ],
                    ),
                  ),
                  
                  SizedBox(
                    width: 36,
                    child: actions != null 
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: actions!,
                          )
                        : null,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
              // Barra de progreso moderna
              Container(
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Stack(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: MediaQuery.of(context).size.width * 
                             (currentStep / totalSteps) - 40, // -40 para padding
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withValues(alpha: 0.3),
                            blurRadius: 4,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              
              // Indicadores de pasos
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(totalSteps, (index) {
                  final stepNumber = index + 1;
                  final isCompleted = stepNumber < currentStep;
                  final isCurrent = stepNumber == currentStep;
                  
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: isCurrent ? 12 : 8,
                    height: isCurrent ? 12 : 8,
                    decoration: BoxDecoration(
                      color: isCompleted || isCurrent 
                          ? Colors.white 
                          : Colors.white.withValues(alpha: 0.4),
                      shape: BoxShape.circle,
                      boxShadow: isCurrent ? [
                        BoxShadow(
                          color: Colors.white.withValues(alpha: 0.5),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ] : [],
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
