import 'package:flutter/material.dart';

/// A beautiful shimmer loading effect for skeleton screens
/// Use this instead of CircularProgressIndicator for more elegant loading states
class ShimmerLoading extends StatefulWidget {
  final double width;
  final double height;
  final double borderRadius;
  final ShimmerShape shape;
  final Color? baseColor;
  final Color? highlightColor;

  const ShimmerLoading({
    super.key,
    this.width = double.infinity,
    this.height = 20,
    this.borderRadius = 8,
    this.shape = ShimmerShape.rectangle,
    this.baseColor,
    this.highlightColor,
  });

  /// Creates a card-shaped shimmer placeholder
  const ShimmerLoading.card({
    super.key,
    this.width = double.infinity,
    this.height = 120,
    this.borderRadius = 16,
    this.baseColor,
    this.highlightColor,
  }) : shape = ShimmerShape.rectangle;

  /// Creates a circular shimmer placeholder (for avatars)
  const ShimmerLoading.circle({
    super.key,
    required double size,
    this.baseColor,
    this.highlightColor,
  }) : width = size,
       height = size,
       borderRadius = 999,
       shape = ShimmerShape.circle;

  /// Creates a text-line shimmer placeholder
  const ShimmerLoading.text({
    super.key,
    this.width = 100,
    this.height = 14,
    this.borderRadius = 4,
    this.baseColor,
    this.highlightColor,
  }) : shape = ShimmerShape.rectangle;

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(begin: -2, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final baseColor =
        widget.baseColor ??
        (isDark ? const Color(0xFF2A2A2A) : const Color(0xFFE5E7EB));
    final highlightColor =
        widget.highlightColor ??
        (isDark ? const Color(0xFF3A3A3A) : const Color(0xFFF3F4F6));

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: widget.shape == ShimmerShape.circle
                ? null
                : BorderRadius.circular(widget.borderRadius),
            shape: widget.shape == ShimmerShape.circle
                ? BoxShape.circle
                : BoxShape.rectangle,
            gradient: LinearGradient(
              begin: Alignment(_animation.value - 1, 0),
              end: Alignment(_animation.value + 1, 0),
              colors: [baseColor, highlightColor, baseColor],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        );
      },
    );
  }
}

enum ShimmerShape { rectangle, circle }

/// A preset for job card loading skeleton
class JobCardSkeleton extends StatelessWidget {
  const JobCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const ShimmerLoading.circle(size: 48),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    ShimmerLoading.text(width: 150, height: 16),
                    SizedBox(height: 8),
                    ShimmerLoading.text(width: 100, height: 12),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const ShimmerLoading.text(width: double.infinity, height: 14),
          const SizedBox(height: 8),
          const ShimmerLoading.text(width: 200, height: 14),
          const SizedBox(height: 16),
          Row(
            children: const [
              ShimmerLoading(width: 80, height: 28, borderRadius: 6),
              SizedBox(width: 8),
              ShimmerLoading(width: 80, height: 28, borderRadius: 6),
            ],
          ),
        ],
      ),
    );
  }
}

/// A preset for application card loading skeleton
class ApplicationCardSkeleton extends StatelessWidget {
  const ApplicationCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant.withOpacity(0.3),
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.surfaceContainerHighest.withOpacity(0.3),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(18),
              ),
            ),
            child: Row(
              children: const [
                ShimmerLoading(width: 40, height: 40, borderRadius: 12),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerLoading.text(width: 100, height: 12),
                      SizedBox(height: 6),
                      ShimmerLoading.text(width: 80, height: 14),
                    ],
                  ),
                ),
                ShimmerLoading(width: 60, height: 24, borderRadius: 12),
              ],
            ),
          ),
          // Body
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                ShimmerLoading.text(width: 200, height: 18),
                SizedBox(height: 12),
                ShimmerLoading.text(width: 150, height: 14),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
