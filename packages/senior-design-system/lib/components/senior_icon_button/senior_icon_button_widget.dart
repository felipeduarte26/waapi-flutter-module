import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import './senior_icon_button_size.dart';
import './senior_icon_button_style.dart';
import './senior_icon_button_type.dart';
import '../../repositories/theme_repository.dart';
import '../../theme/senior_theme_data.dart';

class SeniorIconButton extends StatelessWidget {
  /// Creates the SDS Icon button component.
  /// The parameters [icon], [onTap], [size] and [type] are required.
  const SeniorIconButton({
    Key? key,
    this.disabled = false,
    required this.icon,
    required this.onTap,
    this.outlined = false,
    required this.size,
    this.style,
    required this.type,
  }) : super(key: key);

  /// Whether the button will be disabled.
  final bool disabled;

  /// The button icon.
  final IconData icon;

  /// Callback function that will be executed when the button is tapped.
  final VoidCallback onTap;

  /// Whether the button will have an outline.
  final bool outlined;

  /// The size of the button. It can be [SeniorIconButtonSize.small], [SeniorIconButtonSize.medium] and
  /// [SeniorIconButtonSize.big].
  final SeniorIconButtonSize size;

  /// The component's style definitions.
  /// Allows you to configure:
  /// [SeniorIconButtonStyle.borderColor] the color of the button's border.
  /// [SeniorIconButtonStyle.buttonColor] the button color.
  /// [SeniorIconButtonStyle.disabledBorderColor] the border color of the button when it`s disabled.
  /// [SeniorIconButtonStyle.disabledButtonColor] the button color when disabled.
  /// [SeniorIconButtonStyle.disabledIconColor] icon color when disabled.
  /// [SeniorIconButtonStyle.iconColor] the icon color.
  /// [SeniorIconButtonStyle.outlinedColor] the color of the button's outline.
  final SeniorIconButtonStyle? style;

  /// The button type. It can be [SeniorIconButtonType.primary], [SeniorIconButtonType.secondary],
  /// [SeniorIconButtonType.ghost] and [SeniorIconButtonType.danger].
  final SeniorIconButtonType type;

  double _getButtonSize() {
    switch (size) {
      case SeniorIconButtonSize.small:
        return 40.0;
      case SeniorIconButtonSize.medium:
        return 48.0;
      case SeniorIconButtonSize.big:
        return 56.0;
    }
  }

  double _getIconSize() {
    switch (size) {
      case SeniorIconButtonSize.small:
        return 20.0;
      case SeniorIconButtonSize.medium:
        return 20.0;
      case SeniorIconButtonSize.big:
        return 20.0;
    }
  }

  Color _getButtonColor(SeniorThemeData theme) {
    if (disabled) {
      if (style?.disabledButtonColor != null) {
        return style!.disabledButtonColor!;
      }
    } else {
      if (style?.buttonColor != null) {
        return style!.buttonColor!;
      }
    }

    switch (type) {
      case SeniorIconButtonType.primary:
        return disabled
            ? theme.primaryIconButtonTheme?.style?.disabledButtonColor ??
                SeniorColors.primaryColor100
            : theme.primaryIconButtonTheme?.style?.buttonColor ??
                SeniorColors.primaryColor;
      case SeniorIconButtonType.secondary:
        return disabled
            ? theme.secondaryIconButtonTheme?.style?.disabledButtonColor ??
                SeniorColors.grayscale10
            : theme.secondaryIconButtonTheme?.style?.buttonColor ??
                SeniorColors.grayscale50;
      case SeniorIconButtonType.ghost:
        return disabled
            ? theme.ghostIconButtonTheme?.style?.disabledButtonColor ??
                SeniorColors.pureWhite
            : theme.ghostIconButtonTheme?.style?.buttonColor ??
                SeniorColors.pureWhite;
      case SeniorIconButtonType.danger:
        return disabled
            ? theme.dangerIconButtonTheme?.style?.disabledButtonColor ??
                SeniorColors.manchesterColorRed300
            : theme.dangerIconButtonTheme?.style?.buttonColor ??
                SeniorColors.manchesterColorRed;
    }
  }

  Color _getIconColor(SeniorThemeData theme) {
    if (disabled) {
      if (style?.disabledIconColor != null) {
        return style!.disabledIconColor!;
      }
    } else {
      if (style?.iconColor != null) {
        return style!.iconColor!;
      }
    }

    switch (type) {
      case SeniorIconButtonType.primary:
        return disabled
            ? theme.primaryIconButtonTheme?.style?.disabledIconColor ??
                SeniorColors.primaryColor300
            : theme.primaryIconButtonTheme?.style?.iconColor ??
                SeniorColors.pureWhite;
      case SeniorIconButtonType.secondary:
        return disabled
            ? theme.secondaryIconButtonTheme?.style?.disabledIconColor ??
                SeniorColors.grayscale40
            : theme.secondaryIconButtonTheme?.style?.iconColor ??
                SeniorColors.pureWhite;
      case SeniorIconButtonType.ghost:
        return disabled
            ? theme.ghostIconButtonTheme?.style?.disabledIconColor ??
                SeniorColors.primaryColor100
            : theme.ghostIconButtonTheme?.style?.iconColor ??
                SeniorColors.primaryColor;
      case SeniorIconButtonType.danger:
        return disabled
            ? theme.dangerIconButtonTheme?.style?.disabledIconColor ??
                SeniorColors.pureWhite
            : theme.dangerIconButtonTheme?.style?.iconColor ??
                SeniorColors.pureWhite;
    }
  }

  Color _getBorderColor(SeniorThemeData theme) {
    if (disabled) {
      if (style?.disabledBorderColor != null) {
        return style!.disabledBorderColor!;
      }
    } else if (outlined) {
      if (style?.outlinedColor != null) {
        return style!.outlinedColor!;
      }
    } else {
      if (style?.borderColor != null) {
        return style!.borderColor!;
      }
    }

    switch (type) {
      case SeniorIconButtonType.primary:
        return outlined
            ? theme.primaryIconButtonTheme?.style?.outlinedColor ??
                SeniorColors.primaryColor200
            : disabled
                ? theme.primaryIconButtonTheme?.style?.disabledBorderColor ??
                    Colors.transparent
                : theme.primaryIconButtonTheme?.style?.borderColor ??
                    Colors.transparent;
      case SeniorIconButtonType.secondary:
        return outlined
            ? theme.secondaryIconButtonTheme?.style?.outlinedColor ??
                SeniorColors.grayscale30
            : disabled
                ? theme.secondaryIconButtonTheme?.style?.disabledBorderColor ??
                    Colors.transparent
                : theme.secondaryIconButtonTheme?.style?.borderColor ??
                    Colors.transparent;
      case SeniorIconButtonType.ghost:
        return outlined
            ? theme.ghostIconButtonTheme?.style?.outlinedColor ??
                SeniorColors.primaryColor500
            : disabled
                ? theme.ghostIconButtonTheme?.style?.disabledBorderColor ??
                    SeniorColors.grayscale20
                : theme.ghostIconButtonTheme?.style?.borderColor ??
                    SeniorColors.grayscale20;
      case SeniorIconButtonType.danger:
        return outlined
            ? theme.dangerIconButtonTheme?.style?.outlinedColor ??
                SeniorColors.manchesterColorRed600
            : disabled
                ? theme.dangerIconButtonTheme?.style?.disabledBorderColor ??
                    Colors.transparent
                : theme.dangerIconButtonTheme?.style?.borderColor ??
                    Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    final buttonSize = _getButtonSize();

    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Material(
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: !disabled ? onTap : null,
          customBorder: const CircleBorder(),
          child: Ink(
            decoration: BoxDecoration(
              color: _getButtonColor(theme),
              shape: BoxShape.circle,
              border: Border.all(
                color: _getBorderColor(theme),
                width: outlined ? 2.0 : 1.0,
              ),
            ),
            width: buttonSize,
            height: buttonSize,
            child: Center(
              child: FaIcon(
                icon,
                color: _getIconColor(theme),
                size: _getIconSize(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
