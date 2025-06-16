import './senior_bottom_sheet_style.dart';

class SeniorBottomSheetThemeData {
  /// Theme definitions for the [SeniorBottomSheet] component.
  const SeniorBottomSheetThemeData({
    this.style,
  });

  /// The component's style definitions.
  ///
  /// Allows you to configure:
  /// [SeniorBottomSheetStyle.backgroundColor] the background color of the bottom sheet.
  /// [SeniorBottomSheetStyle.closeButtonColor] the color of the bottom sheet close button icon.
  /// [SeniorBottomSheetStyle.titleColor] the title color of the bottom sheet.
  final SeniorBottomSheetStyle? style;

  /// Creates a copy of this [SeniorBottomSheetThemeData] but with
  /// the given fields replaced with the new values.
  SeniorBottomSheetThemeData copyWith({
    SeniorBottomSheetStyle? style,
  }) {
    return SeniorBottomSheetThemeData(
      style: style ?? this.style,
    );
  }
}