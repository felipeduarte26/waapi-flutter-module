import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:senior_design_tokens/senior_design_tokens.dart';

import './utils/typographies.dart';
import './models/text_properties.dart';
import '../../repositories/theme_repository.dart';
import '../../theme/senior_theme_data.dart';

class SeniorText extends StatelessWidget {
  /// Creates a text component.
  ///
  /// The [typography] parameter is required.
  SeniorText(
    this.content, {
    Key? key,
    this.emphasis = false,
    this.color,
    this.darkColor,
    this.style,
    this.textProperties,
    required this.typography,
  }) : super(key: key);

  /// Create a text with h1 font.
  /// The [content] is required.
  factory SeniorText.h1(
    String content, {
    bool? emphasis,
    Key? key,
    Color? color,
    Color? darkColor,
    TextStyle? style,
    TextProperties? textProperties,
  }) = _SeniorTextH1;

  /// Create a text with h2 font.
  /// The [content] is required.
  factory SeniorText.h2(
    String content, {
    bool? emphasis,
    Key? key,
    Color? color,
    Color? darkColor,
    TextStyle? style,
    TextProperties? textProperties,
  }) = _SeniorTextH2;

  /// Create a text with h3 font.
  /// The [content] is required.
  factory SeniorText.h3(
    String content, {
    bool? emphasis,
    Key? key,
    Color? color,
    Color? darkColor,
    TextStyle? style,
    TextProperties? textProperties,
  }) = _SeniorTextH3;

  /// Create a text with h4 font.
  /// The [content] is required.
  factory SeniorText.h4(
    String content, {
    bool? emphasis,
    Key? key,
    Color? color,
    Color? darkColor,
    TextStyle? style,
    TextProperties? textProperties,
  }) = _SeniorTextH4;

  /// Create a text with cta font.
  /// The [content] is required.
  factory SeniorText.cta(
    String content, {
    bool? emphasis,
    Key? key,
    Color? color,
    Color? darkColor,
    TextStyle? style,
    TextProperties? textProperties,
  }) = _SeniorTextCTA;

  /// Create a text with label font.
  /// The [content] is required.
  factory SeniorText.label(
    String content, {
    bool? emphasis,
    Key? key,
    Color? color,
    Color? darkColor,
    TextStyle? style,
    TextProperties? textProperties,
  }) = _SeniorTextLabel;

  /// Create a text with labelBold font.
  /// The [content] is required.
  factory SeniorText.labelBold(
    String content, {
    bool? emphasis,
    Key? key,
    Color? color,
    Color? darkColor,
    TextStyle? style,
    TextProperties? textProperties,
  }) = _SeniorTextLabelBold;

  /// Create a text with body font.
  /// The [content] is required.
  factory SeniorText.body(
    String content, {
    bool? emphasis,
    Key? key,
    Color? color,
    Color? darkColor,
    TextStyle? style,
    TextProperties? textProperties,
  }) = _SeniorTextBody;

  /// Create a text with bodyBold font.
  /// The [content] is required.
  factory SeniorText.bodyBold(
    String content, {
    bool? emphasis,
    Key? key,
    Color? color,
    Color? darkColor,
    TextStyle? style,
    TextProperties? textProperties,
  }) = _SeniorTextBodyBold;

  /// Create a text with small font.
  /// The [content] is required.
  factory SeniorText.small(
    String content, {
    bool? emphasis,
    Key? key,
    Color? color,
    Color? darkColor,
    TextStyle? style,
    TextProperties? textProperties,
  }) = _SeniorTextSmall;

  /// Create a text with smallBold font.
  /// The [content] is required.
  factory SeniorText.smallBold(
    String content, {
    bool? emphasis,
    Key? key,
    Color? color,
    Color? darkColor,
    TextStyle? style,
    TextProperties? textProperties,
  }) = _SeniorTextSmallBold;

  /// Create a text with smallLink font.
  /// The [content] is required.
  factory SeniorText.smallLink(
    String content, {
    bool? emphasis,
    Key? key,
    Color? color,
    Color? darkColor,
    TextStyle? style,
    TextProperties? textProperties,
  }) = _SeniorTextSmallLink;

  /// The text to be displayed.
  final String content;

  /// Whether the font will be in an emphasis state.
  final bool emphasis;

  /// A custom color for the light theme.
  final Color? color;

  /// A custom color for the dark theme.
  final Color? darkColor;

  /// The style of the text that will be displayed.
  final TextStyle? style;

  /// The text properties.
  /// Allows to configure:
  /// [TextProperties.maxLines] An optional maximum number of lines for the text to span, wrapping if necessary. If the text exceeds the given number of lines, it will be truncated according to overflow.
  /// [TextProperties.overflow] How visual overflow should be handled.
  /// [TextProperties.selectionColor] The color to use when painting the selection.
  /// [TextProperties.semanticsLabel] An alternative semantics label for this text.
  /// [TextProperties.softWrap] Whether the text should break at soft line breaks.
  /// [TextProperties.strutStyle] The strut style to use. Strut style defines the strut, which sets minimum vertical layout metrics.
  /// [TextProperties.textAlign] How the text should be aligned horizontally.
  /// [TextProperties.textDirection] The directionality of the text.
  final TextProperties? textProperties;

  /// Which font will be rendered.
  final Typographies typography;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    return Text(
      content,
      key: key,
      maxLines: textProperties?.maxLines,
      overflow: textProperties?.overflow,
      selectionColor: textProperties?.selectionColor,
      semanticsLabel: textProperties?.semanticsLabel,
      softWrap: textProperties?.softWrap,
      strutStyle: textProperties?.strutStyle,
      style: getTextStyle(
        typography,
        emphasis,
        theme: theme,
        color: color,
        darkColor: darkColor,
        style: style,
      ),
      textAlign: textProperties?.textAlign,
      textDirection: textProperties?.textDirection,
    );
  }
}

class _SeniorTextH1 extends SeniorText {
  _SeniorTextH1(
    String content, {
    bool? emphasis,
    Key? key,
    Color? color,
    Color? darkColor,
    TextStyle? style,
    TextProperties? textProperties,
  }) : super(
          content,
          emphasis: emphasis ?? false,
          key: key,
          color: color,
          darkColor: darkColor,
          style: style,
          textProperties: textProperties,
          typography: Typographies.h1,
        );
}

class _SeniorTextH2 extends SeniorText {
  _SeniorTextH2(
    String content, {
    bool? emphasis,
    Key? key,
    Color? color,
    Color? darkColor,
    TextStyle? style,
    TextProperties? textProperties,
  }) : super(
          content,
          emphasis: emphasis ?? false,
          key: key,
          color: color,
          darkColor: darkColor,
          style: style,
          textProperties: textProperties,
          typography: Typographies.h2,
        );
}

class _SeniorTextH3 extends SeniorText {
  _SeniorTextH3(
    String content, {
    bool? emphasis,
    Key? key,
    Color? color,
    Color? darkColor,
    TextStyle? style,
    TextProperties? textProperties,
  }) : super(
          content,
          emphasis: emphasis ?? false,
          key: key,
          color: color,
          darkColor: darkColor,
          style: style,
          typography: Typographies.h3,
          textProperties: textProperties,
        );
}

class _SeniorTextH4 extends SeniorText {
  _SeniorTextH4(
    String content, {
    bool? emphasis,
    Key? key,
    Color? color,
    Color? darkColor,
    TextStyle? style,
    TextProperties? textProperties,
  }) : super(
          content,
          emphasis: emphasis ?? false,
          key: key,
          color: color,
          darkColor: darkColor,
          style: style,
          textProperties: textProperties,
          typography: Typographies.h4,
        );
}

class _SeniorTextCTA extends SeniorText {
  _SeniorTextCTA(
    String content, {
    bool? emphasis,
    Key? key,
    Color? color,
    Color? darkColor,
    TextStyle? style,
    TextProperties? textProperties,
  }) : super(
          content,
          emphasis: emphasis ?? false,
          key: key,
          color: color,
          darkColor: darkColor,
          style: style,
          textProperties: textProperties,
          typography: Typographies.cta,
        );
}

class _SeniorTextLabel extends SeniorText {
  _SeniorTextLabel(
    String content, {
    bool? emphasis,
    Key? key,
    Color? color,
    Color? darkColor,
    TextStyle? style,
    TextProperties? textProperties,
  }) : super(
          content,
          emphasis: emphasis ?? false,
          key: key,
          color: color,
          darkColor: darkColor,
          style: style,
          textProperties: textProperties,
          typography: Typographies.label,
        );
}

class _SeniorTextLabelBold extends SeniorText {
  _SeniorTextLabelBold(
    String content, {
    bool? emphasis,
    Key? key,
    Color? color,
    Color? darkColor,
    TextStyle? style,
    TextProperties? textProperties,
  }) : super(
          content,
          emphasis: emphasis ?? false,
          key: key,
          color: color,
          darkColor: darkColor,
          style: style,
          textProperties: textProperties,
          typography: Typographies.labelBold,
        );
}

class _SeniorTextBody extends SeniorText {
  _SeniorTextBody(
    String content, {
    bool? emphasis,
    Key? key,
    Color? color,
    Color? darkColor,
    TextStyle? style,
    TextProperties? textProperties,
  }) : super(
          content,
          emphasis: emphasis ?? false,
          key: key,
          color: color,
          darkColor: darkColor,
          style: style,
          textProperties: textProperties,
          typography: Typographies.body,
        );
}

class _SeniorTextBodyBold extends SeniorText {
  _SeniorTextBodyBold(
    String content, {
    bool? emphasis,
    Key? key,
    Color? color,
    Color? darkColor,
    TextStyle? style,
    TextProperties? textProperties,
  }) : super(
          content,
          emphasis: emphasis ?? false,
          key: key,
          color: color,
          darkColor: darkColor,
          style: style,
          textProperties: textProperties,
          typography: Typographies.bodyBold,
        );
}

class _SeniorTextSmall extends SeniorText {
  _SeniorTextSmall(
    String content, {
    bool? emphasis,
    Key? key,
    Color? color,
    Color? darkColor,
    TextStyle? style,
    TextProperties? textProperties,
  }) : super(
          content,
          emphasis: emphasis ?? false,
          key: key,
          color: color,
          darkColor: darkColor,
          style: style,
          textProperties: textProperties,
          typography: Typographies.small,
        );
}

class _SeniorTextSmallBold extends SeniorText {
  _SeniorTextSmallBold(
    String content, {
    bool? emphasis,
    Key? key,
    Color? color,
    Color? darkColor,
    TextStyle? style,
    TextProperties? textProperties,
  }) : super(
          content,
          emphasis: emphasis ?? false,
          key: key,
          color: color,
          darkColor: darkColor,
          style: style,
          textProperties: textProperties,
          typography: Typographies.smallBold,
        );
}

class _SeniorTextSmallLink extends SeniorText {
  _SeniorTextSmallLink(
    String content, {
    bool? emphasis,
    Key? key,
    Color? color,
    Color? darkColor,
    TextStyle? style,
    TextProperties? textProperties,
  }) : super(
          content,
          emphasis: emphasis ?? false,
          key: key,
          color: color,
          darkColor: darkColor,
          style: style,
          textProperties: textProperties,
          typography: Typographies.smallLink,
        );
}

TextStyle getTextStyle(
  Typographies typography,
  bool emphasis, {
  SeniorThemeData? theme,
  Color? color,
  Color? darkColor,
  TextStyle? style,
}) {
  Color? _customColor = theme?.themeType == ThemeType.dark ? darkColor : color;

  switch (typography) {
    case Typographies.h1:
      _customColor ??= emphasis
          ? theme?.textTheme?.h1Style?.emphasisColor
          : theme?.textTheme?.h1Style?.color;
      return SeniorTypography.h1(
        color: _customColor,
      ).merge(style);
    case Typographies.h2:
      _customColor ??= emphasis
          ? theme?.textTheme?.h2Style?.emphasisColor
          : theme?.textTheme?.h2Style?.color;
      return SeniorTypography.h2(
        color: _customColor,
      ).merge(style);
    case Typographies.h3:
      _customColor ??= emphasis
          ? theme?.textTheme?.h3Style?.emphasisColor
          : theme?.textTheme?.h3Style?.color;
      return SeniorTypography.h3(
        color: _customColor,
      ).merge(style);
    case Typographies.h4:
      _customColor ??= emphasis
          ? theme?.textTheme?.h4Style?.emphasisColor
          : theme?.textTheme?.h4Style?.color;
      return SeniorTypography.h4(
        color: _customColor,
      ).merge(style);
    case Typographies.cta:
      _customColor ??= emphasis
          ? theme?.textTheme?.ctaStyle?.emphasisColor
          : theme?.textTheme?.ctaStyle?.color;
      return SeniorTypography.cta(
        color: _customColor,
      ).merge(style);
    case Typographies.label:
      _customColor ??= emphasis
          ? theme?.textTheme?.labelStyle?.emphasisColor
          : theme?.textTheme?.labelStyle?.color;
      return SeniorTypography.label(
        color: _customColor,
      ).merge(style);
    case Typographies.labelBold:
      _customColor ??= emphasis
          ? theme?.textTheme?.labelBoldStyle?.emphasisColor
          : theme?.textTheme?.bodyBoldStyle?.color;
      return SeniorTypography.labelBold(
        color: _customColor,
      ).merge(style);
    case Typographies.body:
      _customColor ??= emphasis
          ? theme?.textTheme?.bodyStyle?.emphasisColor
          : theme?.textTheme?.bodyStyle?.color;
      return SeniorTypography.body(
        color: _customColor,
      ).merge(style);
    case Typographies.bodyBold:
      _customColor ??= emphasis
          ? theme?.textTheme?.bodyBoldStyle?.emphasisColor
          : theme?.textTheme?.bodyBoldStyle?.color;
      return SeniorTypography.bodyBold(
        color: _customColor,
      ).merge(style);
    case Typographies.small:
      _customColor ??= emphasis
          ? theme?.textTheme?.smallStyle?.emphasisColor
          : theme?.textTheme?.smallStyle?.color;
      return SeniorTypography.small(
        color: _customColor,
      ).merge(style);
    case Typographies.smallBold:
      _customColor ??= emphasis
          ? theme?.textTheme?.smallBoldStyle?.emphasisColor
          : theme?.textTheme?.smallBoldStyle?.color;
      return SeniorTypography.smallBold(
        color: _customColor,
      ).merge(style);
    case Typographies.smallLink:
      _customColor ??= emphasis
          ? theme?.textTheme?.smallLinkStyle?.emphasisColor
          : theme?.textTheme?.smallLinkStyle?.color;
      return SeniorTypography.smallLink(
        color: _customColor,
      ).merge(style);
  }
}
