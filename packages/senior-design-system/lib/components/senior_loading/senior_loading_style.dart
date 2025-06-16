import 'package:flutter/material.dart';

class SeniorLoadingStyle {
  /// Style definitions for the SeniorLoading component.
  const SeniorLoadingStyle({
    this.color,
  });

  /// Defines the color of the circular progress indicator.
  final Color? color;

  SeniorLoadingStyle copyWith({
    Color? color,
  }) {
    return SeniorLoadingStyle(
      color: color ?? this.color,
    );
  }
}
