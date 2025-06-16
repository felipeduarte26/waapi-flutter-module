import 'senior_carousel_slider.dart';

class SeniorCarouselSliderThemeData {
  /// Theme definitions for the Senior Carousel Slider component.
  const SeniorCarouselSliderThemeData({
    this.style,
  });

  /// The component's style definitions.
  /// Allows you to configure:
  /// [SeniorCarouselSliderStyle.activeDotColor] the color of the active dot that represents the image being displayed.
  /// [SeniorCarouselSliderStyle.backgroundImageColor] the background color of the images.
  /// [SeniorCarouselSliderStyle.defaultDotColor] the color of the dots that represent the images.
  /// [SeniorCarouselSliderStyle.deleteOptionBorderColor] the border color of delete option button.
  /// [SeniorCarouselSliderStyle.deleteOptionColor] the color of delete option button.
  /// [SeniorCarouselSliderStyle.deleteOptionIconColor] the icon color of delete option button.
  /// [SeniorCarouselSliderStyle.emptyAreaColor] the color of empty area.
  /// [SeniorCarouselSliderStyle.emptyBorderColor] the border color of the empty state.
  /// [SeniorCarouselSliderStyle.emptyLabelColor] the label color of the empty state.
  /// [SeniorCarouselSliderStyle.pageInfoColor] the color of the page information.
  /// [SeniorCarouselSliderStyle.pictureBorderColor] the border color of the images.
  /// [SeniorCarouselSliderStyle.pictureShadowColor] the shadow color of the images.
  final SeniorCarouselSliderStyle? style;

  /// Creates a new instance of [SeniorCarouselSliderThemeData] with the option to override specific properties.
  SeniorCarouselSliderThemeData copyWith({
    SeniorCarouselSliderStyle? style,
  }) {
    return SeniorCarouselSliderThemeData(
      style: style ?? this.style,
    );
  }
}
