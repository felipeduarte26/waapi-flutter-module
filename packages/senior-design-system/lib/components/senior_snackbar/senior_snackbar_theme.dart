import './senior_snackbar_style.dart';

class SeniorSnackbarThemeData {
  /// Theme definitions for the SeniorSnackbar component.
  const SeniorSnackbarThemeData({
    this.style,
  });

  /// Component style definitions.
  /// Allows you to configure:
  /// [SeniorSnackbarStyle.backgroundColor] the background color of the snackbar.
  /// [SeniorSnackbarStyle.fontColor] the color of the snackbar font.
  /// [SeniorSnackbarStyle.iconColor] the color of the snackbar font.
  final SeniorSnackbarStyle? style;

  SeniorSnackbarThemeData copyWith({
    SeniorSnackbarStyle? style,
  }) {
    return SeniorSnackbarThemeData(
      style: style ?? this.style,
    );
  }
}
