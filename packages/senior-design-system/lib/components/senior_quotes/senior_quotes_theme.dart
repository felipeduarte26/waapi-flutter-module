import './senior_quotes.dart';

class SeniorQuotesThemeData {
  /// Theme definitions for the Senior Quotes component.
  const SeniorQuotesThemeData({
    this.style,
  });

  /// The component's style definitions.
  /// Allows you to configure:
  /// [SeniorQuotesStyle.backgroundColor] the component's background color.
  /// [SeniorQuotesStyle.textColor] the text color in the component.
  final SeniorQuotesStyle? style;

  SeniorQuotesThemeData copyWith({
    SeniorQuotesStyle? style,
  }) {
    return SeniorQuotesThemeData(
      style: style ?? this.style,
    );
  }
}
