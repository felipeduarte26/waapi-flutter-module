import 'package:flutter/material.dart';
import './senior_message_card_style.dart';

class SeniorMessageCardThemeData {
  /// Theme definitions for the SeniorMessageCard component.
  const SeniorMessageCardThemeData({
    this.padding,
    this.style,
  });

  /// Component style definitions.
  /// Allows you to configure:
  /// [SeniorMessageCardStyle.color] the color of the card.
  /// [SeniorMessageCardStyle.feedbackItemsColor] the color of the card's feedback items.
  /// [SeniorMessageCardStyle.textColor] the color of the card's text.
  final SeniorMessageCardStyle? style;

  /// Defines the card's padding.
  final EdgeInsetsGeometry? padding;

  SeniorMessageCardThemeData copyWith({
    EdgeInsetsGeometry? padding,
    SeniorMessageCardStyle? style,
  }) {
    return SeniorMessageCardThemeData(
      padding: padding ?? this.padding,
      style: style ?? this.style,
    );
  }
}
