import 'package:flutter/material.dart';

class SeniorMenuListItemStyle {
  /// Style definitions for the SeniorMenuListItem component.
  const SeniorMenuListItemStyle({
    this.iconColor,
    this.disabledPushIconColor,
    this.pushIconColor,
    this.subtitleColor,
    this.titleColor,
  });

  /// Defines the item icon color.
  final Color? iconColor;

  /// Defines the color of the item's action icon.
  final Color? pushIconColor;

  /// Defines the color of the item's action icon when disabled.
  final Color? disabledPushIconColor;

  /// Defines the item's subtitle color.
  final Color? subtitleColor;

  /// Defines the item's title color.
  final Color? titleColor;

  SeniorMenuListItemStyle copyWith({
    Color? iconColor,
    Color? disabledPushIconColor,
    Color? pushIconColor,
    Color? subtitleColor,
    Color? titleColor,
  }) {
    return SeniorMenuListItemStyle(
      iconColor: iconColor ?? this.iconColor,
      disabledPushIconColor: disabledPushIconColor ?? this.disabledPushIconColor,
      pushIconColor: pushIconColor ?? this.pushIconColor,
      subtitleColor: subtitleColor ?? this.subtitleColor,
      titleColor: titleColor ?? this.titleColor,
    );
  }
}
