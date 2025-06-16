import 'package:flutter/material.dart';

class ActionNotification {
  /// Settings for notification actions displayed on the backdrop.
  /// The [actionName] and [action] parameters are required.
  const ActionNotification({
    required this.actionName,
    required this.action,
  });

  /// The description of the action. The text that run the action when it`s tapped.
  final String actionName;

  /// the notification action.
  final VoidCallback action;
}
