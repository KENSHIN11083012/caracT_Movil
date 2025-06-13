import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedParticles extends StatefulWidget {
  final int particleCount;
  final Color particleColor;
  final double minSize;
  final double maxSize;
  final Duration duration;

  const AnimatedParticles({
    super.key,
    this.particleCount = 20,
    this.particleColor = const Color(0xFF4CAF50),
    this.minSize = 2.0,
    this.maxSize = 6.0,
    this.duration = const Duration(seconds: 10),
  });

  @override
  State<AnimatedParticles> createState() => _AnimatedParticlesState();
}

class _AnimatedParticlesState extends State<AnimatedParticles>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<Particle> _particles;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _generateParticles();
    _controller.repeat();
  }

  void _generateParticles() {
    final random = Random();
    _particles = List.generate(widget.particleCount, (index) {
      return Particle(
        x: random.nextDouble(),
        y: random.nextDouble(),
        size: widget.minSize + random.nextDouble() * (widget.maxSize - widget.minSize),
        speed: 0.1 + random.nextDouble() * 0.2,
        direction: random.nextDouble() * 2 * pi,
        opacity: 0.3 + random.nextDouble() * 0.4,
        pulsePhase: random.nextDouble() * 2 * pi,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: ParticlePainter(
            particles: _particles,
            animationValue: _controller.value,
            color: widget.particleColor,
          ),
          size: MediaQuery.of(context).size,
        );
      },
    );
  }
}

class Particle {
  double x;
  double y;
  final double size;
  final double speed;
  final double direction;
  final double opacity;
  final double pulsePhase;

  Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.direction,
    required this.opacity,
    required this.pulsePhase,
  });
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final double animationValue;
  final Color color;

  ParticlePainter({
    required this.particles,
    required this.animationValue,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (final particle in particles) {
      // Actualizar posición de la partícula
      particle.x += cos(particle.direction) * particle.speed * 0.01;
      particle.y += sin(particle.direction) * particle.speed * 0.01;

      // Envolver las partículas en los bordes
      if (particle.x > 1.0) particle.x = 0.0;
      if (particle.x < 0.0) particle.x = 1.0;
      if (particle.y > 1.0) particle.y = 0.0;
      if (particle.y < 0.0) particle.y = 1.0;

      // Calcular opacidad con efecto de pulso
      final pulseOpacity = particle.opacity * 
          (0.5 + 0.5 * sin(animationValue * 2 * pi + particle.pulsePhase));

      paint.color = color.withOpacity(pulseOpacity);

      // Dibujar la partícula
      canvas.drawCircle(
        Offset(particle.x * size.width, particle.y * size.height),
        particle.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(ParticlePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}

class FloatingParticle extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double amplitude;

  const FloatingParticle({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 3),
    this.amplitude = 10.0,
  });

  @override
  State<FloatingParticle> createState() => _FloatingParticleState();
}

class _FloatingParticleState extends State<FloatingParticle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _floatAnimation = Tween<double>(
      begin: 0.0,
      end: 2 * pi,
    ).animate(_controller);

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _floatAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            0,
            sin(_floatAnimation.value) * widget.amplitude,
          ),
          child: widget.child,
        );
      },
    );
  }
}
