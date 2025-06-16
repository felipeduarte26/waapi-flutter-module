import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../theme/senior_theme_data.dart';
import '../../theme/themes/themes.dart';

class SeniorSnackBarAction extends SnackBarAction {
  /// Configuration of actions supported by the SeniorSnackbar component.
  /// Adds an interaction button within the Snackbar content.
  ///
  /// The [label] and [onPressed] parameters are required.
  SeniorSnackBarAction({
    required String label,
    required Function() onPressed,
  }) : super(
          disabledTextColor: SeniorColors.grayscale50,
          label: label,
          onPressed: onPressed,
          textColor: SeniorColors.pureBlack,
        );
}

abstract class SeniorSnackBar extends SnackBar {
  SeniorSnackBar({
    Key? key,
    SeniorSnackBarAction? action,
    required Color backgroundColor,
    Duration? duration,
    DismissDirection? dismissDirection,
    required Color fontColor,
    IconData? icon,
    Color? iconColor,
    required String message,
  }) : super(
          duration: duration ?? const Duration(milliseconds: 4000),
          dismissDirection: dismissDirection ?? DismissDirection.down,
          behavior: SnackBarBehavior.floating,
          backgroundColor: backgroundColor,
          elevation: 1.0,
          action: action,
          content: Row(
            children: [
              Visibility(
                visible: icon != null,
                child: Padding(
                  padding: const EdgeInsets.only(right: SeniorSpacing.normal),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: SeniorIconSize.medium,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  message,
                  style: SeniorTypography.small(color: fontColor),
                ),
              ),
            ],
          ),
        );

  /// Create a success status snackbar.
  /// The [key] parameter is the Snackbar component's Key.
  /// The [action] parameter is the snackbar action.
  /// The [message] parameter is the message displayed in the snackbar.
  /// The [duration] parameter determines the time the snackbar is active.
  /// The [theme] parameter allows you to pass the application theme to SeniorSnackbar.
  /// The [message] parameter is required.
  factory SeniorSnackBar.success({
    Key? key,
    SeniorSnackBarAction? action,
    required String message,
    Duration? duration,
    SeniorThemeData? theme,
  }) = _SeniorSnackbarSuccess;

  /// Creates a message status snackbar.
  /// The [key] parameter is the Snackbar component's Key.
  /// The [action] parameter is the snackbar action.
  /// The [message] parameter is the message displayed in the snackbar.
  /// The [duration] parameter determines the time the snackbar is active.
  /// The [theme] parameter allows you to pass the application theme to SeniorSnackbar.
  /// The [message] parameter is required.
  factory SeniorSnackBar.message({
    Key? key,
    SeniorSnackBarAction? action,
    required String message,
    Duration? duration,
    SeniorThemeData? theme,
  }) = _SeniorSnackbarMessage;

  /// Creates a warning status snackbar.
  /// The [key] parameter is the Snackbar component's Key.
  /// The [action] parameter is the snackbar action.
  /// The [message] parameter is the message displayed in the snackbar.
  /// The [duration] parameter determines the time the snackbar is active.
  /// The [theme] parameter allows you to pass the application theme to SeniorSnackbar.
  /// The [message] parameter is required.
  factory SeniorSnackBar.warning({
    Key? key,
    SeniorSnackBarAction? action,
    required String message,
    Duration? duration,
    SeniorThemeData? theme,
  }) = _SeniorSnackbarWarning;

  /// Creates a error status snackbar.
  /// The [key] parameter is the Snackbar component's Key.
  /// The [action] parameter is the snackbar action.
  /// The [message] parameter is the message displayed in the snackbar.
  /// The [duration] parameter determines the time the snackbar is active.
  /// The [theme] parameter allows you to pass the application theme to SeniorSnackbar.
  /// The [message] parameter is required.
  factory SeniorSnackBar.error({
    Key? key,
    SeniorSnackBarAction? action,
    required String message,
    Duration? duration,
    SeniorThemeData? theme,
  }) = _SeniorSnackbarError;
}

class _SeniorSnackbarSuccess extends SeniorSnackBar {
  _SeniorSnackbarSuccess({
    Key? key,
    SeniorSnackBarAction? action,
    required String message,
    Duration? duration,
    SeniorThemeData? theme,
  }) : super(
          key: key,
          message: message,
          duration: duration,
          icon: FontAwesomeIcons.solidCircleCheck,
          iconColor: theme?.successSnackbarTheme?.style?.iconColor ??
              SENIOR_LIGHT_THEME.successSnackbarTheme?.style?.iconColor ??
              SeniorColors.manchesterColorGreen,
          backgroundColor: theme
                  ?.successSnackbarTheme?.style?.backgroundColor ??
              SENIOR_LIGHT_THEME.successSnackbarTheme?.style?.backgroundColor ??
              SeniorColors.manchesterColorGreen100,
          fontColor: theme?.successSnackbarTheme?.style?.fontColor ??
              SENIOR_LIGHT_THEME.successSnackbarTheme?.style?.fontColor ??
              SeniorColors.pureBlack,
          action: action,
        );
}

class _SeniorSnackbarMessage extends SeniorSnackBar {
  _SeniorSnackbarMessage({
    Key? key,
    SeniorSnackBarAction? action,
    required String message,
    Duration? duration,
    SeniorThemeData? theme,
  }) : super(
          key: key,
          message: message,
          duration: duration,
          icon: FontAwesomeIcons.circleInfo,
          iconColor: theme?.messageSnackbarTheme?.style?.iconColor ??
              SENIOR_LIGHT_THEME.messageSnackbarTheme?.style?.iconColor ??
              SeniorColors.manchesterColorBlue,
          backgroundColor: theme
                  ?.messageSnackbarTheme?.style?.backgroundColor ??
              SENIOR_LIGHT_THEME.messageSnackbarTheme?.style?.backgroundColor ??
              SeniorColors.manchesterColorBlue100,
          fontColor: theme?.messageSnackbarTheme?.style?.fontColor ??
              SENIOR_LIGHT_THEME.messageSnackbarTheme?.style?.fontColor ??
              SeniorColors.pureBlack,
          action: action,
        );
}

class _SeniorSnackbarWarning extends SeniorSnackBar {
  _SeniorSnackbarWarning({
    Key? key,
    SeniorSnackBarAction? action,
    required String message,
    Duration? duration,
    SeniorThemeData? theme,
  }) : super(
          key: key,
          message: message,
          duration: duration,
          icon: FontAwesomeIcons.triangleExclamation,
          iconColor: theme?.warningSnackbarTheme?.style?.iconColor ??
              SENIOR_LIGHT_THEME.warningSnackbarTheme?.style?.iconColor ??
              SeniorColors.manchesterColorYellow,
          backgroundColor: theme
                  ?.warningSnackbarTheme?.style?.backgroundColor ??
              SENIOR_LIGHT_THEME.warningSnackbarTheme?.style?.backgroundColor ??
              SeniorColors.manchesterColorYellow100,
          fontColor: theme?.warningSnackbarTheme?.style?.fontColor ??
              SENIOR_LIGHT_THEME.warningSnackbarTheme?.style?.fontColor ??
              SeniorColors.pureBlack,
          action: action,
        );
}

class _SeniorSnackbarError extends SeniorSnackBar {
  _SeniorSnackbarError({
    Key? key,
    SeniorSnackBarAction? action,
    required String message,
    Duration? duration,
    SeniorThemeData? theme,
  }) : super(
          key: key,
          message: message,
          duration: duration,
          dismissDirection:
              action == null ? DismissDirection.down : DismissDirection.none,
          icon: FontAwesomeIcons.solidCircleXmark,
          iconColor: theme?.errorSnackbarTheme?.style?.iconColor ??
              SENIOR_LIGHT_THEME.errorSnackbarTheme?.style?.iconColor ??
              SeniorColors.manchesterColorRed,
          backgroundColor: theme?.errorSnackbarTheme?.style?.backgroundColor ??
              SENIOR_LIGHT_THEME.errorSnackbarTheme?.style?.backgroundColor ??
              SeniorColors.manchesterColorRed100,
          fontColor: theme?.errorSnackbarTheme?.style?.fontColor ??
              SENIOR_LIGHT_THEME.errorSnackbarTheme?.style?.fontColor ??
              SeniorColors.pureBlack,
          action: action,
        );
}
