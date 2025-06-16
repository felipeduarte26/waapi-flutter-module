import 'package:flutter/material.dart';

class SeniorCarouselSliderStyle {
  /// Style definitions for the Senior Carousel Slider component.
  const SeniorCarouselSliderStyle({
    this.activeDotColor,
    this.backgroundImageColor,
    this.defaultDotColor,
    this.deleteOptionBorderColor,
    this.deleteOptionColor,
    this.deleteOptionIconColor,
    this.emptyAreaColor,
    this.emptyBorderColor,
    this.emptyLabelColor,
    this.pageInfoColor,
    this.pictureBorderColor,
    this.pictureShadowColor,
  });

  /// Defines the color of the active dot that represents the image being displayed.
  final Color? activeDotColor;

  /// Defines the background color of the images.
  final Color? backgroundImageColor;

  /// Defines the color of the dot that represent the images.
  final Color? defaultDotColor;

  /// Defines the border color of delete option button.
  final Color? deleteOptionBorderColor;

  /// Defines the color of delete option button.
  final Color? deleteOptionColor;

  /// Defines the icon color of delete option button.
  final Color? deleteOptionIconColor;

  /// Defines the color of empty color;
  final Color? emptyAreaColor;

  /// Defines the border color of the empty state.
  final Color? emptyBorderColor;

  /// Defines the label color of the empty state.
  final Color? emptyLabelColor;

  /// Defines the page information color.
  final Color? pageInfoColor;

  /// Defines the border color of images.
  final Color? pictureBorderColor;

  /// Defines the shadow color of the images.
  final Color? pictureShadowColor;

  /// Creates a new instance of [SeniorCarouselSliderStyle] with the option to override specific properties.
  SeniorCarouselSliderStyle copyWith({
    Color? activeDotColor,
    Color? backgroundImageColor,
    Color? defaultDotColor,
    Color? deleteOptionBorderColor,
    Color? deleteOptionColor,
    Color? deleteOptionIconColor,
    Color? emptyAreaColor,
    Color? emptyBorderColor,
    Color? emptyLabelColor,
    Color? pageInfoColor,
    Color? pictureBorderColor,
    Color? pictureShadowColor,
  }) {
    return SeniorCarouselSliderStyle(
      activeDotColor: activeDotColor ?? this.activeDotColor,
      backgroundImageColor: backgroundImageColor ?? this.backgroundImageColor,
      defaultDotColor: defaultDotColor ?? this.defaultDotColor,
      deleteOptionBorderColor: deleteOptionBorderColor ?? this.deleteOptionBorderColor,
      deleteOptionColor: deleteOptionColor ?? this.deleteOptionColor,
      deleteOptionIconColor: deleteOptionIconColor ?? this.deleteOptionIconColor,
      emptyAreaColor: emptyAreaColor ?? this.emptyAreaColor,
      emptyBorderColor: emptyBorderColor ?? this.emptyBorderColor,
      emptyLabelColor: emptyLabelColor ?? this.emptyLabelColor,
      pageInfoColor: pageInfoColor ?? this.pageInfoColor,
      pictureBorderColor: pictureBorderColor ?? this.pictureBorderColor,
      pictureShadowColor: pictureShadowColor ?? this.pictureShadowColor,
    );
  }
}
