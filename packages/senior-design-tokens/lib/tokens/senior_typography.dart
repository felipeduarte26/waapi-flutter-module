import 'package:flutter/material.dart';

final String package = 'senior_design_tokens';

class SeniorTypography {
  SeniorTypography._();

  /// Fonte h1
  /// Font family: Urbanist
  /// Font size: 40
  /// Font weight: 700
  /// Height: 120%
  static TextStyle h1({Color? color}) {
    return TextStyle(
      color: color,
      fontFamily: 'Urbanist',
      fontSize: 40.0,
      fontWeight: FontWeight.w700,
      height: 1.2,
      package: package,
    );
  }

  /// Fonte h2
  /// Font family: Urbanist
  /// Font size: 32
  /// Font weight: 600
  /// Height: 125%
  static TextStyle h2({Color? color}) {
    return TextStyle(
      color: color,
      fontFamily: 'Urbanist',
      fontSize: 32.0,
      fontWeight: FontWeight.w600,
      height: 1.25,
      package: package,
    );
  }

  /// Fonte h3
  /// Font family: Urbanist
  /// Font size: 24
  /// Font weight: 500
  /// Height: 133,33%
  static TextStyle h3({Color? color}) {
    return TextStyle(
      color: color,
      fontFamily: 'Urbanist',
      fontWeight: FontWeight.w500,
      fontSize: 24.0,
      height: 1.3333,
      package: package,
    );
  }

  /// Fonte h4
  /// Font family: Urbanist
  /// Font size: 20
  /// Font weight: 500
  /// Height: 160%
  static TextStyle h4({Color? color}) {
    return TextStyle(
      color: color,
      fontFamily: 'Urbanist',
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
      height: 1.6,
      package: package,
    );
  }

  /// Fonte CTA
  /// Font family: Urbanist
  /// Font size: 18
  /// Font weight: 700
  /// Height: 160%
  static TextStyle cta({Color? color}) {
    return TextStyle(
      color: color,
      fontFamily: 'Urbanist',
      fontSize: 18.0,
      fontWeight: FontWeight.w700,
      height: 1.6,
      package: package,
    );
  }

  /// Font Label
  /// Font family: Urbanist
  /// Font size: 16
  /// Font weight: 400
  /// Height: 150%
  static TextStyle label({Color? color}) {
    return TextStyle(
      color: color,
      fontFamily: 'Urbanist',
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      height: 1.5,
      package: package,
    );
  }

  /// Font Label bold
  /// Font family: Urbanist
  /// Font size: 16
  /// Font weight: 700
  /// Height: 150%
  static TextStyle labelBold({Color? color}) {
    return TextStyle(
      color: color,
      fontFamily: 'Urbanist',
      fontSize: 16.0,
      fontWeight: FontWeight.w700,
      height: 1.5,
      package: package,
    );
  }

  /// Fonte body
  /// Font family: Urbanist
  /// Font size: 14
  /// Font weight: 400
  /// Height: 142,857%
  static TextStyle body({Color? color}) {
    return TextStyle(
      color: color,
      fontFamily: 'Urbanist',
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      height: 1.42857,
      package: package,
    );
  }

  /// Font Body Bold
  /// Font family: Urbanist
  /// Font size: 14
  /// Font weight: 700
  /// Height: 142,857%
  static TextStyle bodyBold({Color? color}) {
    return TextStyle(
      color: color,
      fontFamily: 'Urbanist',
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      height: 1.42857,
      package: package,
    );
  }

  /// Fonte small
  /// Font family: Urbanist
  /// Font size: 12
  /// Font weight: 400
  /// Height: 133,33%
  static TextStyle small({Color? color}) {
    return TextStyle(
      color: color,
      fontFamily: 'Urbanist',
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
      height: 1.3333,
      package: package,
    );
  }

  /// Fonte small-bold
  /// Font family: Urbanist
  /// Font size: 12
  /// Font weight: bold
  /// Height: 133,33%
  static TextStyle smallBold({Color? color}) {
    return TextStyle(
      color: color,
      fontFamily: 'Urbanist',
      fontSize: 12.0,
      fontWeight: FontWeight.bold,
      height: 1.3333,
      package: package,
    );
  }

  /// Font Small Link
  /// Font family: Urbanist
  /// Font size: 12
  /// Font weight: Small Link
  /// Height: 133,33%
  static TextStyle smallLink({Color? color}) {
    return TextStyle(
      color: color,
      fontFamily: 'Urbanist',
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
      height: 1.3333,
      package: package,
    );
  }

  /// Fonte title
  /// Font family: Urbanist
  /// Font size: 16
  /// Font weight: 500
  /// Height: 150%
  @Deprecated('Use label instead')
  static TextStyle title({Color? color}) {
    return TextStyle(
      color: color,
      fontFamily: 'Urbanist',
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      height: 1.5,
      package: package,
    );
  }

  /// Fonte title-card-regular
  /// Font family: Urbanist
  /// Font size: 16
  /// Font weight: normal
  /// Height: 150%
  @Deprecated('Use label instead')
  static TextStyle titleCardRegular({Color? color}) {
    return TextStyle(
      color: color,
      fontFamily: 'Urbanist',
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      height: 1.5,
      package: package,
    );
  }

  /// Fonte text
  /// Font family: Urbanist
  /// Font size: 16
  /// Font weight: 400
  /// Height: 150%
  @Deprecated('Use label instead')
  static TextStyle text({Color? color}) {
    return TextStyle(
      color: color,
      fontFamily: 'Urbanist',
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      height: 1.5,
      package: package,
    );
  }

  /// Fonte body-semi-bold
  /// Font family: Urbanist
  /// Font size: 14
  /// Font weight: 600
  /// Height: 142,857%
  @Deprecated('Use bodyBold instead')
  static TextStyle bodySemiBold({Color? color}) {
    return TextStyle(
      color: color,
      fontFamily: 'Urbanist',
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
      height: 1.42857,
      package: package,
    );
  }

  /// Fonte helper
  /// Font family: Urbanist
  /// Font size: 12
  /// Font weight: 400
  /// Height: 133,33%
  @Deprecated('Use small instead')
  static TextStyle helper({Color? color}) {
    return TextStyle(
      color: color,
      fontFamily: 'Urbanist',
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
      height: 1.3333,
      package: package,
    );
  }

  /// Fonte tiny
  /// Font family: Urbanist
  /// Font size: 10
  /// Font weight: 500
  /// Height: 120%
  @Deprecated('Use small instead')
  static TextStyle tiny({Color? color}) {
    return TextStyle(
      color: color,
      fontFamily: 'Urbanist',
      fontSize: 10.0,
      fontWeight: FontWeight.w500,
      height: 1.2,
      package: package,
    );
  }

  /// Fonte title-card-bold
  /// Font family: Urbanist
  /// Font size: 16
  /// Font weight: bold
  /// Height: 150%
  @Deprecated('Use small instead')
  static TextStyle titleCardBold({Color? color}) {
    return TextStyle(
      color: color,
      fontFamily: 'Urbanist',
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      height: 1.5,
      package: package,
    );
  }
}

@Deprecated('Use SeniorIconSize instead')
class SeniorTypographyIconSize {
  SeniorTypographyIconSize._();

  /// This icon size is represented by 40 pixels.
  static const double h1 = 40.0;

  /// This icon size is represented by 32 pixels.
  static const double h2 = 32.0;

  /// This icon size is represented by 24 pixels.
  static const double h3 = 24.0;

  /// This icon size is represented by 20 pixels.
  static const double h4 = 20.0;

  /// This icon size is represented by 18 pixels.
  static const double CTA = 18.0;

  /// This icon size is represented by 16 pixels.
  static const double title = 16.0;

  /// This icon size is represented by 16 pixels.
  static const double text = 16.0;

  /// This icon size is represented by 14 pixels.
  static const double body = 14.0;

  /// This icon size is represented by 12 pixels.
  static const double small = 12.0;

  /// This icon size is represented by 12 pixels.
  static const double helper = 12.0;

  /// This icon size is represented by 10 pixels.
  static const double tiny = 10.0;
}
