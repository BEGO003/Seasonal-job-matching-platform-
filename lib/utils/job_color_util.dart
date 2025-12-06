import 'package:flutter/material.dart';

class JobColorUtil {
  static const List<Color> _accentColors = [
    Color(0xFF4E60FF), // Blue
    Color(0xFFFF5C8D), // Pink
    Color(0xFFFF9900), // Orange
    Color(0xFF00C9A7), // Teal
    Color(0xFF845EF7), // Purple
  ];

  static Color getJobColor(int jobId, String title) {
    final int hash = (jobId.hashCode + title.hashCode).abs();
    return _accentColors[hash % _accentColors.length];
  }
}
