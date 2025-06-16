import 'dart:math';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import './senior_slider_dots_style.dart';
import '../../repositories/theme_repository.dart';

class SeniorSliderDots extends StatefulWidget {
  /// Creates the SliderDots component of the design system.
  /// The [currentPage] and [length] parameters are required.
  const SeniorSliderDots({
    Key? key,
    required this.currentPage,
    required this.length,
    this.style,
  }) : super(key: key);

  /// The index of the current page.
  final int currentPage;

  /// The number of pages managed by the component.
  final int length;

  /// The style definitions for the component.
  /// Allows you to configure:
  /// [SeniorSliderDotsStyle.activeColor] the color of active dot representing the current page.
  /// [SeniorSliderDotsStyle.defaultColor] the color of points that are not active.
  final SeniorSliderDotsStyle? style;

  @override
  State<SeniorSliderDots> createState() => _SeniorSliderDotsState();
}

class _SeniorSliderDotsState extends State<SeniorSliderDots> {
  final double _dotSize = 10.0;
  final int _limitDots = 8;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    final Color activeColor = widget.style?.activeColor ??
        theme.sliderDotsTheme?.style?.activeColor ??
        SeniorColors.primaryColor600;

    final Color defaultColor = widget.style?.defaultColor ??
        theme.sliderDotsTheme?.style?.defaultColor ??
        SeniorColors.grayscale20;

    final int displacement =
        widget.length > _limitDots ? (widget.length - _limitDots) ~/ 2 : 0;
    final amountDots = min(_limitDots, widget.length);
    final List<Widget> dots = [];

    if (amountDots < widget.length && widget.currentPage != 0) {
      dots.add(Container(
        margin: const EdgeInsets.all(SeniorSpacing.xxsmall),
        child: FaIcon(
          FontAwesomeIcons.caretLeft,
          size: SeniorIconSize.xsmall,
          color: widget.currentPage < displacement ? activeColor : defaultColor,
        ),
      ));
    }

    for (int i = 0; i < amountDots; i++) {
      dots.add(
        Container(
          margin: const EdgeInsets.all(SeniorSpacing.xxsmall),
          width: _dotSize,
          height: _dotSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.currentPage == i + displacement ||
                    widget.currentPage == 0 && i == 0 ||
                    widget.currentPage == widget.length - 1 &&
                        i == amountDots - 1
                ? activeColor
                : defaultColor,
          ),
        ),
      );
    }

    if (amountDots < widget.length && widget.currentPage != widget.length - 1) {
      dots.add(Container(
        margin: const EdgeInsets.all(SeniorSpacing.xxsmall),
        child: FaIcon(
          FontAwesomeIcons.caretRight,
          size: SeniorIconSize.xsmall,
          color: widget.currentPage > _limitDots - 1 + displacement
              ? activeColor
              : defaultColor,
        ),
      ));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: dots,
    );
  }
}
