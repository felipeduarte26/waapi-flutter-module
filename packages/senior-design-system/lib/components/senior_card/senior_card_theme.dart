import './senior_card_style.dart';

class SeniorCardThemeData {
  /// Theme definitions for the SeniorCard component.
  const SeniorCardThemeData({
    this.style,
  });

  /// The component's style definitions.
  /// Allows you to configure:
  /// [SeniorCardStyle.backgroundColor] the background color of the card.
  /// [SeniorCardStyle.backgroundColorIfElevated] the background color of the card when it`s elevated.
  /// [SeniorCardStyle.disabledBackgroundColor] the background color of the card when it`s disabled.
  /// [SeniorCardStyle.iconColor] the color of the card icon.
  /// [SeniorCardStyle.outlinedColor] the color of the card border.
  /// [SeniorCardStyle.quotesColor] the color of quotes characters.
  final SeniorCardStyle? style;

  /// Creates a new instance of [SeniorCardThemeData] with the option to override specific properties.
  SeniorCardThemeData copyWith({
    SeniorCardStyle? style,
  }) {
    return SeniorCardThemeData(
      style: style ?? this.style,
    );
  }
}
