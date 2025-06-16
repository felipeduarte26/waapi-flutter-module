import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/tokens/senior_colors.dart';

class LoadingWidget extends StatelessWidget {
  final Color? color;
  final double? size;
  final double? strokeWidth;
  final String bottomLabel;

  const LoadingWidget({
    super.key,
    this.color = SeniorColors.primaryColor,
    this.size,
    this.strokeWidth,
    required this.bottomLabel,
  });

  @override
  Widget build(BuildContext context) {
    SizedBox sizedBox = SizedBox(
      height: (bottomLabel.isEmpty ? 0 : 8),
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(
          child: SeniorLoading(),
        ),
        sizedBox,
        bottomLabel.isEmpty ? sizedBox : SeniorText.label(bottomLabel),
      ],
    );
  }
}
