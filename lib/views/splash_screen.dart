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
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _curveAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _borderAnimation = Tween<double>(begin: 0, end: 1).animate(_curveAnimation);

    _controller.forward();
    
    // Navegar después de 2 segundos
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/home');
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
      ..style = PaintingStyle.fill
      ..strokeWidth = 4.0;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width * progress, 0)
      ..quadraticBezierTo(
        size.width,
        0,
        size.width,
        size.height * progress,
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(BorderPainter oldDelegate) => progress != oldDelegate.progress;
}