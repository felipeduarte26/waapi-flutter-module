import './senior_profile_picture_style.dart';

class SeniorProfilePictureThemeData {
  /// Theme definitions for the SeniorProfilePicture component.
  const SeniorProfilePictureThemeData({
    this.style,
  });

  /// The component's style definitions.
  ///
  /// Allows you to configure:
  /// [SeniorProfilePictureStyle.backgroundColor] the background color of the profile picture.
  /// [SeniorProfilePictureStyle.loadingOverlappingdColor] the overlay color when the component is loading.
  /// [SeniorProfilePictureStyle.textColor] the text color of the profile picture.
  final SeniorProfilePictureStyle? style;

  SeniorProfilePictureThemeData copyWith({
    SeniorProfilePictureStyle? style,
  }) {
    return SeniorProfilePictureThemeData(
      style: style ?? this.style,
    );
  }
}
