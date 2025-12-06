import 'package:flutter/material.dart';
import 'package:job_seeker/theme/app_theme.dart';

enum StatusType { success, warning, error, info, neutral }

class StatusBadge extends StatelessWidget {
  final String status;
  final StatusType type;
  final bool compact;

  const StatusBadge({
    super.key,
    required this.status,
    this.type = StatusType.neutral,
    this.compact = false,
  });

  Color _getColor(ColorScheme colorScheme) {
    switch (type) {
      case StatusType.success:
        return Colors.green;
      case StatusType.warning:
        return Colors.amber.shade700;
      case StatusType.error:
        return colorScheme.error;
      case StatusType.info:
        return colorScheme.primary;
      case StatusType.neutral:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final color = _getColor(colorScheme);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 8 : 12,
        vertical: compact ? 4 : 6,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(
          compact ? AppTheme.radiusSm : AppTheme.radiusMd,
        ),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Text(
        status,
        style: theme.textTheme.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: compact ? 11 : 12,
        ),
      ),
    );
  }
}
