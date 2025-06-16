import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import './senior_progress_bar_style.dart';
import '../../repositories/theme_repository.dart';

class SeniorProgressBar extends StatelessWidget {
  ///  Creates the SDS ProgressBar component.
  ///
  /// The [currentStep] and [totalSteps] parameters are required.
  const SeniorProgressBar({
    Key? key,
    required this.currentStep,
    this.showCurrentStep = false,
    this.style,
    this.subtitle,
    this.title,
    required this.totalSteps,
  })  : assert(currentStep <= totalSteps),
        assert(title != null && subtitle != null ||
            title == null && subtitle == null),
        super(key: key);

  /// The current step of the scrollbar.
  /// The value of this parameter must be less than the value of the [totalSteps] parameter.
  final int currentStep;

  /// The total scrollbar steps.
  /// The value of this parameter must be greater than the value of the [currentStep] parameter.
  final int totalSteps;

  /// Defines whether to display a label that shows the current step.
  ///
  /// The default value is false.
  final bool showCurrentStep;

  /// The component's style definitions.
  /// Allows you to configure:
  /// [SeniorProgressBarStyle.backgroundColor] the background color of the scrollbar.
  /// [SeniorProgressBarStyle.color] the color of the current scrollbar level.
  /// [SeniorProgressBarStyle.progressInfoColor] the color of the current progress information.
  /// [SeniorProgressBarStyle.subtitleColor] the color of the subtitle shown in the component.
  /// [SeniorProgressBarStyle.titleColor] the color of the title shown on the component.
  final SeniorProgressBarStyle? style;

  /// The subtitle of the progress bar.
  final String? subtitle;

  /// The title of the progress bar.
  final String? title;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            title != null && subtitle != null
                ? Row(
                    children: [
                      Text(
                        '$title: ',
                        style: SeniorTypography.label(
                          color: style?.titleColor ??
                              theme.progressBarTheme?.style?.titleColor ??
                              SeniorColors.grayscale90,
                        ),
                      ),
                      Text(
                        subtitle!,
                        style: SeniorTypography.body(
                          color: style?.subtitleColor ??
                              theme.progressBarTheme?.style?.subtitleColor ??
                              SeniorColors.grayscale60,
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
            showCurrentStep
                ? Text(
                    '$currentStep/$totalSteps',
                    style: SeniorTypography.body(
                      color: style?.progressInfoColor ??
                          theme.progressBarTheme?.style?.progressInfoColor ??
                          SeniorColors.grayscale90,
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
        const SizedBox(height: SeniorSpacing.xsmall),
        LinearProgressIndicator(
          color: style?.color ??
              theme.progressBarTheme?.style?.color ??
              SeniorColors.primaryColor400,
          backgroundColor: style?.backgroundColor ??
              theme.progressBarTheme?.style?.backgroundColor ??
              SeniorColors.grayscale20,
          minHeight: 8.0,
          value: currentStep / totalSteps,
        ),
      ],
    );
  }
}
