// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../components/senior_stepper/senior_stepper.dart';
import '../../theme/senior_theme_data.dart';
import '../../repositories/theme_repository.dart';

class SeniorStepper extends StatelessWidget {
  /// Creates a Stepper component according to SDS.
  ///
  /// The [steps] and [current] parameters are required.
  const SeniorStepper({
    Key? key,
    required this.current,
    this.roundedBorders = true,
    required this.steps,
    this.style,
  }) : super(key: key);

  /// Whether the edges of the steps will be rounded.
  /// The default value is true.
  final bool roundedBorders;

  ///Indicates the current position on the stepper
  final int current;

  ///Defines the number of steps the component will have
  final int steps;

  /// Allows you to configure:
  /// [SeniorStepperStyle.completedStepColor] the color for the completed steps.
  /// [SeniorStepperStyle.currentStepColor] the color of the current step.
  /// [SeniorStepperStyle.uncompletedStepColor] the color for uncompleted steps.
  final SeniorStepperStyle? style;

  Widget _buildStepper(SeniorThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (int i = 1; i <= steps; i++)
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: i == steps ? 0 : SeniorSpacing.xxsmall,
              ),
              child: AnimatedContainer(
                height: SeniorSpacing.xxsmall,
                decoration: BoxDecoration(
                  borderRadius: roundedBorders
                      ? BorderRadius.circular(4.0)
                      : BorderRadius.zero,
                  color: (i == current)
                      ? style?.currentStepColor ??
                          theme.stepperTheme?.style?.currentStepColor ??
                          SeniorColors.primaryColor400
                      : (i < current)
                          ? style?.completedStepColor ??
                              theme.stepperTheme?.style?.completedStepColor ??
                              SeniorColors.primaryColor200
                          : style?.uncompletedStepColor ??
                              theme.stepperTheme?.style?.uncompletedStepColor ??
                              SeniorColors.grayscale30,
                ),
                duration: const Duration(
                  milliseconds: 200,
                ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    return _buildStepper(theme);
  }
}
