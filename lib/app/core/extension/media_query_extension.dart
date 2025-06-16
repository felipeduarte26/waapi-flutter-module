import 'package:flutter/material.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

extension MediaQueryExtension on BuildContext {
  double get heightSize {
    return MediaQuery.of(this).size.height;
  }

  double get widthSize {
    return MediaQuery.of(this).size.width;
  }

  double get notchHeight {
    return MediaQuery.of(this).padding.top;
  }

  double get bottomSize {
    return MediaQuery.of(this).padding.bottom;
  }

  double get seniorColorfulHeaderBodySize {
    return _calculeSeniorColorfulHeaderBody(this);
  }

  double get bottomSheetSize {
    return _calculeSeniorColorfulHeaderBody(this) + SeniorRadius.huge;
  }

  double get bottomSheetSizeContacts {
    return _calculeSeniorColorfulHeaderBody(this) - SeniorSpacing.xsmall;
  }

  bool get isSmallDevice {
    return widthSize < 360;
  }
}

double _calculeSeniorColorfulHeaderBody(BuildContext context) {
  final screenHeight = (MediaQuery.of(context).size.height);
  final notchHeight = (MediaQuery.of(context).padding.top);
  final appBarHeight = (AppBar().preferredSize.height) + SeniorRadius.huge;

  return screenHeight - notchHeight - appBarHeight;
}
