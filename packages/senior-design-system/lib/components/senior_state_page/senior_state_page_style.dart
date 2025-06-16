import 'package:flutter/material.dart';

class SeniorStatePageStyle {
  /// Style definitions for the SeniorStatePage component.
  const SeniorStatePageStyle({
    this.titleColor,
    this.subtitleColor,
  });

  /// Defines the page title color.
  final Color? titleColor;

  /// Defines the color of the page's subtitle.
  final Color? subtitleColor;

  SeniorStatePageStyle copyWith({
    Color? titleColor,
    Color? subtitleColor,
  }) {
    return SeniorStatePageStyle(
      titleColor: titleColor ?? this.titleColor,
      subtitleColor: subtitleColor ?? this.subtitleColor,
    );
  }
}
