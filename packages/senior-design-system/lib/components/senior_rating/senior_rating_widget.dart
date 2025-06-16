import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import './senior_rating_style.dart';
import '../../repositories/theme_repository.dart';

class SeniorRating extends StatelessWidget {
  /// Creates a Rating component.
  ///
  /// The [initialRating], [itemCount] and [onRatingUpdate] parameters are required.
  const SeniorRating({
    Key? key,
    this.allowHalfRating = false,
    this.direction = Axis.horizontal,
    this.disabled = false,
    this.ignoreGestures = false,
    required this.initialRating,
    required this.itemCount,
    this.itemPadding =
        const EdgeInsets.symmetric(horizontal: SeniorSpacing.xxsmall),
    this.itemSize = 16.0,
    required this.onRatingUpdate,
    this.style,
  }) : super(key: key);

  /// Defines total number of rating bar items.
  ///
  /// Default is 5.
  final int itemCount;

  /// Defines the initial rating to be set to the rating bar.
  final double initialRating;

  /// Return current rating whenever rating is updated.
  ///
  /// [updateOnDrag] can be used to change the behaviour how the callback
  /// reports the update.
  final Function(double) onRatingUpdate;

  /// Defines whether half-rating will be supported.
  ///
  /// Default is false.
  final bool allowHalfRating;

  /// Direction of rating bar.
  ///
  /// Default = Axis.horizontal.
  final Axis direction;

  /// if set to true, will disable any gestures over the rating bar.
  ///
  /// Default is false.
  final bool ignoreGestures;

  /// Defines width and height of each rating item in the bar.
  ///
  /// Default is 16.0.
  final double itemSize;

  /// The amount of space by which to inset each rating item.
  ///
  /// Default is [SeniorSpacing.xxsmall] horizontally.
  final EdgeInsetsGeometry itemPadding;

  /// Defines whether the rating bar will be disabled.
  ///
  /// Default is false.
  final bool disabled;

  /// The component's style definitions.
  ///
  /// Allows you to configure:
  /// [SeniorRatingStyle.iconColor] the color of the icons.
  /// [SeniorRatingStyle.disabledIconColor] the color of icons when disabled.
  final SeniorRatingStyle? style;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    final Color? iconColor = disabled
        ? style?.disabledIconColor ??
            theme.ratingTheme?.style?.disabledIconColor ??
            SeniorColors.grayscale40
        : style?.iconColor ??
            theme.ratingTheme?.style?.iconColor ??
            SeniorColors.manchesterColorOrange300;

    return RatingBar(
      allowHalfRating: allowHalfRating,
      direction: direction,
      ignoreGestures: disabled || ignoreGestures,
      initialRating: initialRating,
      itemCount: itemCount,
      itemPadding: itemPadding,
      itemSize: itemSize,
      onRatingUpdate: onRatingUpdate,
      ratingWidget: RatingWidget(
        full: Icon(
          FontAwesomeIcons.solidStar,
          color: iconColor,
          size: SeniorIconSize.small,
        ),
        half: Icon(
          FontAwesomeIcons.starHalfStroke,
          color: iconColor,
          size: SeniorIconSize.small,
        ),
        empty: Icon(
          FontAwesomeIcons.star,
          color: iconColor,
          size: SeniorIconSize.small,
        ),
      ),
    );
  }
}
