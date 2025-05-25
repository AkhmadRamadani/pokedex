import 'package:flutter/material.dart';

extension ColorExtension on Color {
  bool get isColorDark {
    return computeLuminance() < 0.5;
  }

  Color withAlphaFromOpacity(double opacity) {
    assert(
      opacity >= 0.0 && opacity <= 1.0,
      'Opacity must be between 0.0 and 1.0',
    );
    return withAlpha((opacity * 255).round());
  }
}
