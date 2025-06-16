import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';
import '../../repositories/theme_repository.dart';
import '../../theme/senior_theme_data.dart';
import './senior_switch_style.dart';

/// The possible SeniorSwitch title positions.
/// It can be [SeniorSwitchTitlePosition.left] and [SeniorSwitchTitlePosition.right].
enum SeniorSwitchTitlePosition {
  left,
  right,
}

class SeniorSwitch extends StatelessWidget {
  /// Creates a Switch component according to SDS.
  ///
  /// The [onChanged] and [value] parameters are required.
  const SeniorSwitch({
    Key? key,
    this.disabled = false,
    this.fullLenght = false,
    this.titlePosition = SeniorSwitchTitlePosition.left,
    required this.onChanged,
    this.style,
    this.title,
    required this.value,
    this.thumbIcon,
  }) : super(key: key);

  /// Whether the switch will be disabled.
  ///
  /// The default value is false.
  final bool disabled;

  /// Whether the switch will fill all available space.
  ///
  /// The default value is false.
  final bool fullLenght;

  /// The position of the Switch title.
  ///
  /// The default value is [SeniorSwitchTitlePosition.left].
  final SeniorSwitchTitlePosition titlePosition;

  /// Function executed when the switch value is changed.
  ///
  /// It receives the current value of the switch as a parameter.
  final Function(bool?) onChanged;

  /// The component's style definitions.
  ///
  /// Allows you to configure:
  /// [SeniorSwitchStyle.activeColor] the color to use when this switch is on.
  /// [SeniorSwitchStyle.disabledTextColor] the color of the switch's title text when it is disabled.
  /// [SeniorSwitchStyle.textColor] the switch title text color.
  /// [SeniorSwitchStyle.trackColor] the color of this Switch's track.
  final SeniorSwitchStyle? style;

  /// The title of the switch.
  final String? title;

  /// The value of the switch. Defines whether the switch will be checked or unchecked.
  final bool value;

  /// The icon of the switch thumb.
  final IconData? thumbIcon;

  Widget _buildSwitch(SeniorThemeData theme) {
    final hasThumbIcon = thumbIcon != null;
    final activeTrackColor = style?.activeColor ?? theme.switchTheme?.style?.activeColor ?? SeniorColors.primaryColor;
    final inactiveTrackColor = style?.trackColor ?? theme.switchTheme?.style?.trackColor ?? SeniorColors.grayscale50;
    final thumbActiveColor =
        style?.thumbActiveColor ?? theme.switchTheme?.style?.thumbActiveColor ?? SeniorColors.primaryColor;
    final inactiveThumbColor =
        style?.thumbInactiveColor ?? theme.switchTheme?.style?.thumbInactiveColor ?? SeniorColors.grayscale50;
    final _activeThumbColor = value ? thumbActiveColor : inactiveThumbColor;
    return Transform.scale(
        scale: 0.7,
        child: CupertinoSwitch(
          activeTrackColor: activeTrackColor,
          onChanged: !disabled ? onChanged : null,
          inactiveTrackColor: inactiveTrackColor,
          value: value,
          thumbIcon: WidgetStateProperty.resolveWith<Icon?>(
            (Set<WidgetState> states) {
              if (hasThumbIcon) {
                return Icon(thumbIcon, color: _activeThumbColor);
              } else {
                return null;
              }
            },
          ),
        ));
  }

  Widget _buildTitle(SeniorThemeData theme) {
    return title != null
        ? Flexible(
            child: Text(
              title!,
              style: SeniorTypography.label(
                color: disabled
                    ? style?.disabledTextColor ??
                        theme.switchTheme?.style?.disabledTextColor ??
                        SeniorColors.grayscale30
                    : style?.textColor ?? theme.switchTheme?.style?.textColor ?? SeniorColors.grayscale90,
              ),
            ),
          )
        : const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    if (title == null) {
      return _buildSwitch(theme);
    }

    return Row(
      mainAxisAlignment: fullLenght ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
      children: titlePosition == SeniorSwitchTitlePosition.left
          ? [_buildTitle(theme), _buildSwitch(theme)]
          : [_buildSwitch(theme), _buildTitle(theme)],
    );
  }
}
