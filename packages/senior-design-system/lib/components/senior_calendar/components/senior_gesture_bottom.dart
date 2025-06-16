import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

class SeniorBottomGesture extends StatelessWidget {
  SeniorBottomGesture({
    this.color,
    this.downDirection = true,
    this.onTap,
    this.padding = const EdgeInsets.all(SeniorSpacing.xsmall),
  });

  final Color? color;
  final bool downDirection;
  final VoidCallback? onTap;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        onTap?.call(),
      },
      child: Padding(
        padding: padding,
        child: Icon(
            downDirection
                ? FontAwesomeIcons.chevronDown
                : FontAwesomeIcons.chevronUp,
            color: color),
      ),
    );
  }
}
