import 'package:flutter/material.dart';

import './senior_button_style.dart';
import './components/components.dart';

class SeniorButton extends StatelessWidget {
  /// Creates a button with Senior Design System determinations for primary button.
  /// The [label] and [onPressed] parameters are required.
  const SeniorButton({
    Key? key,
    this.disabled = false,
    required this.label,
    required this.onPressed,
    this.busy = false,
    this.busyMessage,
    this.icon,
    this.outlined = false,
    this.danger = false,
    this.fullWidth = false,
    this.style,
  }) : super(key: key);

  /// Defines if the button will be disabled.
  /// The default value is false.
  final bool disabled;

  /// The text that is displayed inside the button.
  final String label;

  /// Function that is executed when the button is pressed.
  final VoidCallback onPressed;

  /// Defines whether the button will be in busy or loading status.
  /// The default value is false.
  final bool busy;

  /// The message that is displayed when it is in a busy state.
  /// If it is in a busy state and the busyMessage is not informed, the label
  /// will be displayed.
  final String? busyMessage;

  /// An icon displayed inside the button.
  final IconData? icon;

  /// Defines whether the button will be in a state where it is made up of an
  /// outer border.
  /// The default value is false.
  final bool outlined;

  /// Defines whether the button will be in a danger state. Used to represent
  /// more critical actions.
  /// The default value is false.
  final bool danger;

  /// defines whether the button will occupy all available width
  /// The default value is false.
  final bool fullWidth;

  /// Defines the button style.
  final SeniorButtonStyle? style;

  /// Creates a button with the Senior Design system determinations for the primary button.
  /// The [label] and [onPressed] parameters are required.
  factory SeniorButton.primary({
    Key? key,
    bool disabled,
    required String label,
    required VoidCallback onPressed,
    bool busy,
    String? busyMessage,
    IconData? icon,
    bool outlined,
    bool danger,
    bool fullWidth,
    SeniorButtonStyle? style,
  }) = _SeniorButtonPrimary;

  /// Creates a button with the Senior Design System determinations for a
  /// secondary button.
  /// The [label] and [onPressed] parameters are required.
  factory SeniorButton.secondary({
    Key? key,
    bool disabled,
    required String label,
    required VoidCallback onPressed,
    bool busy,
    String? busyMessage,
    IconData? icon,
    bool fullWidth,
    SeniorButtonStyle? style,
  }) = _SeniorButtonSecondary;

  /// Creates a button with the Senior Design System determinations for a ghost
  /// or tertiary button.
  /// The [label] and [onPressed] parameters are required.
  factory SeniorButton.ghost({
    Key? key,
    bool disabled,
    required String label,
    required VoidCallback onPressed,
    bool busy,
    String? busyMessage,
    IconData? icon,
    bool fullWidth,
    SeniorButtonStyle? style,
  }) = _SeniorButtonGhost;

  @override
  Widget build(BuildContext context) {
    return SeniorButtonPrimary(
      label: label,
      onPressed: onPressed,
      busy: busy,
      busyMessage: busyMessage,
      disabled: disabled,
      icon: icon,
      key: key,
      outlined: outlined,
      danger: danger,
      fullWidth: fullWidth,
      style: style,
    );
  }
}

class _SeniorButtonPrimary extends SeniorButton {
  const _SeniorButtonPrimary({
    super.key,
    super.disabled,
    required super.label,
    required super.onPressed,
    super.busy,
    super.busyMessage,
    super.icon,
    super.outlined,
    super.danger,
    super.fullWidth,
    super.style,
  });

  @override
  Widget build(BuildContext context) {
    return SeniorButtonPrimary(
      label: label,
      onPressed: onPressed,
      busy: busy,
      busyMessage: busyMessage,
      disabled: disabled,
      icon: icon,
      key: key,
      outlined: outlined,
      danger: danger,
      fullWidth: fullWidth,
      style: style,
    );
  }
}

class _SeniorButtonSecondary extends SeniorButton {
  const _SeniorButtonSecondary({
    super.key,
    super.disabled,
    required super.label,
    required super.onPressed,
    super.busy,
    super.busyMessage,
    super.icon,
    super.fullWidth,
    super.style,
  });

  @override
  Widget build(BuildContext context) {
    return SeniorButtonSecondary(
      label: label,
      onPressed: onPressed,
      disabled: disabled,
      icon: icon,
      key: key,
      busy: busy,
      busyMessage: busyMessage,
      fullWidth: fullWidth,
      style: style,
    );
  }
}

class _SeniorButtonGhost extends SeniorButton {
  const _SeniorButtonGhost({
    super.key,
    super.disabled,
    required super.label,
    required super.onPressed,
    super.busy,
    super.busyMessage,
    super.icon,
    super.fullWidth,
    super.style,
  });

  @override
  Widget build(BuildContext context) {
    return SeniorButtonGhost(
      label: label,
      onPressed: onPressed,
      disabled: disabled,
      icon: icon,
      key: key,
      busy: busy,
      busyMessage: busyMessage,
      fullWidth: fullWidth,
      style: style,
    );
  }
}
