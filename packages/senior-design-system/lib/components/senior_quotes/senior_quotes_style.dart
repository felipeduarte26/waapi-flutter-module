import 'package:flutter/material.dart';

class SeniorQuotesStyle {
  /// Style definitions for the SeniorQuotes component.
  const SeniorQuotesStyle({
    this.backgroundColor,
    this.quotesColor,
    this.textColor,
  });

  /// Defines the component's background color.
  final Color? backgroundColor;

  /// Defines the color of the quotes.
  final Color? quotesColor;

  /// Defines the color of the text.
  final Color? textColor;

  SeniorQuotesStyle copyWith({
    Color? backgroundColor,
    Color? quotesColor,
    Color? textColor,
  }) {
    return SeniorQuotesStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      quotesColor: quotesColor ?? this.quotesColor,
      textColor: textColor ?? this.textColor,
    );
  }
}
