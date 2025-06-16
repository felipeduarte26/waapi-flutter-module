import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import './senior_state_page_style.dart';
import './senior_state_page_theme.dart';
import '../../components/senior_button/senior_button.dart';
import '../../repositories/theme_repository.dart';

abstract class SeniorStatePage extends StatelessWidget {
  /// Create a status information page.
  ///
  /// The [iconData] and [title] parameters are required.
  const SeniorStatePage({
    Key? key,
    this.actions,
    required this.illustration,
    this.style,
    this.subTitle,
    required this.title,
  }) : super(key: key);

  /// List of buttons representing the actions supported by the screen.
  final List<SeniorButton>? actions;

  /// The illustration representing the status of the screen.
  final Widget illustration;

  /// The style definitions for the component.
  /// Allows you to configure:
  /// [SeniorStatePageStyle.titleColor] the color of the page title.
  /// [SeniorStatePageStyle.subtitleColor] the page subtitle color.
  ///
  /// It can be set on the [SeniorTheme] instance assigned to the app in the [SeniorStatePageThemeData.style] parameter.
  final SeniorStatePageStyle? style;

  /// The subtitle of the page.
  final String? subTitle;

  /// The page title.
  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SeniorSpacing.normal),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(overscroll: false),
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      illustration,
                      Text(
                        title,
                        style: SeniorTypography.h4(
                          color: style?.titleColor ??
                              theme.statePageTheme?.style?.titleColor ??
                              SeniorColors.grayscale90,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      subTitle == null
                          ? const SizedBox.shrink()
                          : Padding(
                              padding: const EdgeInsets.only(
                                  top: SeniorSpacing.xsmall),
                              child: Text(
                                subTitle!,
                                style: SeniorTypography.label(
                                  color: style?.subtitleColor ??
                                      theme.statePageTheme?.style
                                          ?.subtitleColor ??
                                      SeniorColors.grayscale50,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          actions == null
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.only(top: SeniorSpacing.normal),
                  child: Column(
                    children: actions!
                        .map(
                          (action) => Padding(
                            padding: const EdgeInsets.only(
                                bottom: SeniorSpacing.small),
                            child: action,
                          ),
                        )
                        .toList(),
                  ),
                ),
        ],
      ),
    );
  }
}
