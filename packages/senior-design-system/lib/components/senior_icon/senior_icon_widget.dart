import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../repositories/repositories.dart';
import './senior_icon_style.dart';

class SeniorIcon extends StatelessWidget {
  /// Creates a icon component.
  const SeniorIcon({
    super.key,
    required this.icon,
    required this.size,
    this.style,
  });

  /// Defines the icon.
  final IconData icon;

  /// Defines the size of the icon.
  final double size;

  /// The component's style definitions.
  /// Allows you to configure:
  /// [SeniorIconStyle.color] the color of the icon.
  final SeniorIconStyle? style;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    return Icon(
      icon,
      color: style?.color ?? theme.iconTheme?.style?.color ?? SeniorColors.grayscale90,
      size: size,
    );
  }
}
