import 'package:flutter/material.dart';

import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../senior_notification_snackbar.dart';

const notificationSnackbarLightTheme =
    const SeniorNotificationSnackbarThemeData(
  style: SeniorNotificationSnackbarStyle(
    actionButtonColor: SeniorColors.grayscale90,
    borderColor: Colors.transparent,
    color: SeniorColors.grayscale20,
    messageColor: SeniorColors.grayscale90,
    titleColor: SeniorColors.grayscale90,
  ),
);
