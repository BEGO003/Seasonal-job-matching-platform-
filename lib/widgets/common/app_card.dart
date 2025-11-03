import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final double elevation;
  final Color? backgroundColor;
  final bool showBorder;
  final VoidCallback? onTap;
  final bool interactive;

  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin,
    this.borderRadius = 12,
    this.elevation = 1,
    this.backgroundColor,
    this.showBorder = true,
    this.onTap,
    this.interactive = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    // Adaptive colors for light/dark theme
    final cardColor = backgroundColor ?? theme.cardColor;
    final borderColor = isDark 
        ? Colors.grey[700]!.withOpacity(0.3)
        : Colors.grey[200]!;
    
    final shadowColor = isDark
        ? Colors.black.withOpacity(0.25)
        : Colors.black.withOpacity(0.06);

    return Container(
      margin: margin ?? const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Material(
        type: MaterialType.card,
        borderRadius: BorderRadius.circular(borderRadius),
        color: cardColor,
        elevation: elevation,
        shadowColor: shadowColor,
        surfaceTintColor: theme.colorScheme.surfaceTint,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            border: showBorder 
                ? Border.all(
                    color: borderColor,
                    width: 1.0,
                  )
                : null,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: Stack(
              children: [
                // Main content
                Padding(
                  padding: padding,
                  child: child,
                ),
                
                // Interactive overlay
                if (interactive || onTap != null)
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(borderRadius),
                        onTap: onTap,
                        splashColor: theme.colorScheme.primary.withOpacity(0.12),
                        highlightColor: theme.colorScheme.primary.withOpacity(0.08),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}