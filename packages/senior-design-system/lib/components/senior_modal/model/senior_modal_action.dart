import 'package:flutter/material.dart';

class SeniorModalAction {
  SeniorModalAction({
    required this.label,
    required this.action,
    this.icon,
    this.danger = false,
    this.busy = false,
    this.busyMessage,
  });

  final String label;
  final VoidCallback action;
  final IconData? icon;
  final bool danger;
  final bool busy;
  final String? busyMessage;
}
