import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

class WaapiCardWidget extends StatelessWidget {
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

  const WaapiCardWidget({
    Key? key,
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context, listen: false);
    return SeniorCard(
      onTap: onTap,
      height: height,
      width: width,
      margin: margin,
      padding: padding,
      highLightBorder: leftBorder
          ? CardHighLightBorder(
              color: themeRepository.isCustomTheme()
                  ? SeniorServiceColor.getContrastAdjustedColorTheme(color: themeRepository.theme.primaryColor!)
                  : SeniorColors.primaryColor600,
              position: CardBorderPosition.left,
            )
          : null,
      style: themeRepository.isCustomTheme() ? const SeniorCardStyle() : null,
      rightIcon: showActionIcon ? FontAwesomeIcons.chevronRight : null,
      leftIcon: showRadioButton ? (selectedRadioButton ? FontAwesomeIcons.circleDot : FontAwesomeIcons.circle) : null,
      leftIconColor: showRadioButton
          ? (selectedRadioButton
              ? themeRepository.isCustomTheme()
                  ? SeniorServiceColor.getContrastAdjustedColorTheme(color: themeRepository.theme.primaryColor!)
                  : SeniorColors.primaryColor600
              : SeniorColors.secondaryColor600)
          : null,
      disabled: disabled,
      child: child,
    );
  }
}
