import 'package:flutter/material.dart';

class CardDismissibleAction {
  /// The actions supported by SeniorCard's dismissible configurations.
  /// The parameters [backgroundColor], [icon] and [onDismissed] are required.
  const CardDismissibleAction({
    required this.backgroundColor,
    required this.icon,
    required this.onDismissed,
  });

  /// Action background color. Displayed while the card is being dragged.
  final Color backgroundColor;

  /// Action icon.
  final IconData icon;

  /// Function executed when the dismissible action is performed.
  final Function() onDismissed;
}
