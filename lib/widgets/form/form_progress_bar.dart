import 'package:flutter/material.dart';

/// Widget moderno para mostrar el progreso de un formulario con múltiples pasos
class FormProgressBar extends StatefulWidget {
  final int currentStep;
  final int totalSteps;
  final List<String>? stepTitles;
  final Color? primaryColor;
  final Color? backgroundColor;
  final double height;
  final bool showPercentage;
  final bool showStepIndicators;
  final Duration animationDuration;

  const FormProgressBar({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    this.stepTitles,
    this.primaryColor,
    this.backgroundColor,
    this.height = 8.0,
    this.showPercentage = true,
    this.showStepIndicators = true,
    this.animationDuration = const Duration(milliseconds: 500),
  });

  @override
  State<FormProgressBar> createState() => _FormProgressBarState();
}

class _FormProgressBarState extends State<FormProgressBar>
    with TickerProviderStateMixin {
  late AnimationController _progressController;
  late AnimationController _indicatorController;
  late Animation<double> _progressAnimation;
  late List<Animation<double>> _indicatorAnimations;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _progressController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _indicatorController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: widget.currentStep / widget.totalSteps,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOut,
    ));

    _indicatorAnimations = List.generate(
      widget.totalSteps,
      (index) => Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: _indicatorController,
        curve: Interval(
          index / widget.totalSteps,
          (index + 1) / widget.totalSteps,
          curve: Curves.elasticOut,
        ),
      )),
    );

    _progressController.forward();
    _indicatorController.forward();
  }

  @override
  void didUpdateWidget(FormProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentStep != widget.currentStep) {
      _progressAnimation = Tween<double>(
        begin: _progressAnimation.value,
        end: widget.currentStep / widget.totalSteps,
      ).animate(CurvedAnimation(
        parent: _progressController,
        curve: Curves.easeInOut,
      ));
      _progressController.reset();
      _progressController.forward();
    }
  }

  @override
  void dispose() {
    _progressController.dispose();
    _indicatorController.dispose();
    super.dispose();
  }

  Color get _primaryColor => widget.primaryColor ?? const Color(0xFF4CAF50);
  Color get _backgroundColor => widget.backgroundColor ?? Colors.grey.shade200;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.showPercentage) _buildPercentageText(),
          const SizedBox(height: 12),
          _buildProgressBar(),
          if (widget.showStepIndicators) ...[
            const SizedBox(height: 16),
            _buildStepIndicators(),
          ],
        ],
      ),
    );
  }
  Widget _buildPercentageText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Progreso del formulario',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade700,
          ),
        ),
        AnimatedBuilder(
          animation: _progressAnimation,
          builder: (context, child) {
            final animatedPercentage = 
                (_progressAnimation.value * 100).round();
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '$animatedPercentage%',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: _primaryColor,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildProgressBar() {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(widget.height / 2),
      ),
      child: AnimatedBuilder(
        animation: _progressAnimation,
        builder: (context, child) {
          return Container(
            alignment: Alignment.centerLeft,
            child: Container(
              height: widget.height,
              width: MediaQuery.of(context).size.width * 
                     _progressAnimation.value * 0.85, // 85% del ancho disponible
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    _primaryColor,
                    _primaryColor.withValues(alpha: 0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(widget.height / 2),
                boxShadow: [
                  BoxShadow(
                    color: _primaryColor.withValues(alpha: 0.3),
                    offset: const Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStepIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(widget.totalSteps, (index) {
        final isCompleted = index < widget.currentStep;
        final isCurrent = index == widget.currentStep - 1;
        
        return AnimatedBuilder(
          animation: _indicatorAnimations[index],
          builder: (context, child) {
            return Transform.scale(
              scale: _indicatorAnimations[index].value,
              child: _buildStepIndicator(
                index: index,
                isCompleted: isCompleted,
                isCurrent: isCurrent,
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildStepIndicator({
    required int index,
    required bool isCompleted,
    required bool isCurrent,
  }) {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCompleted || isCurrent
                ? _primaryColor
                : _backgroundColor,
            border: Border.all(
              color: isCompleted || isCurrent
                  ? _primaryColor
                  : Colors.grey.shade400,
              width: 2,
            ),
            boxShadow: isCompleted || isCurrent
                ? [
                    BoxShadow(
                      color: _primaryColor.withValues(alpha: 0.3),
                      offset: const Offset(0, 2),
                      blurRadius: 6,
                    ),
                  ]
                : [],
          ),
          child: Center(            child: isCompleted
                ? const Icon(
                    Icons.check,
                    size: 18,
                    color: Colors.white,
                  )
                : Text(
                    '${index + 1}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isCompleted || isCurrent
                          ? Colors.white
                          : Colors.grey.shade600,
                    ),
                  ),
          ),
        ),
        if (widget.stepTitles != null && 
            index < widget.stepTitles!.length) ...[
          const SizedBox(height: 8),
          SizedBox(
            width: 60,
            child: Text(
              widget.stepTitles![index],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: isCompleted || isCurrent
                    ? _primaryColor
                    : Colors.grey.shade600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ],
    );
  }
}

/// Widget simplificado para progreso lineal básico
class SimpleProgressBar extends StatelessWidget {
  final double progress; // 0.0 a 1.0
  final Color? color;
  final double height;
  final BorderRadius? borderRadius;

  const SimpleProgressBar({
    super.key,
    required this.progress,
    this.color,
    this.height = 4.0,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: borderRadius ?? BorderRadius.circular(height / 2),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress.clamp(0.0, 1.0),
        child: Container(
          decoration: BoxDecoration(
            color: color ?? const Color(0xFF4CAF50),
            borderRadius: borderRadius ?? BorderRadius.circular(height / 2),
          ),
        ),
      ),
    );
  }
}
