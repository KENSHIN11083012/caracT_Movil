import 'package:flutter/material.dart';
import '../form/continue_button.dart';

class FormContainer extends StatelessWidget {
  final String title;
  final int currentStep;
  final Widget child;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;
  final String nextLabel;
  final bool showPrevious;

  const FormContainer({
    super.key,
    required this.title,
    required this.currentStep,
    required this.child,
    this.onPrevious,
    this.onNext,
    this.nextLabel = 'Continuar',
    this.showPrevious = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Column(
        children: [
          // Header moderno con gradiente
          Container(
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
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => Navigator.pop(context),
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
                        ),
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
                                'Paso $currentStep de 9',
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.9),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 40, // Para balance visual
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
                                   (currentStep / 9) - 40, // -40 para padding
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
                      children: List.generate(9, (index) {
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
          ),
          
          // Contenido principal
          Expanded(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x1A000000),
                    offset: Offset(0, -4),
                    blurRadius: 20,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
                child: Column(
                  children: [
                    // Indicador visual de drag
                    Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(top: 12, bottom: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    
                    // Contenido scrolleable
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(24, 16, 24, 120),
                        child: child,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      
      // Botón flotante en la parte inferior
      floatingActionButton: onNext != null ? Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: ContinueButton(
          onPressed: onNext!,
          showPrevious: showPrevious,
          onPreviousPressed: onPrevious,
        ),
      ) : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
