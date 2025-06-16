import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../repositories/theme_repository.dart';
import '../senior_button_style.dart';
import './senior_button_base.dart';

class SeniorButtonSecondary extends SeniorButtonBase {
  SeniorButtonSecondary({
    super.key,
    required super.label,
    super.disabled = false,
    required super.onPressed,
    super.fullWidth = false,
    super.busy = false,
    super.busyMessage,
    super.icon,
    this.style,
  });

  final SeniorButtonStyle? style;

  @override
  Color defineBackgroundColor(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;
    return style?.backgroundColor ??
        theme.secondaryButtonTheme?.style?.backgroundColor ??
        SeniorColors.grayscale50;
  }

  @override
  Color defineDisabledBackgroundColor(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;
    return style?.disabledBackgroundColor ??
        theme.secondaryButtonTheme?.style?.disabledBackgroundColor ??
        SeniorColors.grayscale10;
  }

  @override
  Color defineContentColor(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;
    return style?.contentColor ??
        theme.secondaryButtonTheme?.style?.contentColor ??
        SeniorColors.grayscale0;
  }

  @override
  Color defineDisabledContentColor(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;
    return style?.disabledContentColor ??
        theme.secondaryButtonTheme?.style?.disabledContentColor ??
        SeniorColors.grayscale40;
  }

  @override
  Color defineLoaderColor(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    return style?.loaderColor ??
        theme.secondaryButtonTheme?.style?.loaderColor ??
        SeniorColors.grayscale40;
  }
}
