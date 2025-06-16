import './senior_info_card_style.dart';

class SeniorInfoCardThemeData {
  /// Theme definitions for the SeniorInfoCard component.
  const SeniorInfoCardThemeData({
    this.style,
  });

  /// Component style definitions.
  /// Allows you to configure:
  /// [SeniorInfoCardStyle.color] the color of the card.
  /// [SeniorInfoCardStyle.infoColor] the color of the card information.
  /// [SeniorInfoCardStyle.labelColor] the color of the card label.
  final SeniorInfoCardStyle? style;

  SeniorInfoCardThemeData copyWith({
    SeniorInfoCardStyle? style,
  }) {
    return SeniorInfoCardThemeData(
      style: style ?? this.style,
    );
  }
}
