import './senior_image_cropper_style.dart';

class SeniorImageCropperThemeData {
  /// Theme definitions for the SeniorImageCropper component.
  const SeniorImageCropperThemeData({
    this.style,
  });

  /// The component's style definitions.
  /// Allows you to configure?
  /// [SeniorImageCropperStyle.toolbarColor] the toolbar color of the crop view.
  /// [SeniorImageCropperStyle.toolbarContentColor] the toolbar content color of the crop view.
  /// [SeniorImageCropperStyle.activeControlsColor] the color of the active controls of the crop view.
  final SeniorImageCropperStyle? style;

  SeniorImageCropperThemeData copyWith({
    SeniorImageCropperStyle? style,
  }) {
    return SeniorImageCropperThemeData(
      style: style ?? this.style,
    );
  }
}
