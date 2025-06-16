import 'package:flutter/material.dart';

import './card_dismissible_action.dart';

class CardDismissibleConfig {
  /// Settings for SeniorCard-supported dismiss action.
  /// The [key] and [primaryAction] parameters are required.
  const CardDismissibleConfig({
    required this.key,
    required this.primaryAction,
    this.secondaryAction,
  });

  final Key key;

  /// Primary action. Drag from left to right.
  final CardDismissibleAction primaryAction;

  /// Secondary action. Drag from right to left.
  final CardDismissibleAction? secondaryAction;
}
