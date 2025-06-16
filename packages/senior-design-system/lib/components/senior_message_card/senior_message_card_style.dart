import 'package:flutter/material.dart';

class SeniorMessageCardStyle {
  /// Style definitions for the SeniorMessageCard component.
  const SeniorMessageCardStyle({
    this.color,
    this.feedbackItemsColor,
    this.textColor,
  });

  /// Defines the color of the card.
  final Color? color;

  /// Defines the color of the card's feedback items.
  final Color? feedbackItemsColor;

  /// Defines the color of the card's text.
  final Color? textColor;

  SeniorMessageCardStyle copyWith({
    Color? color,
    Color? feedbackItemsColor,
    Color? textColor,
  }) {
    return SeniorMessageCardStyle(
      color: color ?? this.color,
      feedbackItemsColor: feedbackItemsColor ?? this.feedbackItemsColor,
      textColor: textColor ?? this.textColor,
    );
  }
}
