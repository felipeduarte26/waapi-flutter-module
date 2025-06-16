import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../senior_button_style.dart';
import './senior_button_base.dart';
import '../../../repositories/theme_repository.dart';

class SeniorButtonGhost extends SeniorButtonBase {
  SeniorButtonGhost({
    super.key,
    required super.label,
    super.disabled,
    required super.onPressed,
    super.fullWidth = false,
    super.busy = false,
    super.busyMessage,
    super.icon,
    this.style,
  });

  final SeniorButtonStyle? style;

  @override
  Color defineContentColor(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;
    return style?.contentColor ??
        theme.ghostButtonTheme?.style?.contentColor ??
        SeniorColors.primaryColor600;
  }

  @override
  Color defineDisabledContentColor(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;
    return style?.disabledContentColor ??
        theme.ghostButtonTheme?.style?.disabledContentColor ??
        SeniorColors.primaryColor300;
  }

  @override
  Color defineLoaderColor(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    return style?.loaderColor ??
        theme.ghostButtonTheme?.style?.loaderColor ??
        SeniorColors.primaryColor300;
  }
}
