import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final double borderRadius;

  const RoundedContainer({
    super.key,
    required this.child,
    this.backgroundColor = Colors.white,
    this.borderRadius = 30.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
        ),
      ),
      child: child,
    );
  }
}
