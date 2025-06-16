import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../repositories/theme_repository.dart';
import '../../theme/senior_theme_data.dart';
import './senior_checkbox_style.dart';

class SeniorCheckbox extends StatelessWidget {
  /// Creates the SDS checkbox component.
  ///
  /// The [onChanged] and [value] parameters are required.
  const SeniorCheckbox({
    Key? key,
    this.actionOnTitle = false,
    this.disabled = false,
    this.extraTapMargin = 0,
    this.onChanged,
    this.style,
    this.title,
    required this.value,
    this.disableLayoutBuilder = false,
  }) : super(key: key);

  /// Allows the checkbox title to also perform the action of changing the value.
  ///
  /// The default value is false.
  final bool actionOnTitle;

  /// Defines whether the checkbox will be disabled.
  ///
  /// The default value is false.
  final bool disabled;

  /// A margin that allows you to increase the area of interaction of the checkbox.
  ///
  /// The default value is 0.
  final double extraTapMargin;

  /// A função callback que é executada quando o valor do checkbox é alterado.
  final Function(bool?)? onChanged;

  /// The component's style definitions.
  /// Allows you to configure:
  /// [SeniorCheckboxStyle.activeColor] The color to use when this checkbox is checked.
  /// [SeniorCheckboxStyle.checkColor] The color to use for the check icon when this checkbox is checked.
  /// [SeniorCheckboxStyle.checkedBorderColor] The color of the checkbox border.
  /// [SeniorCheckboxStyle.disabledBorderColor] The border color of the checkbox when disabled.
  /// [SeniorCheckboxStyle.disabledCheckColor] The color to use for the check icon when this checkbox is checked and it is
  /// disabled.
  /// [SeniorCheckboxStyle.disabledTitleColor] The color of the checkbox title when disabled.
  /// [SeniorCheckboxStyle.titleColor] The color of the checkbox title.
  /// [SeniorCheckboxStyle.uncheckedBorderColor] The color of the checkbox border when it is not checked.
  final SeniorCheckboxStyle? style;

  /// The title of the checkbox.
  final String? title;

  /// The value passed to the [value] parameters of the internal [Checkbox].
  /// Whether this checkbox is checked.
  final bool value;

  /// disables the layout builder
  final bool disableLayoutBuilder;

  static const double size = Checkbox.width;

  void _handleValueChange() {
    if (!disabled && onChanged != null) {
      onChanged!(!value);
    }
  }

  Widget _buildCheckbox(SeniorThemeData theme) {
    final Color borderColor = disabled
        ? style?.disabledBorderColor ?? theme.checkboxTheme?.style?.disabledBorderColor ?? SeniorColors.grayscale30
        : value
            ? style?.checkedBorderColor ?? theme.checkboxTheme?.style?.checkedBorderColor ?? SeniorColors.primaryColor
            : style?.uncheckedBorderColor ??
                theme.checkboxTheme?.style?.uncheckedBorderColor ??
                SeniorColors.grayscale50;

    final Color checkColor = disabled
        ? style?.disabledCheckColor ?? theme.checkboxTheme?.style?.disabledCheckColor ?? SeniorColors.grayscale30
        : style?.checkColor ?? theme.checkboxTheme?.style?.checkColor ?? SeniorColors.primaryColor;

    return Container(
      width: SeniorCheckbox.size,
      height: SeniorCheckbox.size,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: borderColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Checkbox(
        side: const BorderSide(color: Colors.transparent),
        value: value,
        onChanged: (_) {},
        activeColor: Colors.transparent,
        checkColor: checkColor,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }

  Widget _buildTitle(SeniorThemeData theme) {
    return title != null
        ? Text(
            title!,
            style: _getTitleStyle(theme),
          )
        : const SizedBox.shrink();
  }

  TextStyle _getTitleStyle(SeniorThemeData theme) {
    return SeniorTypography.label(
      color: disabled
          ? style?.disabledTitleColor ?? theme.checkboxTheme?.style?.disabledTitleColor ?? SeniorColors.grayscale30
          : style?.titleColor ?? theme.checkboxTheme?.style?.titleColor ?? SeniorColors.grayscale90,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    if (disableLayoutBuilder) {
      return GestureDetector(
        onTap: actionOnTitle ? _handleValueChange : null,
        child: title == null
            ? _buildCheckbox(theme)
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: extraTapMargin,
                  ),
                  Padding(
                    padding: title != null ? const EdgeInsets.only(right: SeniorSpacing.xsmall) : EdgeInsets.zero,
                    child: Container(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 2.0), // Offsetting the line height of the checkbox title font
                        child: _buildCheckbox(theme),
                      ),
                    ),
                  ),
                  Expanded(child: _buildTitle(theme)),
                ],
              ),
      );
    } else {
      return LayoutBuilder(
        builder: (context, constraints) {
          final span = TextSpan(
            text: title,
            style: _getTitleStyle(theme),
          );
          final textPainter = TextPainter(text: span, textDirection: TextDirection.ltr);
          textPainter.layout(maxWidth: constraints.maxWidth);
          final numLines = textPainter.computeLineMetrics().length;

          return ListTileTheme.merge(
            child: Stack(
              alignment: numLines == 1 ? Alignment.centerLeft : Alignment.topLeft,
              children: [
                GestureDetector(
                  onTap: actionOnTitle ? _handleValueChange : null,
                  child: title == null
                      ? _buildCheckbox(theme)
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: extraTapMargin,
                            ),
                            Padding(
                              padding:
                                  title != null ? const EdgeInsets.only(right: SeniorSpacing.xsmall) : EdgeInsets.zero,
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 2.0), // Offsetting the line height of the checkbox title font
                                  child: _buildCheckbox(theme),
                                ),
                              ),
                            ),
                            Expanded(child: _buildTitle(theme)),
                          ],
                        ),
                ),
                GestureDetector(
                  onTap: _handleValueChange,
                  child: Container(
                    color: Colors.transparent,
                    width: extraTapMargin + size + extraTapMargin,
                    height: extraTapMargin + size + extraTapMargin,
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
  }
}
