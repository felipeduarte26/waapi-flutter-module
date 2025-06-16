import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import './senior_quotes_style.dart';
import '../../repositories/theme_repository.dart';
import '../../theme/senior_theme_data.dart';

class SeniorQuotes extends StatelessWidget {
  /// Creates the SDS SeniorQuotes component.
  ///
  /// The parameter [message] is required.
  SeniorQuotes({
    Key? key,
    this.isScrollable = false,
    required this.message,
    this.style,
    this.margin,
    this.isExpanded = true,
  }) : super(key: key);

  /// Whether the content will be scrollable.
  ///
  /// The default value is false.
  final bool? isScrollable;

  /// The message that will be displayed on the component.
  final String message;

  /// The margin that will be added on the component.
  ///
  /// The default value is [EdgeInsets.only(right: SeniorSpacing.normal, left: SeniorSpacing.normal)];
  final EdgeInsetsGeometry? margin;

  /// Whether the component will be expanded or not.
  ///
  /// The default value is true.
  final bool? isExpanded;

  /// The component's style definitions.
  /// Allows you to configure:
  /// [SeniorQuotesStyle.backgroundColor] the component's background color.
  /// [SeniorQuotesStyle.textColor] the text color in the component.
  final SeniorQuotesStyle? style;

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    return isScrollable! ? _buildQuotes(theme) : _buildExpandedQuotes(theme);
  }

  Widget _buildQuotes(SeniorThemeData theme) {
    if (isExpanded!) {
      return Expanded(
        child: _buildBodyQuotes(theme),
      );
    } else {
      return _buildBodyQuotes(theme);
    }
  }

  Widget _buildExpandedQuotes(SeniorThemeData theme) {
    final Color textColor = style?.textColor ??
        theme.quotesTheme?.style?.textColor ??
        SeniorColors.grayscale80;

    final Color quotesColor = style?.quotesColor ??
        theme.quotesTheme?.style?.quotesColor ??
        SeniorColors.grayscale80;

    return Container(
      decoration: BoxDecoration(
        color: style?.backgroundColor ??
            theme.quotesTheme?.style?.backgroundColor ??
            SeniorColors.grayscale10,
        borderRadius: BorderRadius.circular(SeniorRadius.xbig),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 55.0,
              bottom: 50.0,
              right: 40.0,
              left: 40.0,
            ),
            child: Text(
              message,
              style: SeniorTypography.label(
                color: textColor,
              ),
            ),
          ),
          Positioned(
            top: 20.0,
            left: 20.0,
            child: Text(
              '“',
              style: SeniorTypography.h1(
                color: quotesColor,
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            right: 20.0,
            child: Text(
              '”',
              style: SeniorTypography.h1(
                color: quotesColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBodyQuotes(SeniorThemeData theme) {
    final Color textColor = style?.textColor ?? theme.quotesTheme?.style?.textColor ?? SeniorColors.grayscale80;

    final Color quotesColor = style?.quotesColor ?? theme.quotesTheme?.style?.quotesColor ?? SeniorColors.grayscale80;

    return Container(
      margin: margin ??
          const EdgeInsets.only(
            right: SeniorSpacing.normal,
            left: SeniorSpacing.normal,
          ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: style?.backgroundColor ?? theme.quotesTheme?.style?.backgroundColor ?? SeniorColors.grayscale10,
        borderRadius: BorderRadius.circular(SeniorRadius.xbig),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 55.0,
              bottom: 50.0,
              right: 5.0,
            ),
            child: Scrollbar(
              thumbVisibility: true,
              controller: scrollController,
              child: SingleChildScrollView(
                controller: scrollController,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40.0,
                ),
                child: Text(
                  message,
                  style: SeniorTypography.label(
                    color: textColor,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 20.0,
            left: 20.0,
            child: Text(
              '“',
              style: SeniorTypography.h1(
                color: quotesColor,
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            right: 20.0,
            child: Text(
              '”',
              style: SeniorTypography.h1(
                color: quotesColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
