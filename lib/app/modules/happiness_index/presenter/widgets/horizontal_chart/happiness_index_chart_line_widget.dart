import 'package:flutter/material.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../enums/happiness_index_mood_enum.dart';

const _milliSecondsAnimationDuration = 800;

class HappinessIndexChartLineWidget extends StatefulWidget {
  final double animatedContainerWidth;
  final HappinessIndexMoodEnum moodEnum;
  final Function() onTap;
  final Color color;
  final BorderRadius borderRadius;
  final BorderSide? border;

  const HappinessIndexChartLineWidget({
    Key? key,
    required this.animatedContainerWidth,
    required this.moodEnum,
    required this.color,
    required this.borderRadius,
    required this.border,
    required this.onTap,
  }) : super(key: key);

  @override
  State<HappinessIndexChartLineWidget> createState() => _HappinessIndexChartLineWidgetState();
}

class _HappinessIndexChartLineWidgetState extends State<HappinessIndexChartLineWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: AnimatedContainer(
        width: widget.animatedContainerWidth,
        height: SeniorSpacing.xmedium,
        duration: const Duration(
          milliseconds: _milliSecondsAnimationDuration,
        ),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: widget.borderRadius,
          border: Border.fromBorderSide(widget.border ?? BorderSide.none),
        ),
      ),
    );
  }
}
