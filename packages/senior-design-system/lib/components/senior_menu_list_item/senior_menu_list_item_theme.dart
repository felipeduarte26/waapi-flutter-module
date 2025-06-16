import './senior_menu_list_item.dart';

class SeniorMenuListItemThemeData {
  /// Theme definitions for the SeniorMenuListItem component.
  const SeniorMenuListItemThemeData({
    this.style,
  });

  /// Component style definitions.
  /// Allows you to configure:
  /// [SeniorMenuListItemStyle.iconColor] the color of the item's icon.
  /// [SeniorMenuListItemStyle.pushIconColor] the color of the item's action icon.
  /// [SeniorMenuListItemStyle.disabledPushIconColor] the color of the item's action icon when disabled.
  /// [SeniorMenuListItemStyle.subtitleColor] the item's subtitle color.
  /// [SeniorMenuListItemStyle.titleColor] the color of the item's title.
  final SeniorMenuListItemStyle? style;

  SeniorMenuListItemThemeData copyWith({
    SeniorMenuListItemStyle? style,
  }) {
    return SeniorMenuListItemThemeData(
      style: style ?? this.style,
    );
  }
}
