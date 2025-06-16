import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import './senior_button_base.dart';
import '../../components.dart';
import '../../../repositories/theme_repository.dart';

class SeniorButtonPrimary extends SeniorButtonBase {
  SeniorButtonPrimary({
    super.key,
    required super.label,
    super.disabled = false,
    required super.onPressed,
    super.fullWidth = false,
    super.busy = false,
    super.busyMessage,
    super.icon,
    this.outlined = false,
    this.danger = false,
    this.style,
  });

  final bool outlined;
  final bool danger;
  final SeniorButtonStyle? style;

  @override
  Color defineBackgroundColor(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    if (outlined) {
      return Colors.transparent;
    }
    if (danger) {
      return style?.dangerBackgroundColor ??
          theme.primaryButtonTheme?.style?.dangerBackgroundColor ??
          SeniorColors.manchesterColorRed500;
    }
    return style?.backgroundColor ??
        theme.primaryButtonTheme?.style?.backgroundColor ??
        SeniorColors.primaryColor600;
  }

  @override
  Color defineDisabledBackgroundColor(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    if (outlined) {
      return Colors.transparent;
    }
    if (danger) {
      return style?.dangerDisabledBackgroundColor ??
          theme.primaryButtonTheme?.style?.dangerDisabledBackgroundColor ??
          SeniorColors.manchesterColorRed300;
    }
    return style?.disabledBackgroundColor ??
        theme.primaryButtonTheme?.style?.disabledBackgroundColor ??
        SeniorColors.primaryColor100;
  }

  @override
  Color defineContentColor(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    if (outlined) {
      return danger
          ? style?.dangerOutlinedContentColor ??
              theme.primaryButtonTheme?.style?.dangerOutlinedContentColor ??
              SeniorColors.manchesterColorRed500
          : style?.outlinedContentColor ??
              theme.primaryButtonTheme?.style?.outlinedContentColor ??
              SeniorColors.primaryColor600;
    }
    return danger
        ? style?.dangerContentColor ??
            theme.primaryButtonTheme?.style?.dangerContentColor ??
            SeniorColors.grayscale0
        : style?.contentColor ??
            theme.primaryButtonTheme?.style?.contentColor ??
            SeniorColors.grayscale0;
  }

  @override
  Color defineDisabledContentColor(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    if (outlined) {
      return danger
          ? style?.dangerOutlinedDisabledContentColor ??
              theme.primaryButtonTheme?.style
                  ?.dangerOutlinedDisabledContentColor ??
              SeniorColors.manchesterColorRed300
          : style?.outlinedDisabledContentColor ??
              theme.primaryButtonTheme?.style?.outlinedDisabledContentColor ??
              SeniorColors.primaryColor300;
    }
    return danger
        ? style?.dangerDisabledContentColor ??
            theme.primaryButtonTheme?.style?.dangerDisabledContentColor ??
            SeniorColors.manchesterColorRed100
        : style?.disabledContentColor ??
            theme.primaryButtonTheme?.style?.disabledContentColor ??
            SeniorColors.primaryColor300;
  }

@override
Color defineBorderColor(BuildContext context) {
  final theme = Provider.of<ThemeRepository>(context).theme;

  if (!outlined) {
    return Colors.transparent;
  }

  if (danger) {
    return style?.dangerBorderColor ??
        theme.primaryButtonTheme?.style?.dangerBorderColor ??
        SeniorColors.manchesterColorRed500;
  }

  return style?.outlinedBorderColor ??
      theme.primaryButtonTheme?.style?.outlinedBorderColor ??
      style?.borderColor ??
      theme.primaryButtonTheme?.style?.borderColor ??
      SeniorColors.primaryColor600;
}

    
  @override
  Color defineDisabledBorderColor(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    if (!outlined) {
      return Colors.transparent;
    }

    return danger
        ? style?.dangerDisabledBorderColor ??
            theme.primaryButtonTheme?.style?.dangerDisabledBorderColor ??
            SeniorColors.manchesterColorRed300
        : style?.disabledBorderColor ??
            theme.primaryButtonTheme?.style?.disabledBorderColor ??
            SeniorColors.primaryColor300;
  }

  @override
  Color defineLoaderColor(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    return danger
        ? style?.dangerLoaderColor ??
            theme.primaryButtonTheme?.style?.dangerLoaderColor ??
            SeniorColors.manchesterColorRed400
        : style?.loaderColor ??
            theme.primaryButtonTheme?.style?.loaderColor ??
            SeniorColors.primaryColor500;
  }
}
