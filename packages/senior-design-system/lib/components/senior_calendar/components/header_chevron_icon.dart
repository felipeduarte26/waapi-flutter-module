import 'package:flutter/material.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';

class HeaderChevronIcon extends StatelessWidget {
  final bool headButtonActive;
  final IconData icon;
  final Color borderColor;
  final Color activeButtonColor;
  final Color inactiveButtonColor;

  const HeaderChevronIcon({
    super.key,
    required this.headButtonActive,
    required this.icon,
    required this.borderColor,
    required this.activeButtonColor,
    required this.inactiveButtonColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24.0,
      width: 24.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          SeniorSpacing.xsmall,
        ),
        border: Border.all(
          color: borderColor,
          width: 1.0,
        ),
      ),
      child: Icon(
        icon,
        color: headButtonActive ? activeButtonColor : inactiveButtonColor,
        size: SeniorSpacing.small,
      ),
    );
  }
}
