import './senior_modal_style.dart';

class SeniorModalThemeData {
  /// Theme definitions for the SeniorModal component.
  const SeniorModalThemeData({
    this.style,
  });

  /// The component's style definitions.
  ///
  /// Allows you to configure:
  /// [SeniorModalStyle.backgroundColor] the background color of the modal.
  final SeniorModalStyle? style;

  SeniorModalThemeData copyWith({
    SeniorModalStyle? style,
  }) {
    return SeniorModalThemeData(
      style: style ?? this.style,
    );
  }
}
