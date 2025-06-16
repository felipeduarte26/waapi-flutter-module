import 'package:flutter/material.dart';

class SeniorContactBookItemStyle {
  /// Style definitions for the SeniorContactBookItem component.
  const SeniorContactBookItemStyle({
    this.titleColor,
    this.itemsColor,
  });

  /// Defines the item's title color.
  final Color? titleColor;

  /// Defines the color of the item's contents.
  final Color? itemsColor;

  SeniorContactBookItemStyle copyWith({
    Color? titleColor,
    Color? itemsColor,
  }) {
    return SeniorContactBookItemStyle(
      titleColor: titleColor ?? this.titleColor,
      itemsColor: itemsColor ?? this.itemsColor,
    );
  }
}
