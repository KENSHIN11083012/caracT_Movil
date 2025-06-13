import 'package:flutter/material.dart';
import 'utils/form_navigator.dart';
import 'widgets/layout/enhanced_form_container.dart';

class TransitionsDemoPage extends StatelessWidget {
  const TransitionsDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo de Transiciones'),
        backgroundColor: const Color(0xFF4CAF50),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Prueba las diferentes transiciones',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              
              _buildTransitionButton(
                context,
                'Slide Transition',
                FormTransitionType.slide,
                const Color(0xFF2196F3),
                Icons.swap_horiz,
              ),
              const SizedBox(height: 16),
              
              _buildTransitionButton(
                context,
                'Slide + Scale Transition',
                FormTransitionType.slideScale,
                const Color(0xFF4CAF50),
                Icons.open_in_full,
              ),
              const SizedBox(height: 16),
              
              _buildTransitionButton(
                context,
                'Fade + Slide Transition',
                FormTransitionType.fadeSlide,
                const Color(0xFFFF9800),
                Icons.blur_on,
              ),
              const SizedBox(height: 16),
              
              _buildTransitionButton(
                context,
                'Layered Transition',
                FormTransitionType.layered,
                const Color(0xFF9C27B0),
                Icons.layers,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransitionButton(
    BuildContext context,
    String title,
    FormTransitionType type,
    Color color,
    IconData icon,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton.icon(
        onPressed: () {
          FormNavigator.pushForm(
            context,
            TransitionTestPage(
              title: title,
              type: type,
              color: color,
            ),
            type: type,
            stepNumber: 1,
          );
        },
        icon: Icon(icon, size: 24),
        label: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          elevation: 4,
          shadowColor: color.withOpacity(0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}

class TransitionTestPage extends StatelessWidget {
  final String title;
  final FormTransitionType type;
  final Color color;

  const TransitionTestPage({
    super.key,
    required this.title,
    required this.type,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return EnhancedFormContainer(
      title: title,
      subtitle: 'Prueba de transición personalizada',
      currentStep: 1,
      onPrevious: () => FormNavigator.popForm(context),
      onNext: () => _goToNextPage(context),
      transitionType: type,
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      color.withOpacity(0.1),
                      color.withOpacity(0.05),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: color.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.animation,
                      size: 48,
                      color: color,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Esta página demuestra la transición seleccionada.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              
              _buildFeatureCard(
                'Feedback Háptico',
                'Las transiciones incluyen vibración suave para mejorar la experiencia.',
                Icons.vibration,
                color,
              ),
              const SizedBox(height: 16),
              
              _buildFeatureCard(
                'Animaciones Fluidas',
                'Curvas de animación optimizadas para una navegación natural.',
                Icons.timeline,
                color,
              ),
              const SizedBox(height: 16),
              
              _buildFeatureCard(
                'Navegación Intuitiva',
                'Sistema de navegación diseñado para mejorar la usabilidad.',
                Icons.navigation,
                color,
              ),
              
              const SizedBox(height: 32),
              
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Características de la transición:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _getTransitionDescription(type),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(String title, String description, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _goToNextPage(BuildContext context) {
    FormNavigator.pushForm(
      context,
      TransitionTestPage(
        title: '$title - Página 2',
        type: type,
        color: color,
      ),
      type: type,
      stepNumber: 2,
    );
  }

  String _getTransitionDescription(FormTransitionType type) {
    switch (type) {
      case FormTransitionType.slide:
        return 'Deslizamiento suave horizontal con entrada y salida coordinada. Ideal para navegación secuencial.';
      case FormTransitionType.slideScale:
        return 'Combinación de deslizamiento y escala con feedback háptico. Proporciona una sensación de profundidad.';
      case FormTransitionType.fadeSlide:
        return 'Desvanecimiento suave con deslizamiento ligero. Transición elegante y sutil.';
      case FormTransitionType.layered:
        return 'Efecto de profundidad con sombras dinámicas. Crea una experiencia visual rica y moderna.';
    }
  }
}
