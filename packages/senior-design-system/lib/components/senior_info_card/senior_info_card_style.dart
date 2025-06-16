import 'package:flutter/material.dart';

class SeniorInfoCardStyle {
  /// Style definitions for the SeniorInfoCard component.
  const SeniorInfoCardStyle({
    this.color,
    this.infoColor,
    this.labelColor,
  });

  /// Defines the color of the card.
  final Color? color;

  /// Defines the color of card information.
  final Color? infoColor;

  /// Defines the color of the card's label.
  final Color? labelColor;

  SeniorInfoCardStyle copyWith({
    Color? color,
    Color? infoColor,
    Color? labelColor,
  }) {
    return SeniorInfoCardStyle(
      color: color ?? this.color,
      infoColor: infoColor ?? this.infoColor,
      labelColor: labelColor ?? this.labelColor,
    );
  }
}
