import 'dart:ui';

import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double blur;
  final double opacity;
  final BorderRadius borderRadius;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;

  const GlassContainer({
    super.key,
    required this.child,
    this.blur = 16,
    this.opacity = 0.15,
    this.borderRadius = const BorderRadius.all(Radius.circular(18)),
    this.borderColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final glassColor = Colors.white.withValues(alpha: opacity);
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          decoration: BoxDecoration(
            color: glassColor,
            gradient: LinearGradient(
              colors: [glassColor, Colors.white.withValues(alpha: opacity * 0.6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: borderRadius,
            border: Border.all(
              color: (borderColor ?? Colors.white.withValues(alpha: 0.25)),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 16,
                offset: const Offset(0, 8),
              )
            ],
          ),
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}


