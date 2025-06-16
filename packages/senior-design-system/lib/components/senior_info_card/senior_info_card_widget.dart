import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import './senior_info_card_style.dart';
import '../../repositories/theme_repository.dart';

class SeniorInfoCard extends StatelessWidget {
  /// Creates an Info Card type Card component.
  ///
  /// Displays a value and a legend. It has a customizable label color.
  /// The [label], [value] and [severityColor] parameters are required.
  const SeniorInfoCard({
    Key? key,
    this.canRequestFocus = true,
    this.focusNode,
    this.fullLength = false,
    required this.label,
    this.onDoubleTap,
    this.onFocusChange,
    this.onLongPress,
    this.onTap,
    required this.severityColor,
    this.style,
    required this.value,
  }) : super(key: key);

  /// Defines whether the card can receive focus.
  ///
  /// The default value is true.
  final bool canRequestFocus;

  /// Card's FocusNode. Lets you get information about the card's focus.
  final FocusNode? focusNode;

  /// Defines whether the width of the component will be all available space.
  ///
  /// The default value is false.
  final bool fullLength;

  /// Card label.
  final String label;

  /// Function performed whenever the card is double tapped.
  final Function()? onDoubleTap;

  /// Function performed whenever the card loses focus.
  final Function(bool)? onFocusChange;

  /// Function performed whenever a long press occurs on the card.
  final Function()? onLongPress;

  /// Function performed whenever the card is tapped.
  final Function()? onTap;

  /// Card accent color.
  final Color severityColor;

  /// The component's style definitions.
  /// Allows you to configure:
  /// [SeniorInfoCardStyle.color] the color of the card.
  /// [SeniorInfoCardStyle.infoColor] the color of the card information.
  /// [SeniorInfoCardStyle.labelColor] the color of the card label.
  final SeniorInfoCardStyle? style;

  /// The value shown on the card.
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    return InkWell(
      focusNode: focusNode,
      canRequestFocus: canRequestFocus,
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      onFocusChange: onFocusChange,
      child: Container(
        constraints: BoxConstraints(
          minHeight: 104.0,
          maxWidth: fullLength ? double.infinity : 104.0,
        ),
        padding: const EdgeInsets.only(
          top: SeniorSpacing.normal,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(
              SeniorRadius.xbig,
            ),
          ),
          color: style?.color ??
              theme.infoCardTheme?.style?.color ??
              SeniorColors.grayscale10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: SeniorSpacing.xxsmall,
                    ),
                    child: Text(
                      value,
                      maxLines: null,
                      style: SeniorTypography.h1(
                        color: style?.infoColor ??
                            theme.infoCardTheme?.style?.infoColor ??
                            SeniorColors.grayscale80,
                      ),
                    ),
                  ),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    style: SeniorTypography.small(
                      color: style?.labelColor ??
                          theme.infoCardTheme?.style?.labelColor ??
                          SeniorColors.grayscale60,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 4.0,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: severityColor,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(SeniorRadius.xbig),
                    bottomRight: Radius.circular(SeniorRadius.xbig)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
