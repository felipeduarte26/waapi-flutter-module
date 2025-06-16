import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

class WaapiStyleTheme {
  static bool isDarkTheme() {
    final brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    return brightness == Brightness.dark;
  }

  static SeniorDropdownButtonStyle waapiSeniorDropdownButtonStyle() {
    return SeniorDropdownButtonStyle(
      itemListTextColor: isDarkTheme() ? SeniorColors.pureWhite : SeniorColors.neutralColor900,
      labelColorEmpty: isDarkTheme() ? SeniorColors.pureWhite : SeniorColors.neutralColor900,
    );
  }

  static SeniorTextFieldStyle waapiSeniorTextFieldStyle() {
    return isDarkTheme()
        ? const SeniorTextFieldStyle(
            hintTextColor: SeniorColors.pureWhite,
            textColor: SeniorColors.pureWhite,
            helperTextColor: SeniorColors.grayscale30,
          )
        : const SeniorTextFieldStyle(
            hintTextColor: SeniorColors.neutralColor900,
            textColor: SeniorColors.neutralColor900,
          );
  }

  //This style was created because it is not possible to use the "outlined" property in SeniorButton.ghost
  static SeniorButtonStyle waapiSeniorButtonGhostOutlinedStyle(BuildContext context) {
    final provider = Provider.of<ThemeRepository>(context);
    final theme = provider.theme;
    final isLight = provider.isLightTheme();

    return SeniorButtonStyle(
      backgroundColor: theme.ghostButtonTheme?.style?.backgroundColor ??
          (isLight ? SeniorColors.pureWhite : SeniorColors.grayscale90),
      contentColor: theme.ghostButtonTheme?.style?.contentColor ?? SeniorColors.primaryColor600,
      disabledContentColor: theme.ghostButtonTheme?.style?.disabledContentColor ?? SeniorColors.primaryColor300,
      outlinedContentColor: theme.ghostButtonTheme?.style?.contentColor ?? SeniorColors.primaryColor600,
      outlinedBorderColor: theme.primaryButtonTheme?.style?.borderColor ?? SeniorColors.primaryColor600,
    );
  }

  //This style was created because it is not possible to use the "outlined" property in SeniorButton.ghost
  static SeniorButtonStyle waapiSeniorButtonGhostOutlinedDangerStyle(BuildContext context) {
    final provider = Provider.of<ThemeRepository>(context);
    final theme = provider.theme;
    final isDark = provider.isDarkTheme();

    return SeniorButtonStyle(
      backgroundColor: theme.ghostButtonTheme?.style?.backgroundColor ??
          (isDark ? SeniorColors.grayscale90 : SeniorColors.pureWhite),
      contentColor: SeniorColors.manchesterColorRed,
      disabledContentColor: SeniorColors.manchesterColorRed,
      borderColor: SeniorColors.manchesterColorRed,
      outlinedDisabledContentColor: SeniorColors.manchesterColorRed,
      disabledBorderColor: SeniorColors.manchesterColorRed,
      outlinedContentColor: SeniorColors.manchesterColorRed,
    );
  }

  static TextStyle? effectiveTextStyle({required bool isDarkColor}) {
    return TextStyle(
      color: isDarkColor ? SeniorColors.grayscale30 : SeniorColors.grayscale90,
      fontFamily: 'OpenSans',
      fontSize: 14,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle? defaultMoreStyle({required bool isDarkColor}) {
    return TextStyle(
      color: isDarkColor ? SeniorColors.primaryColor400 : SeniorColors.primaryColor500,
      fontFamily: 'OpenSans',
      fontSize: 14,
      fontWeight: FontWeight.w700,
    );
  }
}
