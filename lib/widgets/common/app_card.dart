import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final double radius;
  final double elevation;

  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(12),
    this.margin,
    this.radius = 16,
    this.elevation = 2,
  });

  @override
  Widget build(BuildContext context) {
    final outline = Colors.blue.shade200;
    return Card(
      elevation: elevation,
      margin: margin ?? const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: BorderSide(color: outline, width: 3),
        
      ),
      child: Padding(padding: padding, child: child),
    );
  }
}


