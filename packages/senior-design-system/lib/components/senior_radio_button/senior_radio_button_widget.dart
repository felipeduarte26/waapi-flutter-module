import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import './senior_radio_button_style.dart';
import '../../repositories/theme_repository.dart';

class SeniorRadioButton<T> extends StatelessWidget {
  /// Creates the Radio Button component of the SDS.
  ///
  /// The [groupValue], [onChanged], [title] and [value] parameters are required.
  const SeniorRadioButton({
    Key? key,
    this.disabled = false,
    required this.groupValue,
    required this.onChanged,
    this.style,
    this.toggleable = false,
    required this.title,
    required this.value,
  }) : super(key: key);

  /// Defines if the radio button will be disabled.
  final bool disabled;

  /// Defines the value that will be assigned to the internal [Radio] groupValue property.
  /// The currently selected value for a group of radio buttons.
  final T groupValue;

  /// Defines the value that will be assigned to the internal [Radio] onChanged property.
  /// Called when the user selects this radio button.
  final Function(T?) onChanged;

  /// The component's style definitions.
  ///
  /// Allows you to configure:
  /// [SeniorRadioButtonStyle.checkedFillColor] the fill color of the radio button when it`s checked.
  /// [SeniorRadioButtonStyle.disabledCheckedFillColor] the fill color of the radio button when it`s disabled and checked.
  /// [SeniorRadioButtonStyle.disabledTitleColor] the radio button title color when disabled.
  /// [SeniorRadioButtonStyle.disabledUncheckedFillColor] the fill color of the radio button when it`s disabled and unchecked.
  /// [SeniorRadioButtonStyle.titleColor] the radio button title color.
  /// [SeniorRadioButtonStyle.uncheckedFillColor] the fill color of the radio button when it`s unchecked.
  final SeniorRadioButtonStyle? style;

  /// The title of the radio button.
  final String title;

  /// Defines the value that will be assigned to the internal [Radio] toggleable property.
  /// Set to true if this radio button is allowed to be returned to an indeterminate state by selecting it again when selected.
  final bool toggleable;

  /// Defines the value that will be assigned to the internal [Radio] value property.
  /// The value represented by this radio button.
  final T value;

  Widget _buildRadioButton(Color fillColor) {
    return Container(
      height: 16.0,
      width: 16.0,
      padding: const EdgeInsets.only(top: SeniorSpacing.small),
      margin: const EdgeInsets.only(right: SeniorSpacing.xsmall),
      child: Radio<T?>(
        key: key,
        groupValue: groupValue,
        value: value,
        onChanged: !disabled ? onChanged : null,
        fillColor: WidgetStateColor.resolveWith((state) => fillColor),
        toggleable: toggleable,
      ),
    );
  }

  Flexible _buildTitle(Color titleColor) {
    return Flexible(
      child: GestureDetector(
        onTap: () {
          onChanged(value);
        },
        child: Text(
          title,
          style: SeniorTypography.label(
            color: titleColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    final Color titleColor = disabled
        ? style?.disabledTitleColor ??
            theme.radioButtonTheme?.style?.disabledTitleColor ??
            SeniorColors.grayscale30
        : style?.titleColor ??
            theme.radioButtonTheme?.style?.titleColor ??
            SeniorColors.grayscale90;

    final Color fillColor = disabled
        ? groupValue == value
            ? style?.disabledCheckedFillColor ??
                theme.radioButtonTheme?.style?.disabledCheckedFillColor ??
                SeniorColors.grayscale30
            : style?.disabledUncheckedFillColor ??
                theme.radioButtonTheme?.style?.disabledUncheckedFillColor ??
                SeniorColors.grayscale30
        : groupValue == value
            ? style?.checkedFillColor ??
                theme.radioButtonTheme?.style?.checkedFillColor ??
                SeniorColors.primaryColor600
            : style?.uncheckedFillColor ??
                theme.radioButtonTheme?.style?.uncheckedFillColor ??
                SeniorColors.primaryColor600;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRadioButton(fillColor),
          _buildTitle(titleColor),
        ],
      ),
    );
  }
}
