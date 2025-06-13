import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/page_transitions.dart';
import '../widgets/animations/animated_particles.dart';
import '../widgets/animations/animated_loading_indicator.dart';
import 'survey_form_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> 
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _backgroundController;
  late AnimationController _textController;
    late Animation<double> _logoScale;
  late Animation<double> _logoFade;
  late Animation<double> _backgroundGradient;
  late Animation<double> _textFade;

  @override
  void initState() {
    super.initState();
    
    // Configurar vibración al iniciar
    _initControllers();
    _initAnimations();
    _startAnimationSequence();
  }
  void _initControllers() {
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _backgroundController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    
    _textController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
  }

  void _initAnimations() {
    // Animaciones del logo
    _logoScale = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.elasticOut,
    ));
    
    _logoFade = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeInOut),
    ));

    // Animación del fondo
    _backgroundGradient = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _backgroundController,
      curve: Curves.easeInOut,
    ));    // Animaciones del texto
    _textFade = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeInOut,
    ));
  }

  void _startAnimationSequence() async {
    // Vibración suave al inicio
    HapticFeedback.lightImpact();
      // Secuencia de animaciones
    _backgroundController.forward();
    
    await Future.delayed(const Duration(milliseconds: 300));
    _logoController.forward();
    
    await Future.delayed(const Duration(milliseconds: 800));
    _textController.forward();
      // Navegar después de completar las animaciones
    await Future.delayed(const Duration(milliseconds: 2500));
    if (mounted) {
      HapticFeedback.mediumImpact();
      Navigator.pushReplacement(
        context,
        CircularRevealTransition(child: const SurveyFormPage()),
      );
    }
  }  @override
  void dispose() {
    _logoController.dispose();
    _backgroundController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(        animation: Listenable.merge([
          _logoController,
          _backgroundController,
          _textController,
        ]),
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.lerp(
                    const Color(0xFFE8F5E8),
                    const Color(0xFF4CAF50),
                    _backgroundGradient.value * 0.3,
                  )!,
                  Color.lerp(
                    Colors.white,
                    const Color(0xFF2E7D32),
                    _backgroundGradient.value * 0.1,
                  )!,
                ],
              ),
            ),            child: Stack(
              children: [
                // Partículas de fondo animadas
                const Positioned.fill(
                  child: AnimatedParticles(
                    particleCount: 25,
                    particleColor: Color(0xFF4CAF50),
                    minSize: 1.5,
                    maxSize: 4.0,
                    duration: Duration(seconds: 8),
                  ),
                ),
                
                // Círculos decorativos
                Positioned(
                  top: -100,
                  right: -50,
                  child: Transform.scale(
                    scale: _backgroundGradient.value,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF4CAF50).withOpacity(0.1),
                      ),
                    ),
                  ),
                ),
                
                Positioned(
                  bottom: -80,
                  left: -30,
                  child: Transform.scale(
                    scale: _backgroundGradient.value * 0.8,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF4CAF50).withOpacity(0.08),
                      ),
                    ),
                  ),
                ),

                // Contenido principal centrado
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [                      // Logo con animación (solo símbolo CENS)
                      FloatingParticle(
                        amplitude: 8.0,
                        duration: const Duration(seconds: 4),
                        child: Transform.scale(
                          scale: _logoScale.value,
                          child: FadeTransition(
                            opacity: _logoFade,
                            child: Container(
                              width: 200,
                              height: 200,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.9),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF4CAF50).withOpacity(0.3),
                                    blurRadius: 20,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              child: Image.asset(
                                'assets/logo.png',
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF4CAF50),
                                    ),
                                    child: const Icon(
                                      Icons.school,
                                      size: 80,
                                      color: Colors.white,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),                      ),
                      
                      const SizedBox(height: 80),
                        // Indicador de carga animado
                      FadeTransition(
                        opacity: _textFade,
                        child: const AnimatedLoadingIndicator(
                          size: 40,
                          color: Color(0xFF4CAF50),
                          duration: Duration(milliseconds: 1500),
                        ),
                      ),
                    ],
                  ),
                ),
                  // Texto inferior con indicador de puntos
                Positioned(
                  bottom: 60,
                  left: 0,
                  right: 0,
                  child: FadeTransition(
                    opacity: _textFade,
                    child: Column(
                      children: [
                        Text(
                          'Cargando aplicación',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const ThreeDotsLoader(
                          color: Color(0xFF4CAF50),
                          size: 6.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),    );
  }
}