import 'package:flutter/material.dart';

import './card_border_position.dart';

class CardHighLightBorder {
  /// Defines an accent color for the edge of the card.
  /// The [color] and [position] parameters are required.
  const CardHighLightBorder({
    required this.color,
    required this.position,
  });

  /// The color of highlight.
  final Color color;

  /// The positions of the highlight.
  final CardBorderPosition position;
}
