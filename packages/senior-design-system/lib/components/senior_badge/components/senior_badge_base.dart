import 'package:flutter/material.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../components.dart';

class SeniorBadgeBase extends StatelessWidget {
  const SeniorBadgeBase({
    Key? key,
    required this.selected,
    required this.backgroundColor,
    required this.fontColor,
    required this.label,
    this.shape = SeniorBadgeShape.chip,
    this.outlined = false,
    this.value,
    this.onSelect,
    this.disabled = false,
    this.disabledBackgroundColor,
    this.disabledFontColor,
    this.count,
    this.selectedBackgroundColor,
    this.selectedFontColor,
    this.selectedIconColor,
    this.icon,
    this.iconColor,
    this.disabledIconColor,
    this.iconPosition = SeniorBadgeIconPosition.left,
    this.counterColor = SeniorColors.grayscale80,
    this.couterBackgroundColor = SeniorColors.grayscale30,
    this.textStyle,
    this.padding,
  }) : super(key: key);

  final bool selected;
  final Color backgroundColor;
  final bool disabled;
  final Color? disabledBackgroundColor;
  final Color? disabledFontColor;
  final Color fontColor;
  final String label;
  final bool outlined;
  final SeniorBadgeShape shape;
  final dynamic value;
  final Function(dynamic)? onSelect;
  final int? count;
  final Color? selectedBackgroundColor;
  final Color? selectedFontColor;
  final IconData? icon;
  final Color? iconColor;
  final Color? disabledIconColor;
  final SeniorBadgeIconPosition? iconPosition;
  final Color? selectedIconColor;
  final Color counterColor;
  final Color couterBackgroundColor;
  final TextStyle? textStyle;
  final EdgeInsets? padding;

  double _getShapeRadius() {
    switch (shape) {
      case SeniorBadgeShape.pill:
        return SeniorRadius.huge;
      case SeniorBadgeShape.chip:
      default:
        return SeniorRadius.medium;
    }
  }

  Color _getBackgroundColor() {
    if (disabled) {
      return disabledBackgroundColor ?? backgroundColor;
    }
    if (selected) {
      return selectedBackgroundColor ?? backgroundColor;
    }
    return backgroundColor;
  }

  Color _getFontColor() {
    if (disabled) {
      return disabledFontColor ?? fontColor;
    }
    if (selected) {
      return selectedFontColor ?? fontColor;
    }
    return fontColor;
  }

  Color? _getIconColor() {
    if (disabled) {
      return disabledIconColor ?? iconColor ?? fontColor;
    }
    if (selected) {
      return selectedIconColor ?? iconColor ?? fontColor;
    }
    return iconColor ?? fontColor;
  }

  Color? _getCounterBackgroundColor() {
    return couterBackgroundColor;
  }

  Color? _getCounterColor() {
    return counterColor;
  }

  List<Widget> _getBadgeContentWidgets() {
    final badgeText = Text(
      label,
      style: textStyle ?? SeniorTypography.small(color: _getFontColor()),
    );

    final badgeIcon = Padding(
      padding: EdgeInsets.only(
        right: iconPosition == SeniorBadgeIconPosition.left ? SeniorSpacing.xsmall : 0,
        left: iconPosition == SeniorBadgeIconPosition.right ? SeniorSpacing.xsmall : 0,
      ),
      child: Icon(
        icon,
        color: _getIconColor(),
        size: 14.0,
      ),
    );

    if (icon == null) {
      return [badgeText];
    }

    return iconPosition == SeniorBadgeIconPosition.left ? [badgeIcon, badgeText] : [badgeText, badgeIcon];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ??
          const EdgeInsets.symmetric(
            vertical: SeniorSpacing.xxsmall,
            horizontal: SeniorSpacing.small,
          ),
      decoration: BoxDecoration(
        border: outlined
            ? Border.all(
                color: SeniorColors.grayscale20,
                width: 1,
              )
            : null,
        color: _getBackgroundColor(),
        borderRadius: BorderRadius.all(
          Radius.circular(_getShapeRadius()),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ..._getBadgeContentWidgets(),
          count != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Container(
                    alignment: Alignment.center,
                    constraints: const BoxConstraints(
                      minWidth: 16.0,
                      minHeight: 16.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: _getCounterBackgroundColor(),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: SeniorText.small(
                        count.toString(),
                        color: _getCounterColor(),
                        style: const TextStyle(height: 0),
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
