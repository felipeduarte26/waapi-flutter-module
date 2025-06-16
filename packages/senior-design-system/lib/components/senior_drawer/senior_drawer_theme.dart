import './senior_drawer_style.dart';

class SeniorDrawerThemeData {
  /// Theme definitions for the SeniorDrawer component.
  const SeniorDrawerThemeData({
    this.style,
  });

  /// Style definitions for the component.
  /// Allows you to configure:
  /// [SeniorDrawerStyle.backgroundColor] the background color of the drawer.
  /// [SeniorDrawerStyle.backIconColor] the color of the drawer back icon.
  /// [SeniorDrawerStyle.boldItemColor] the color of items of bold type.
  /// [SeniorDrawerStyle.emphasisItemColor] the color of items of emphasis type.
  /// [SeniorDrawerStyle.footerTextColor] the color of the text in the footer.
  /// [SeniorDrawerStyle.lineColor] the color of the line that separates the profile area and the items list.
  /// [SeniorDrawerStyle.neutralItemColor] the color of items of neutral type.
  /// [SeniorDrawerStyle.profileSubtitleColor] the profile subtitle color.
  /// [SeniorDrawerStyle.profileTitleColor] the profile title color.
  final SeniorDrawerStyle? style;

  SeniorDrawerThemeData copyWith({
    SeniorDrawerStyle? style,
  }) {
    return SeniorDrawerThemeData(
      style: style ?? this.style,
    );
  }
}
