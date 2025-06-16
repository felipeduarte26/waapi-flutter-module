import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../repositories/theme_repository.dart';
import '../../theme/senior_theme_data.dart';
import '../senior_checkbox/senior_checkbox_widget.dart';
import '../senior_elevated_element/senior_elevated_element_wiget.dart';

/// The types of buttons for the Senior Square Button MenuItem component.
/// It can be [SeniorSquareButtonsMenuItemType.emphasis], [SeniorSquareButtonsMenuItemType.neutral] and
/// [SeniorSquareButtonsMenuItemType.ghost].
enum SeniorSquareButtonsMenuItemType {
  emphasis,
  emphasisNegative,
  neutral,
  neutralNegative,
  ghost,
  ghostNegative,
}

class SeniorSquareButtonsMenuItemData {
  /// Information for creating a Senior Square Buttons Menu component button.
  ///
  /// The [icon], [onTap], [text] and [type] parameters are required.
  SeniorSquareButtonsMenuItemData({
    this.key,
    this.disabled = false,
    required this.icon,
    required this.onTap,
    required this.text,
    required this.type,
    this.withElevation = false,
  }) {
    isChecked = false;
    onCheck = (_) {};
    withCheckbox = false;
  }

  /// Information for creating a checkboxed button from the SeniorSquareButtonsMenu component.
  ///
  /// The [icon], [isChecked], [onCheck], [onTap], [text] and [type] parameters are required.
  SeniorSquareButtonsMenuItemData.checkbox({
    this.key,
    this.disabled = false,
    required this.icon,
    required this.isChecked,
    required this.onCheck,
    required this.onTap,
    required this.text,
    required this.type,
    this.withElevation = false,
  }) {
    withCheckbox = true;
  }

  /// Key for the button.
  final Key? key;

  /// Defines if the button will be disabled.
  final bool disabled;

  /// The button icon.
  final IconData icon;

  /// Callback function executed when the button is tapped.
  final Function() onTap;

  /// The button text.
  final String text;

  /// The button type.
  /// It can be [SeniorSquareButtonsMenuItemType.emphasis] [SeniorSquareButtonsMenuItemType.emphasisNegative],
  /// [SeniorSquareButtonsMenuItemType.neutral], [SeniorSquareButtonsMenuItemType.neutralNegative],
  /// [SeniorSquareButtonsMenuItemType.ghost] and [SeniorSquareButtonsMenuItemType.ghostNegative].
  final SeniorSquareButtonsMenuItemType type;

  /// Defines whether the button will have elevation.
  ///
  /// The default value is false.
  final bool withElevation;

  /// Defines whether the button's checkbox will be checked.
  late final bool isChecked;

  /// Callback function executed when checkbox is checked or unchecked.
  late final Function(bool?) onCheck;
  late final bool withCheckbox;
}

class SeniorSquareButtonsMenu extends StatelessWidget {
  /// Creates the SDS Square Buttons Menu component.
  ///
  /// The [items] parameter is required.
  const SeniorSquareButtonsMenu({
    required this.items,
    this.paddingListView = EdgeInsets.zero,
    Key? key,
  }) : super(key: key);

  /// The list of menu buttons.
  final List<SeniorSquareButtonsMenuItemData> items;

  /// A padding that will be added to the component.
  ///
  /// The default value is [EdgeInsets.zero] on Listview.
  final EdgeInsetsGeometry paddingListView;

  /// Creates the Square Buttons Menu component in grid format.
  ///
  /// The [items] parameter is required.
  factory SeniorSquareButtonsMenu.grid({
    Key? key,
    required List<SeniorSquareButtonsMenuItemData> items,
    int crossAxisCount,
    double crossAxisSpacing,
    double mainAxisSpacing,
  }) = _SeniorSquadButtonsMenuGrid;

  _ButtonColors _getButtonColors(SeniorSquareButtonsMenuItemData item, SeniorThemeData theme) {
    switch (item.type) {
      case SeniorSquareButtonsMenuItemType.emphasis:
        return _ButtonColors(
          backgroundColor: item.disabled
              ? theme.emphasisSquareButtonsMenuTheme?.style?.disabledBackgroundColor ??
                  SeniorColors.primaryColor.withOpacity(0.5)
              : theme.emphasisSquareButtonsMenuTheme?.style?.backgroundColor ?? SeniorColors.primaryColor,
          backgroundGradientColors: item.disabled
              ? theme.emphasisSquareButtonsMenuTheme?.style?.disabledBackgroundGradientColors ?? null
              : theme.emphasisSquareButtonsMenuTheme?.style?.backgroundGradientColors ??
                  SeniorColors.primaryGradientColors,
          borderColor: item.disabled
              ? theme.emphasisSquareButtonsMenuTheme?.style?.disabledBorderColor ?? Colors.transparent
              : theme.emphasisSquareButtonsMenuTheme?.style?.borderColor ?? Colors.transparent,
          fontColor: item.disabled
              ? theme.emphasisSquareButtonsMenuTheme?.style?.disabledFontColor ?? SeniorColors.pureWhite
              : theme.emphasisSquareButtonsMenuTheme?.style?.fontColor ?? SeniorColors.pureWhite,
          iconColor: item.disabled
              ? theme.emphasisSquareButtonsMenuTheme?.style?.disabledIconColor ?? SeniorColors.pureWhite
              : theme.emphasisSquareButtonsMenuTheme?.style?.iconColor ?? SeniorColors.pureWhite,
        );
      case SeniorSquareButtonsMenuItemType.emphasisNegative:
        return _ButtonColors(
          backgroundColor: item.disabled
              ? theme.emphasisNegativeSquareButtonsMenuTheme?.style?.disabledBackgroundColor ??
                  SeniorColors.grayscale5.withOpacity(0.5)
              : theme.emphasisNegativeSquareButtonsMenuTheme?.style?.backgroundColor ?? SeniorColors.grayscale5,
          backgroundGradientColors: item.disabled
              ? theme.emphasisNegativeSquareButtonsMenuTheme?.style?.disabledBackgroundGradientColors ?? null
              : theme.emphasisNegativeSquareButtonsMenuTheme?.style?.backgroundGradientColors ?? null,
          borderColor: item.disabled
              ? theme.emphasisNegativeSquareButtonsMenuTheme?.style?.disabledBorderColor ??
                  SeniorColors.primaryColor.withOpacity(0.5)
              : theme.emphasisNegativeSquareButtonsMenuTheme?.style?.borderColor ?? SeniorColors.primaryColor,
          fontColor: item.disabled
              ? theme.emphasisNegativeSquareButtonsMenuTheme?.style?.disabledFontColor ?? SeniorColors.grayscale50
              : theme.emphasisNegativeSquareButtonsMenuTheme?.style?.fontColor ?? SeniorColors.grayscale50,
          iconColor: item.disabled
              ? theme.emphasisNegativeSquareButtonsMenuTheme?.style?.disabledIconColor ?? SeniorColors.primaryColor
              : theme.emphasisNegativeSquareButtonsMenuTheme?.style?.iconColor ?? SeniorColors.primaryColor,
        );
      case SeniorSquareButtonsMenuItemType.neutral:
        return _ButtonColors(
          backgroundColor: item.disabled
              ? theme.neutralSquareButtonsMenuTheme?.style?.disabledBackgroundColor ??
                  SeniorColors.grayscale50.withOpacity(0.5)
              : theme.neutralSquareButtonsMenuTheme?.style?.backgroundColor ?? SeniorColors.grayscale50,
          backgroundGradientColors: item.disabled
              ? theme.neutralSquareButtonsMenuTheme?.style?.disabledBackgroundGradientColors ?? null
              : theme.neutralSquareButtonsMenuTheme?.style?.backgroundGradientColors ?? null,
          borderColor: item.disabled
              ? theme.neutralSquareButtonsMenuTheme?.style?.disabledBorderColor ?? Colors.transparent
              : theme.neutralSquareButtonsMenuTheme?.style?.borderColor ?? Colors.transparent,
          fontColor: item.disabled
              ? theme.neutralSquareButtonsMenuTheme?.style?.disabledFontColor ?? SeniorColors.pureWhite
              : theme.neutralSquareButtonsMenuTheme?.style?.fontColor ?? SeniorColors.pureWhite,
          iconColor: item.disabled
              ? theme.neutralSquareButtonsMenuTheme?.style?.disabledIconColor ?? SeniorColors.pureWhite
              : theme.neutralSquareButtonsMenuTheme?.style?.iconColor ?? SeniorColors.pureWhite,
        );
      case SeniorSquareButtonsMenuItemType.neutralNegative:
        return _ButtonColors(
          backgroundColor: item.disabled
              ? theme.neutralNegativeSquareButtonsMenuTheme?.style?.disabledBackgroundColor ??
                  SeniorColors.grayscale5.withOpacity(0.5)
              : theme.neutralNegativeSquareButtonsMenuTheme?.style?.backgroundColor ?? SeniorColors.grayscale5,
          backgroundGradientColors: item.disabled
              ? theme.neutralNegativeSquareButtonsMenuTheme?.style?.disabledBackgroundGradientColors ?? null
              : theme.neutralNegativeSquareButtonsMenuTheme?.style?.backgroundGradientColors ?? null,
          borderColor: item.disabled
              ? theme.neutralNegativeSquareButtonsMenuTheme?.style?.disabledBorderColor ??
                  SeniorColors.grayscale50.withOpacity(0.5)
              : theme.neutralNegativeSquareButtonsMenuTheme?.style?.borderColor ?? SeniorColors.grayscale50,
          fontColor: item.disabled
              ? theme.neutralNegativeSquareButtonsMenuTheme?.style?.disabledFontColor ?? SeniorColors.grayscale50
              : theme.neutralNegativeSquareButtonsMenuTheme?.style?.fontColor ?? SeniorColors.grayscale50,
          iconColor: item.disabled
              ? theme.neutralNegativeSquareButtonsMenuTheme?.style?.disabledIconColor ?? SeniorColors.grayscale50
              : theme.neutralNegativeSquareButtonsMenuTheme?.style?.iconColor ?? SeniorColors.grayscale50,
        );
      case SeniorSquareButtonsMenuItemType.ghost:
        return _ButtonColors(
          backgroundColor: item.disabled
              ? theme.ghostSquareButtonsMenuTheme?.style?.disabledBackgroundColor ?? Colors.transparent
              : theme.ghostSquareButtonsMenuTheme?.style?.backgroundColor ?? Colors.transparent,
          backgroundGradientColors: item.disabled
              ? theme.ghostSquareButtonsMenuTheme?.style?.disabledBackgroundGradientColors ?? null
              : theme.ghostSquareButtonsMenuTheme?.style?.backgroundGradientColors ?? null,
          borderColor: item.disabled
              ? theme.ghostSquareButtonsMenuTheme?.style?.disabledBorderColor ??
                  SeniorColors.grayscale50.withOpacity(0.5)
              : theme.ghostSquareButtonsMenuTheme?.style?.borderColor ?? SeniorColors.grayscale50,
          fontColor: item.disabled
              ? theme.ghostSquareButtonsMenuTheme?.style?.disabledFontColor ?? SeniorColors.grayscale50
              : theme.ghostSquareButtonsMenuTheme?.style?.fontColor ?? SeniorColors.grayscale50,
          iconColor: item.disabled
              ? theme.ghostSquareButtonsMenuTheme?.style?.disabledIconColor ?? SeniorColors.grayscale50
              : theme.ghostSquareButtonsMenuTheme?.style?.iconColor ?? SeniorColors.grayscale50,
        );
      case SeniorSquareButtonsMenuItemType.ghostNegative:
        return _ButtonColors(
          backgroundColor: item.disabled
              ? theme.ghostNegativeSquareButtonsMenuTheme?.style?.disabledBackgroundColor ??
                  SeniorColors.grayscale5.withOpacity(0.5)
              : theme.ghostNegativeSquareButtonsMenuTheme?.style?.backgroundColor ?? SeniorColors.grayscale5,
          backgroundGradientColors: item.disabled
              ? theme.ghostNegativeSquareButtonsMenuTheme?.style?.disabledBackgroundGradientColors ?? null
              : theme.ghostNegativeSquareButtonsMenuTheme?.style?.backgroundGradientColors ?? null,
          borderColor: item.disabled
              ? theme.ghostNegativeSquareButtonsMenuTheme?.style?.disabledBorderColor ??
                  SeniorColors.grayscale50.withOpacity(0.5)
              : theme.ghostNegativeSquareButtonsMenuTheme?.style?.borderColor ?? SeniorColors.grayscale50,
          fontColor: item.disabled
              ? theme.ghostNegativeSquareButtonsMenuTheme?.style?.disabledFontColor ?? SeniorColors.grayscale50
              : theme.ghostNegativeSquareButtonsMenuTheme?.style?.fontColor ?? SeniorColors.grayscale50,
          iconColor: item.disabled
              ? theme.ghostNegativeSquareButtonsMenuTheme?.style?.disabledIconColor ?? SeniorColors.grayscale50
              : theme.ghostNegativeSquareButtonsMenuTheme?.style?.iconColor ?? SeniorColors.grayscale50,
        );
    }
  }

  Widget _buildMenuItem(SeniorSquareButtonsMenuItemData item, double itemsSize, SeniorThemeData theme) {
    final iconSize = itemsSize * 0.22;
    final smallSize = itemsSize < 100.0;

    const borderRadius = 12.0;
    const strokeWidth = 1.0;
    final buttonColors = _getButtonColors(item, theme);

    final buttonContent = Ink(
      padding: const EdgeInsets.all(
        SeniorSpacing.xsmall,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          borderRadius,
        ),
        gradient: buttonColors.backgroundGradientColors != null
            ? LinearGradient(colors: buttonColors.backgroundGradientColors!)
            : null,
        color: buttonColors.backgroundColor,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Visibility(
            visible: item.withCheckbox && !smallSize,
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    SeniorRadius.small,
                  ),
                ),
                child: SeniorCheckbox(
                  value: item.isChecked,
                  onChanged: item.onCheck,
                ),
              ),
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: !smallSize ? MainAxisAlignment.center : MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: SeniorSpacing.xmedium,
                      child: Icon(
                        item.icon,
                        color: SeniorColors.primaryColor,
                        size: iconSize,
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: !smallSize,
                  child: Flexible(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: itemsSize * 0.12,
                      ),
                      child: Text(
                        item.text,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: SeniorTypography.smallBold(
                          color: buttonColors.fontColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return SeniorElevatedElement(
      elevation: item.withElevation && buttonColors.backgroundColor != Colors.transparent
          ? SeniorElevations.dp01
          : SeniorElevations.dp0,
      borderRadius: borderRadius,
      child: Container(
        height: itemsSize,
        width: itemsSize,
        child: Tooltip(
          message: item.text,
          padding: EdgeInsets.zero,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(borderRadius),
              onTap: item.onTap,
              child: item.type == SeniorSquareButtonsMenuItemType.ghost ||
                      item.type == SeniorSquareButtonsMenuItemType.ghostNegative
                  ? DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(borderRadius),
                      padding: const EdgeInsets.all(0),
                      color: buttonColors.borderColor,
                      strokeWidth: strokeWidth,
                      child: buttonContent,
                    )
                  : Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: buttonColors.borderColor,
                          width: strokeWidth,
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(borderRadius)),
                      ),
                      child: buttonContent,
                    ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    return Container(
      height: 110,
      child: ListView.separated(
        padding: paddingListView,
        itemCount: items.length,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) {
          return const SizedBox(
            width: SeniorSpacing.xsmall,
          );
        },
        itemBuilder: (context, index) {
          final item = items[index];
          const double itemsSize = 110.0;
          return _buildMenuItem(item, itemsSize, theme);
        },
      ),
    );
  }
}

class _SeniorSquadButtonsMenuGrid extends SeniorSquareButtonsMenu {
  late final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;

  _SeniorSquadButtonsMenuGrid({
    Key? key,
    required List<SeniorSquareButtonsMenuItemData> items,
    int crossAxisCount = 3,
    this.crossAxisSpacing = SeniorSpacing.xsmall,
    this.mainAxisSpacing = SeniorSpacing.xsmall,
  }) : super(key: key, items: items) {
    this.crossAxisCount = crossAxisCount <= 6 ? crossAxisCount : 6;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    return Container(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double menuWidth = constraints.constrainWidth();
          int slots = items.length;
          while (slots % crossAxisCount != 0) {
            slots++;
          }
          final double itemsSize = (menuWidth - (8 * (crossAxisCount - 1))) / crossAxisCount;

          return GridView.count(
            shrinkWrap: true,
            crossAxisSpacing: crossAxisSpacing,
            mainAxisSpacing: mainAxisSpacing,
            crossAxisCount: crossAxisCount,
            physics: const RangeMaintainingScrollPhysics(),
            children: items.map((item) => _buildMenuItem(item, itemsSize, theme)).toList(),
          );
        },
      ),
    );
  }
}

class _ButtonColors {
  const _ButtonColors({
    required this.backgroundColor,
    this.backgroundGradientColors,
    required this.borderColor,
    required this.fontColor,
    required this.iconColor,
  });

  final Color backgroundColor;
  final List<Color>? backgroundGradientColors;
  final Color borderColor;
  final Color fontColor;
  final Color iconColor;
}
