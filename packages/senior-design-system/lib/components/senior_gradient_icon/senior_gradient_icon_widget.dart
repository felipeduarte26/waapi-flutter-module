import 'dart:ui' as ui;
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import './senior_gradient_icon_style.dart';
import './senior_gradient_icon_theme.dart';
import '../../repositories/theme_repository.dart';

class SeniorGradientIcon extends StatelessWidget {
  /// Creates a gradient icon.
  ///
  /// The [icon] and [sizeIcon] parameters are required.
  const SeniorGradientIcon({
    Key? key,
    this.boxSize,
    required this.icon,
    required this.sizeIcon,
    this.style,
  }) : super(key: key);

  /// The size of the gradient box where the icon is applied.
  /// In order for the gradient to be applied to the entire icon, the value must be greater than [sizeIcon].
  ///
  /// The default value is 80 logical pixels.
  final double? boxSize;

  /// The icon that will have a color gradient.
  final IconData icon;

  /// The size of the icon.
  final double sizeIcon;

  /// The component's style definitions.
  /// Allows you to configure:
  /// [SeniorGradientIconStyle.gradientColors] the icon gradient colors.
  ///
  /// It can be set on the [SeniorTheme] instance assigned to the app in the [SeniorGradientIconThemeData.style] parameter.
  final SeniorGradientIconStyle? style;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    return ShaderMask(
      shaderCallback: (bounds) {
        return ui.Gradient.linear(
          Offset(0.0, sizeIcon),
          Offset(sizeIcon, 0.0),
          style?.gradientColors ??
              theme.gradientIconTheme?.style?.gradientColors ??
              SeniorColors.primaryGradientColors,
        );
      },
      blendMode: BlendMode.srcIn,
      child: SizedBox(
        height: boxSize ?? sizeIcon * 1.2,
        width: boxSize ?? sizeIcon * 1.2,
        child: Icon(
          icon,
          size: sizeIcon,
        ),
      ),
    );
  }
}
