import 'package:flutter/material.dart';

class SeniorIconStyle {
  /// Style definitions for the SeniorIcon component.
  const SeniorIconStyle({
    this.color,
  });

  /// The color of the icon.
  final Color? color;

  SeniorIconStyle copyWith({
    Color? color,
  }) {
    return SeniorIconStyle(
      color: color ?? this.color,
    );
  }
}