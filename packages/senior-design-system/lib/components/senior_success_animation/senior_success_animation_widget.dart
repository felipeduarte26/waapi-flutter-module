import 'package:flutter/material.dart';

import 'package:rive/rive.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import './senior_success_animation_style.dart';
import '../../repositories/theme_repository.dart';

class SeniorSuccessAnimation extends StatefulWidget {
  /// Creates a screen with a splash animation.
  ///
  /// The [subTitle], [successAnimationPath] and [title] parameters are required.
  const SeniorSuccessAnimation({
    Key? key,
    this.onEndAnimation,
    required this.subTitle,
    this.style,
    required this.successAnimationPath,
    required this.title,
  }) : super(key: key);

  /// Callback function that is executed when the animation ends.
  final VoidCallback? onEndAnimation;

  /// The subtitle that appears within the splash animation.
  final String subTitle;

  /// The path to the animation file.
  /// It is important that the animation file follows the standards established by Senior's design system to ensure
  /// a good functioning of the component. The lib cannot be tasked with loading the animation file.
  final String successAnimationPath;

  /// The component's style definitions.
  /// Allows you to configure:
  /// [SeniorSuccessAnimationScreenStyle.titleColor] the title color in the animation.
  /// [SeniorSuccessAnimationScreenStyle.subtitleColor] the subtitle color in the animation.
  final SeniorSuccessAnimationStyle? style;

  /// The title that appears within the splash animation.
  final String title;

  @override
  _SeniorSuccessAnimationState createState() => _SeniorSuccessAnimationState();
}

class _SeniorSuccessAnimationState extends State<SeniorSuccessAnimation> {
  bool startedAnimation = false;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Center(
          child: RiveAnimation.asset(
            widget.successAnimationPath,
            onInit: (_) async {
              await Future.delayed(
                const Duration(milliseconds: 300),
              );
              setState(() {
                startedAnimation = true;
              });
            },
          ),
        ),
        AnimatedPositioned(
          child: RichText(
            text: TextSpan(
              text: '${widget.title}\n',
              style: SeniorTypography.h3(
                color: widget.style?.titleColor ??
                    theme.successAnimationTheme?.style?.titleColor ??
                    SeniorColors.grayscale80,
              ),
              children: [
                TextSpan(
                  text: widget.subTitle,
                  style: SeniorTypography.h3(
                    color: widget.style?.subtitleColor ??
                        theme.successAnimationTheme?.style?.subtitleColor ??
                        SeniorColors.grayscale50,
                  ),
                ),
              ],
            ),
          ),
          duration: const Duration(milliseconds: 700),
          bottom: startedAnimation ? size.height * 0.1 : -100,
          left: startedAnimation ? size.width * 0.1 : -100,
          onEnd: () async {
            await Future.delayed(
              const Duration(milliseconds: 1250),
            );
            widget.onEndAnimation?.call();
          },
        ),
      ],
    );
  }
}
