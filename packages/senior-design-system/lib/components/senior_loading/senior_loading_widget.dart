import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import './senior_loading_style.dart';
import '../../repositories/theme_repository.dart';

class SeniorLoading extends StatelessWidget {
  /// Creates a circular progress indicator according to SDS.
  const SeniorLoading({
    Key? key,
    this.semanticsLabel,
    this.semanticsValue,
    this.style,
    this.value,
    this.size = 40.0,
  }) : super(
          key: key,
        );

  /// Defines the value that will be passed to the semanticsLabel property of [CircularProgressIndicator].
  final String? semanticsLabel;

  /// Defines the value that will be passed to the semanticsValue property of [CircularProgressIndicator].
  final String? semanticsValue;

  /// The size of the button
  /// Small, medium and big sizes correspond to 16.0, 32.0 and 40.0 respectively.
  ///
  /// The default value is 40.0.
  final double size;

  /// The component's style definitions.
  ///
  /// Allows you to configure:
  /// [SeniorLoadingStyle.color] the color of the circular progress indicator.
  final SeniorLoadingStyle? style;

  /// Defines the value that will be passed to the value property of [CircularProgressIndicator].
  final double? value;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        color: style?.color ??
            theme.loadingTheme?.style?.color ??
            SeniorColors.primaryColor,
        semanticsLabel: semanticsLabel,
        semanticsValue: semanticsValue,
        value: value,
      ),
    );
  }
}
