import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

class AppSeniorCardWidget extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final bool showActionIcon;
  final VoidCallback? onTap;
  final bool showRadioButton;
  final bool selectedRadioButton;
  final bool leftBorder;
  final bool disabled;

  const AppSeniorCardWidget({
    super.key,
    required this.child,
    this.height,
    this.width,
    this.onTap,
    this.showActionIcon = true,
    this.padding,
    this.margin = EdgeInsets.zero,
    this.showRadioButton = false,
    this.selectedRadioButton = false,
    this.leftBorder = false,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return SeniorCard(
      onTap: onTap,
      height: height,
      width: width,
      margin: margin,
      padding: padding,
      withElevation: true,
      highLightBorder: leftBorder
          ? const CardHighLightBorder(
              color: SeniorColors.primaryColor600,
              position: CardBorderPosition.left,
            )
          : null,
      rightIcon: showActionIcon ? FontAwesomeIcons.chevronRight : null,
      leftIcon: showRadioButton ? (selectedRadioButton ? FontAwesomeIcons.circleDot : FontAwesomeIcons.circle) : null,
      leftIconColor: showRadioButton
          ? (selectedRadioButton ? SeniorColors.primaryColor600 : SeniorColors.secondaryColor600)
          : null,
      disabled: disabled,
      child: child,
    );
  }
}
