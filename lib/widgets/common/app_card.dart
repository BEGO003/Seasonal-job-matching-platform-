import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final double radius;
  final double elevation;
  final Color? borderColor;
  final double borderWidth;
  final Color? backgroundColor;
  final List<BoxShadow>? customShadow;
  final Gradient? gradient;

  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(12),
    this.margin,
    this.radius = 18,
    this.elevation = 0,
    this.borderColor,
    this.borderWidth = 1,
    this.backgroundColor,
    this.customShadow,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    // Default modern border color with subtle appearance
    final defaultBorderColor = borderColor ?? Colors.grey.shade200;
    
    // Default modern shadow with subtle depth
    final defaultShadow = customShadow ?? [
      BoxShadow(
        color: Colors.black.withOpacity(0.04),
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
      BoxShadow(
        color: Colors.black.withOpacity(0.02),
        blurRadius: 4,
        offset: const Offset(0, 2),
      ),
    ];

    return Container(
      margin: margin ?? EdgeInsets.zero,
      decoration: BoxDecoration(
        color: gradient == null ? (backgroundColor ?? Colors.white) : null,
        gradient: gradient,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: defaultBorderColor,
          width: borderWidth,
        ),
        boxShadow: elevation > 0 ? defaultShadow : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius - borderWidth),
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}

/// Variant for cards with hover effects (useful for web/desktop)
class InteractiveAppCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final double radius;
  final VoidCallback? onTap;
  final Color? borderColor;
  final double borderWidth;
  final Color? backgroundColor;

  const InteractiveAppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(12),
    this.margin,
    this.radius = 18,
    this.onTap,
    this.borderColor,
    this.borderWidth = 1,
    this.backgroundColor,
  });

  @override
  State<InteractiveAppCard> createState() => _InteractiveAppCardState();
}

class _InteractiveAppCardState extends State<InteractiveAppCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _elevationAnimation = Tween<double>(begin: 4.0, end: 8.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultBorderColor = widget.borderColor ?? Colors.grey.shade200;

    return GestureDetector(
      onTapDown: widget.onTap != null ? (_) => _controller.forward() : null,
      onTapUp: widget.onTap != null
          ? (_) {
              _controller.reverse();
              widget.onTap?.call();
            }
          : null,
      onTapCancel: widget.onTap != null ? () => _controller.reverse() : null,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              margin: widget.margin ?? EdgeInsets.zero,
              decoration: BoxDecoration(
                color: widget.backgroundColor ?? Colors.white,
                borderRadius: BorderRadius.circular(widget.radius),
                border: Border.all(
                  color: defaultBorderColor,
                  width: widget.borderWidth,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: _elevationAnimation.value,
                    offset: Offset(0, _elevationAnimation.value / 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(widget.radius - widget.borderWidth),
                child: Material(
                  color: Colors.transparent,
                  child: Padding(
                    padding: widget.padding,
                    child: widget.child,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Specialized card variants for common use cases

/// Card with gradient background
class GradientAppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final double radius;
  final Gradient gradient;

  const GradientAppCard({
    super.key,
    required this.child,
    required this.gradient,
    this.padding = const EdgeInsets.all(12),
    this.margin,
    this.radius = 18,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: padding,
      margin: margin,
      radius: radius,
      gradient: gradient,
      borderWidth: 0,
      child: child,
    );
  }
}

/// Card with accent border (useful for highlighting)
class AccentAppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final double radius;
  final Color accentColor;
  final double accentWidth;

  const AccentAppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(12),
    this.margin,
    this.radius = 18,
    this.accentColor = const Color(0xFF3B82F6),
    this.accentWidth = 3,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: padding,
      margin: margin,
      radius: radius,
      borderColor: accentColor,
      borderWidth: accentWidth,
      child: child,
    );
  }
}

/// Card with custom elevation for depth
class ElevatedAppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final double radius;
  final double elevationLevel;

  const ElevatedAppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(12),
    this.margin,
    this.radius = 18,
    this.elevationLevel = 8,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: padding,
      margin: margin,
      radius: radius,
      elevation: elevationLevel,
      customShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: elevationLevel * 2,
          offset: Offset(0, elevationLevel / 2),
        ),
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          blurRadius: elevationLevel,
          offset: Offset(0, elevationLevel / 4),
        ),
      ],
      child: child,
    );
  }
}

/// Card with a colored left border accent
class LeftAccentAppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final double radius;
  final Color accentColor;

  const LeftAccentAppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(12),
    this.margin,
    this.radius = 18,
    this.accentColor = const Color(0xFF3B82F6),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: double.infinity,
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius - 1),
                bottomLeft: Radius.circular(radius - 1),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: padding,
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}