import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';

abstract class SnackbarHelper {
  static ScaffoldFeatureController showSnackbar({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    return ScaffoldMessenger.of(context).showSnackBar(
      SeniorSnackBar.error(
        message: message,
      ),
    );
  }
}
