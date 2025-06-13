import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/survey_state.dart';
import 'utils/form_transition_manager.dart';
import 'views/survey_form_page.dart';
import 'test_transitions_demo.dart';

class FormNavigationShowcase extends StatefulWidget {
  const FormNavigationShowcase({super.key});

  @override
  State<FormNavigationShowcase> createState() => _FormNavigationShowcaseState();
}

class _FormNavigationShowcaseState extends State<FormNavigationShowcase> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<ShowcaseItem> _showcaseItems = [
    ShowcaseItem(
      title: 'Sistema de Transiciones Mejorado',
      subtitle: 'Experiencia de navegación fluida',
      description: 'Hemos implementado un sistema completo de transiciones que hace la navegación entre formularios más intuitiva y agradable.',
      icon: Icons.animation,
      color: const Color(0xFF4CAF50),
      features: [
        'Cuatro tipos de transiciones personalizadas',
        'Feedback háptico para mejor experiencia',
        'Animaciones fluidas y naturales',
        'Configuración personalizable',
      ],
    ),
    ShowcaseItem(
      title: 'Navegación Inteligente',
      subtitle: 'FormNavigator avanzado',
      description: 'El nuevo FormNavigator gestiona automáticamente las transiciones, el feedback háptico y mantiene el estado de navegación.',
      icon: Icons.navigation,
      color: const Color(0xFF2196F3),
      features: [
        'Navegación programática mejorada',
        'Gestión automática del historial',
        'Feedback contextual por tipo de transición',
        'Soporte para navegación condicional',
      ],
    ),
    ShowcaseItem(
      title: 'Indicadores de Progreso',
      subtitle: 'Seguimiento visual mejorado',
      description: 'Los nuevos indicadores de progreso muestran claramente el avance del usuario a través del flujo de formularios.',
      icon: Icons.linear_scale,
      color: const Color(0xFFFF9800),
      features: [
        'Barra de progreso animada',
        'Indicadores de pasos completados',
        'Animaciones de estado',
        'Información contextual de progreso',
      ],
    ),
    ShowcaseItem(
      title: 'Configuración Personalizable',
      subtitle: 'Adaptable a preferencias',
      description: 'El sistema permite personalizar completamente las transiciones según las preferencias del usuario o las necesidades de la aplicación.',
      icon: Icons.settings,
      color: const Color(0xFF9C27B0),
      features: [
        'Configuración de velocidad y curvas',
        'Control de feedback háptico',
        'Estadísticas de uso',
        'Configuración automática por dispositivo',
      ],
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header con logo y título
            _buildHeader(),
            
            // Contenido principal
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _showcaseItems.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return _buildShowcasePage(_showcaseItems[index]);
                },
              ),
            ),
            
            // Indicadores de página
            _buildPageIndicators(),
            
            // Botones de acción
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(        gradient: LinearGradient(
          colors: [
            const Color(0xFF4CAF50),
            const Color(0xFF66BB6A),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Transiciones Mejoradas',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Sistema de navegación intuitiva',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShowcasePage(ShowcaseItem item) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icono y título principal
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),                decoration: BoxDecoration(
                  color: item.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  item.icon,
                  color: item.color,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      item.subtitle,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Descripción
          Text(
            item.description,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 24),
          
          // Lista de características
          const Text(
            'Características principales:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          
          ...item.features.map((feature) => _buildFeatureItem(feature, item.color)),
          
          const SizedBox(height: 32),
          
          // Demostración visual
          _buildVisualDemo(item),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String feature, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              feature,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVisualDemo(ShowcaseItem item) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            item.color.withOpacity(0.05),
            item.color.withOpacity(0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: item.color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.play_circle_outline,
            color: item.color,
            size: 48,
          ),
          const SizedBox(height: 12),
          Text(
            'Demo Interactivo',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: item.color,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Toca los botones abajo para probar las nuevas funcionalidades',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicators() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          _showcaseItems.length,
          (index) => AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: _currentPage == index ? 24 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: _currentPage == index 
                  ? const Color(0xFF4CAF50) 
                  : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Botón principal - Probar formularios
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                      create: (context) => SurveyState(),
                      child: const SurveyFormPage(),
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.quiz, size: 24),
              label: const Text(
                'Probar Formularios con Nuevas Transiciones',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                foregroundColor: Colors.white,
                elevation: 4,
                shadowColor: const Color(0xFF4CAF50).withOpacity(0.4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          
          // Botones secundarios
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TransitionsDemoPage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.animation, size: 20),
                  label: const Text('Demo Transiciones'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: const BorderSide(
                      color: Color(0xFF4CAF50),
                      width: 1.5,
                    ),
                    foregroundColor: const Color(0xFF4CAF50),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TransitionSettings(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.settings, size: 20),
                  label: const Text('Configuración'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: const BorderSide(
                      color: Color(0xFF4CAF50),
                      width: 1.5,
                    ),
                    foregroundColor: const Color(0xFF4CAF50),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ShowcaseItem {
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final Color color;
  final List<String> features;

  ShowcaseItem({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.color,
    required this.features,
  });
}
