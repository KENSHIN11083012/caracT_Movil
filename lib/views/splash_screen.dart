import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _curveAnimation;
  late Animation<double> _borderAnimation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _curveAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _borderAnimation = Tween<double>(begin: 0, end: 1).animate(_curveAnimation);

    _controller.forward();
    
    // Modificar la navegación
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/survey');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _borderAnimation,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Stack(
              children: [
                // Bordes verdes animados
                Positioned.fill(
                  child: AnimatedBuilder(
                    animation: _borderAnimation,
                    builder: (context, child) {
                      return CustomPaint(
                        painter: BorderPainter(
                          progress: _borderAnimation.value,
                          color: const Color(0xFF4CAF50),
                        ),
                      );
                    },
                  ),
                ),
                // Logo centrado
                Center(
                  child: FadeTransition(
                    opacity: _curveAnimation,
                    child: Image.asset(
                      'assets/logo.png', // Asegúrate de que la ruta sea correcta
                      width: 200,
                      height: 200,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class BorderPainter extends CustomPainter {
  final double progress;
  final Color color;

  BorderPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Figura izquierda
    final leftPath = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width * 0.4 * progress, 0)
      ..quadraticBezierTo(
        size.width * 0.5,
        0,
        size.width * 0.4,
        size.height * 0.3 * progress,
      )
      ..quadraticBezierTo(
        0,
        size.height * 0.5,
        0,
        size.height * progress,
      )
      ..lineTo(0, 0);

    // Figura derecha
    final rightPath = Path()
      ..moveTo(size.width, size.height)
      ..lineTo(size.width * (1 - 0.4 * progress), size.height)
      ..quadraticBezierTo(
        size.width * 0.5,
        size.height,
        size.width * 0.6,
        size.height * (1 - 0.3 * progress),
      )
      ..quadraticBezierTo(
        size.width,
        size.height * 0.5,
        size.width,
        size.height * (1 - progress),
      )
      ..lineTo(size.width, size.height);

    canvas.drawPath(leftPath, paint);
    canvas.drawPath(rightPath, paint);
  }

  @override
  bool shouldRepaint(BorderPainter oldDelegate) => progress != oldDelegate.progress;
}