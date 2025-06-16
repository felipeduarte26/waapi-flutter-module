import './senior_progress_bar_style.dart';

class SeniorProgressBarThemeData {
  /// Theme definitions for the SeniorProgressBar component.
  const SeniorProgressBarThemeData({
    this.style,
  });

  /// Component style definitions.
  /// Allows you to configure:
  /// [SeniorProgressBarStyle.backgroundColor] the background color of the scrollbar.
  /// [SeniorProgressBarStyle.color] the color of the current scrollbar level.
  /// [SeniorProgressBarStyle.progressInfoColor] the color of the current progress information.
  /// [SeniorProgressBarStyle.subtitleColor] the color of the subtitle shown in the component.
  /// [SeniorProgressBarStyle.titleColor] the color of the title shown on the component.
  final SeniorProgressBarStyle? style;

  SeniorProgressBarThemeData copyWith({
    SeniorProgressBarStyle? style,
  }) {
    return SeniorProgressBarThemeData(
      style: style ?? this.style,
    );
  }
}
