import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import './senior_card_style.dart';
import './models/models.dart';
import '../../components/senior_elevated_element/senior_elevated_element.dart';
import '../../components/senior_checkbox/senior_checkbox.dart';
import '../../repositories/theme_repository.dart';
import '../../theme/senior_theme_data.dart';

class SeniorCard extends StatelessWidget {
  /// Creates the SDS card component.
  /// The parameter [child] is required.
  const SeniorCard({
    Key? key,
    this.checkboxConfig,
    required this.child,
    this.disabled = false,
    this.dismissibleConfig,
    this.height,
    this.highLightBorder,
    this.leftIcon,
    this.leftIconColor,
    this.margin,
    this.onTap,
    this.onLongPress,
    this.outlined = false,
    this.padding,
    this.rightIcon,
    this.rightIconColor,
    this.style,
    this.width,
    this.withElevation = false,
    this.withQuotes = false,
  }) : super(key: key);

  /// The information to add a checkbox to the card.
  final CardCheckboxConfig? checkboxConfig;

  /// The contents of the card.
  final Widget child;

  /// Whether the card will be disabled.
  /// The default value is false.
  final bool disabled;

  /// The information to add the dismissible behavior to the card.
  /// Allows you to dismiss the card and perform an action when dragged from left to right or right to left.
  final CardDismissibleConfig? dismissibleConfig;

  /// The card height.
  final double? height;

  /// Highlight border settings on card. Allows you to add an accent color to the left or below the edge of the card.
  final CardHighLightBorder? highLightBorder;

  /// An icon that will appear to the left of the content.
  final IconData? leftIcon;

  /// The color of the icon to the left of the content.
  final Color? leftIconColor;

  /// The card margin.
  /// The default value is [SeniorSpacing.xxsmall] (4 logical pixels) on all sides.
  final EdgeInsets? margin;

  /// Callback function that will be executed when the card is played.
  final VoidCallback? onTap;

  /// Callback function that will be executed when a long press occurs.
  final VoidCallback? onLongPress;

  /// Defines the border color of the card.
  /// The default value is false.
  final bool outlined;

  /// The card padding.
  /// The default value is [SeniorSpacing.small] (12 logical pixels) on all sides.
  final EdgeInsets? padding;

  /// An icon that will appear to the right of the content.
  final IconData? rightIcon;

  /// The color of the icon to the right of the content.
  final Color? rightIconColor;

  /// The style definitions for the component.
  /// Allows you to configure:
  /// [SeniorCardStyle.backgroundColor] the card's background color.
  /// [SeniorCardStyle.disabledBackgroundColor] the card's background color when it's disabled.
  /// [SeniorCardStyle.iconColor] the color of the card's icon.
  /// [SeniorCardStyle.quotesColor] the color of quotes characters.
  final SeniorCardStyle? style;

  /// The card width.
  final double? width;

  /// Whether the card will have an elevation.
  /// The default value is false.
  final bool withElevation;

  /// Whether the card will wrap its content with quotes characters.
  /// The default value is false.
  final bool withQuotes;

  Alignment _getCheckAligmnet() {
    if (checkboxConfig == null) {
      return Alignment.topLeft;
    }

    switch (checkboxConfig!.position) {
      case CardCheckboxPosition.left:
        return leftIcon != null ? Alignment.topLeft : Alignment.centerLeft;
      case CardCheckboxPosition.right:
        return Alignment.topRight;
    }
  }

  Border _getBorder() {
    if (highLightBorder == null) {
      return const Border();
    }

    const borderWidth = 6.0;

    final BorderSide borderSide = BorderSide(
      width: borderWidth,
      color: highLightBorder!.color,
    );

    switch (highLightBorder!.position) {
      case CardBorderPosition.left:
        return Border(left: borderSide);
      case CardBorderPosition.bottom:
        return Border(bottom: borderSide);
      default:
        return const Border();
    }
  }

  Widget _addQuotesToChild(SeniorThemeData theme) {
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                '“',
                style: SeniorTypography.h1(
                  color: style?.quotesColor ?? theme.cardTheme?.style?.quotesColor ?? SeniorColors.grayscale60,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -20, // I need to compensate for the fact that this character is taller than the others.
            right: 0,
            child: Text(
              '”',
              style: SeniorTypography.h1(
                color: style?.quotesColor ?? theme.cardTheme?.style?.quotesColor ?? SeniorColors.grayscale60,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: SeniorSpacing.xmedium),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _buildCard(SeniorThemeData theme) {
    const cardBorderRadius = 12.0;
    const cardMinHeight = 56.0;
    const cardMinWidth = 56.0;

    return Opacity(
      opacity: disabled ? 0.50 : 1.0,
      child: InkWell(
        onTap: onTap,
        onLongPress: !disabled ? onLongPress : null,
        child: Container(
          child: SeniorElevatedElement(
            borderRadius: cardBorderRadius,
            elevation: withElevation &&
                    !disabled &&
                    (theme.themeType == ThemeType.light || theme.themeType == ThemeType.custom)
                ? SeniorElevations.dp01
                : SeniorElevations.dp0,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                onLongPress: onLongPress,
                child: Ink(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    color: disabled
                        ? style?.disabledBackgroundColor ??
                            theme.cardTheme?.style?.disabledBackgroundColor ??
                            SeniorColors.grayscale20
                        : withElevation
                            ? style?.backgroundColor ??
                                theme.cardTheme?.style?.backgroundColorIfElevated ??
                                SeniorColors.pureWhite
                            : style?.backgroundColor ??
                                theme.cardTheme?.style?.backgroundColor ??
                                SeniorColors.grayscale20,
                    borderRadius: BorderRadius.circular(cardBorderRadius),
                    border: outlined
                        ? Border.all(
                            color: style?.outlinedColor ??
                                theme.cardTheme?.style?.outlinedColor ??
                                SeniorColors.grayscale40,
                            width: 1.0,
                          )
                        : null,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(cardBorderRadius),
                    child: Container(
                      padding: padding ?? const EdgeInsets.all(SeniorSpacing.small),
                      decoration: BoxDecoration(
                        border: _getBorder(),
                      ),
                      child: Stack(
                        children: [
                          checkboxConfig != null
                              ? Positioned.fill(
                                  child: Align(
                                    alignment: _getCheckAligmnet(),
                                    child: SeniorCheckbox(
                                      onChanged: checkboxConfig!.onChange,
                                      value: checkboxConfig!.value,
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                          Row(
                            children: [
                              leftIcon != null ||
                                      (checkboxConfig != null && checkboxConfig!.position == CardCheckboxPosition.left)
                                  ? Container(
                                      padding: checkboxConfig != null &&
                                              checkboxConfig!.position == CardCheckboxPosition.left
                                          ? const EdgeInsets.all(SeniorSpacing.xxxsmall)
                                          : EdgeInsets.zero,
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: SeniorSpacing.small),
                                        child: Icon(
                                          leftIcon,
                                          size: SeniorIconSize.small,
                                          color: leftIconColor ??
                                              style?.iconColor ??
                                              theme.cardTheme?.style?.iconColor ??
                                              SeniorColors.grayscale80,
                                        ),
                                      ),
                                    )
                                  : const SizedBox.shrink(), // Itens esquerda
                              Expanded(
                                child: Container(
                                  constraints: const BoxConstraints(
                                    minHeight: cardMinHeight,
                                    minWidth: cardMinWidth,
                                  ),
                                  child: withQuotes ? _addQuotesToChild(theme) : child,
                                ),
                              ), // Conteúdo
                              rightIcon != null ||
                                      (checkboxConfig != null && checkboxConfig!.position == CardCheckboxPosition.right)
                                  ? Container(
                                      padding: checkboxConfig != null &&
                                              checkboxConfig!.position == CardCheckboxPosition.right
                                          ? const EdgeInsets.all(SeniorSpacing.xxxsmall)
                                          : EdgeInsets.zero,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: SeniorSpacing.small),
                                        child: Icon(
                                          rightIcon,
                                          size: SeniorIconSize.small,
                                          color: rightIconColor ??
                                              style?.iconColor ??
                                              theme.cardTheme?.style?.iconColor ??
                                              SeniorColors.grayscale80,
                                        ),
                                      ),
                                    )
                                  : const SizedBox.shrink(), // Itens direita
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
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
    const cardBorderRadius = 12.0;

    return Padding(
      padding: margin ?? const EdgeInsets.all(SeniorSpacing.xxsmall),
      child: dismissibleConfig != null && !disabled
          ? Dismissible(
              key: dismissibleConfig!.key,
              onDismissed: (direction) {
                if (direction == DismissDirection.startToEnd) {
                  dismissibleConfig!.primaryAction.onDismissed();
                } else if (direction == DismissDirection.endToStart) {
                  dismissibleConfig!.secondaryAction != null
                      ? dismissibleConfig!.secondaryAction!.onDismissed()
                      : dismissibleConfig!.primaryAction.onDismissed();
                }
              },
              background: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(cardBorderRadius),
                  color: dismissibleConfig!.primaryAction.backgroundColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: SeniorSpacing.medium,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      dismissibleConfig!.primaryAction.icon,
                      color: SeniorColors.pureWhite,
                      size: SeniorIconSize.medium,
                    ),
                  ),
                ),
              ),
              secondaryBackground: dismissibleConfig!.secondaryAction != null
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(cardBorderRadius),
                        color: dismissibleConfig!.secondaryAction!.backgroundColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: SeniorSpacing.medium,
                        ),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            dismissibleConfig!.secondaryAction!.icon,
                            color: SeniorColors.pureWhite,
                            size: SeniorIconSize.medium,
                          ),
                        ),
                      ),
                    )
                  : null,
              child: _buildCard(theme),
            )
          : _buildCard(theme),
    );
  }
}
