import './senior_text_style.dart';

class SeniorTextThemeData {
  /// Theme definitions for the SeniorText component.
  const SeniorTextThemeData({
    this.h1Style,
    this.h2Style,
    this.h3Style,
    this.h4Style,
    this.ctaStyle,
    this.labelStyle,
    this.labelBoldStyle,
    this.bodyStyle,
    this.bodyBoldStyle,
    this.smallStyle,
    this.smallBoldStyle,
    this.smallLinkStyle,
  });

  /// Style definitions for the h1 fonts.
  /// Allows you to configure:
  /// [SeniorTextStyle.color] Defines the font color default.
  /// [SeniorTextStyle.emphasisColor] Defines the font color when in emphasis.
  final SeniorTextStyle? h1Style;

  /// Style definitions for the h2 fonts.
  /// Allows you to configure:
  /// [SeniorTextStyle.color] Defines the font color default.
  /// [SeniorTextStyle.emphasisColor] Defines the font color when in emphasis.
  final SeniorTextStyle? h2Style;

  /// Style definitions for the h3 fonts.
  /// Allows you to configure:
  /// [SeniorTextStyle.color] Defines the font color default.
  /// [SeniorTextStyle.emphasisColor] Defines the font color when in emphasis.
  final SeniorTextStyle? h3Style;

  /// Style definitions for the h4 fonts.
  /// Allows you to configure:
  /// [SeniorTextStyle.color] Defines the font color default.
  /// [SeniorTextStyle.emphasisColor] Defines the font color when in emphasis.
  final SeniorTextStyle? h4Style;

  /// Style definitions for the cta fonts.
  /// Allows you to configure:
  /// [SeniorTextStyle.color] Defines the font color default.
  /// [SeniorTextStyle.emphasisColor] Defines the font color when in emphasis.
  final SeniorTextStyle? ctaStyle;

  /// Style definitions for the label fonts.
  /// Allows you to configure:
  /// [SeniorTextStyle.color] Defines the font color default.
  /// [SeniorTextStyle.emphasisColor] Defines the font color when in emphasis.
  final SeniorTextStyle? labelStyle;

  /// Style definitions for the labelBold fonts.
  /// Allows you to configure:
  /// [SeniorTextStyle.color] Defines the font color default.
  /// [SeniorTextStyle.emphasisColor] Defines the font color when in emphasis.
  final SeniorTextStyle? labelBoldStyle;

  /// Style definitions for the body fonts.
  /// Allows you to configure:
  /// [SeniorTextStyle.color] Defines the font color default.
  /// [SeniorTextStyle.emphasisColor] Defines the font color when in emphasis.
  final SeniorTextStyle? bodyStyle;

  /// Style definitions for the bodyBold fonts.
  /// Allows you to configure:
  /// [SeniorTextStyle.color] Defines the font color default.
  /// [SeniorTextStyle.emphasisColor] Defines the font color when in emphasis.
  final SeniorTextStyle? bodyBoldStyle;

  /// Style definitions for the small fonts.
  /// Allows you to configure:
  /// [SeniorTextStyle.color] Defines the font color default.
  /// [SeniorTextStyle.emphasisColor] Defines the font color when in emphasis.
  final SeniorTextStyle? smallStyle;

  /// Style definitions for the smallBold fonts.
  /// Allows you to configure:
  /// [SeniorTextStyle.color] Defines the font color default.
  /// [SeniorTextStyle.emphasisColor] Defines the font color when in emphasis.
  final SeniorTextStyle? smallBoldStyle;

  /// Style definitions for the smallLink fonts.
  /// Allows you to configure:
  /// [SeniorTextStyle.color] Defines the font color default.
  /// [SeniorTextStyle.emphasisColor] Defines the font color when in emphasis.
  final SeniorTextStyle? smallLinkStyle;

  SeniorTextThemeData copyWith({
    SeniorTextStyle? h1Style,
    SeniorTextStyle? h2Style,
    SeniorTextStyle? h3Style,
    SeniorTextStyle? h4Style,
    SeniorTextStyle? ctaStyle,
    SeniorTextStyle? labelStyle,
    SeniorTextStyle? labelBoldStyle,
    SeniorTextStyle? bodyStyle,
    SeniorTextStyle? bodyBoldStyle,
    SeniorTextStyle? smallStyle,
    SeniorTextStyle? smallBoldStyle,
    SeniorTextStyle? smallLinkStyle,
  }) {
    return SeniorTextThemeData(
      h1Style: h1Style ?? this.h1Style,
      h2Style: h2Style ?? this.h2Style,
      h3Style: h3Style ?? this.h3Style,
      h4Style: h4Style ?? this.h4Style,
      ctaStyle: ctaStyle ?? this.ctaStyle,
      labelStyle: labelStyle ?? this.labelStyle,
      labelBoldStyle: labelBoldStyle ?? this.labelBoldStyle,
      bodyStyle: bodyStyle ?? this.bodyStyle,
      bodyBoldStyle: bodyBoldStyle ?? this.bodyBoldStyle,
      smallStyle: smallStyle ?? this.smallStyle,
      smallBoldStyle: smallBoldStyle ?? this.smallBoldStyle,
      smallLinkStyle: smallLinkStyle ?? this.smallLinkStyle,
    );
  }
}
