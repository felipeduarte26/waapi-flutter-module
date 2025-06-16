import './senior_contact_book_item.dart';

class SeniorContactBookItemThemeData {
  /// Theme definitions for the SeniorContactBookItem component.
  const SeniorContactBookItemThemeData({
    this.style,
  });

  /// Component style definitions.
  /// Allows you to configure:
  /// [SeniorContactBookItemStyle.titleColor] the color of the item's title.
  /// [SeniorContactBookItemStyle.itemsColor] the color of the item's contents.
  final SeniorContactBookItemStyle? style;

  SeniorContactBookItemThemeData copyWith({
    SeniorContactBookItemStyle? style,
  }) {
    return SeniorContactBookItemThemeData(
      style: style ?? this.style,
    );
  }
}
