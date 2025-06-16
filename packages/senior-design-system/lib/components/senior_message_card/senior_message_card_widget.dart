import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import './senior_message_card_style.dart';
import '../../repositories/theme_repository.dart';

/// Options for card feedback.
/// This could be [SeniorMessageCardFeedbacks.neutral], [SeniorMessageCardFeedbacks.thumbsUp] and
/// [SeniorMessageCardFeedbacks.thumbsDown].
enum SeniorMessageCardFeedbacks {
  neutral,
  thumbsUp,
  thumbsDown,
}

typedef ChangeFeedbackCallback = void Function(SeniorMessageCardFeedbacks);

class SeniorMessageCard extends StatelessWidget {
  /// Creates the SDS SeniorMessageCard component.
  ///
  /// The parameter [message] is required.
  SeniorMessageCard({
    Key? key,
    this.feedbackOptions,
    required this.message,
    this.padding,
    this.style,
  }) : super(key: key);

  /// The card's feedback options.
  final SeniorMessageCardFeedbackOptions? feedbackOptions;

  /// The message that will be displayed on the card.
  final String message;

  /// Padding for the component.
  final EdgeInsetsGeometry? padding;

  /// The component's style definitions.
  /// Allows you to configure:
  /// [SeniorMessageCardStyle.color] the color of the card.
  /// [SeniorMessageCardStyle.feedbackItemsColor] the color of the card's feedback items.
  /// [SeniorMessageCardStyle.textColor] the color of the card's text.
  final SeniorMessageCardStyle? style;

  final ScrollController scrollController = ScrollController();

  Widget _buildMessageArea({required Color textColor}) {
    return Padding(
      padding: EdgeInsets.only(
        top: SeniorSpacing.xmedium,
        bottom: feedbackOptions != null
            ? SeniorSpacing.xxhuge
            : SeniorSpacing.xmedium,
        right: SeniorSpacing.xxsmall,
      ),
      child: Scrollbar(
        thumbVisibility: true,
        controller: scrollController,
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowIndicator();
            return true;
          },
          child: SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.symmetric(
              horizontal: SeniorSpacing.normal,
            ),
            child: Text(
              message,
              style: SeniorTypography.body(
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeedbackArea({
    required Color feedbackItemsColor,
    required double feedbackIconsSize,
  }) {
    return feedbackOptions != null
        ? Positioned(
            bottom: SeniorSpacing.normal,
            right: SeniorSpacing.big,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    feedbackOptions!.label,
                    style: SeniorTypography.small(color: feedbackItemsColor),
                  ),
                  const SizedBox(width: SeniorSpacing.small),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => feedbackOptions!.onChangedFeedback(
                          SeniorMessageCardFeedbacks.thumbsUp,
                        ),
                        child: Icon(
                          feedbackOptions!.feedback ==
                                  SeniorMessageCardFeedbacks.thumbsUp
                              ? FontAwesomeIcons.solidThumbsUp
                              : FontAwesomeIcons.thumbsUp,
                          color: feedbackItemsColor,
                          size: feedbackIconsSize,
                        ),
                      ),
                      const SizedBox(
                        width: SeniorSpacing.small,
                      ),
                      GestureDetector(
                        onTap: () => feedbackOptions!.onChangedFeedback(
                            SeniorMessageCardFeedbacks.thumbsDown),
                        child: Icon(
                          feedbackOptions!.feedback ==
                                  SeniorMessageCardFeedbacks.thumbsDown
                              ? FontAwesomeIcons.solidThumbsDown
                              : FontAwesomeIcons.thumbsDown,
                          color: feedbackItemsColor,
                          size: feedbackIconsSize,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        : const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    return Container(
      margin:
          padding ?? theme.messageCardTheme?.padding ?? const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: style?.color ??
            theme.messageCardTheme?.style?.color ??
            SeniorColors.grayscale10,
        borderRadius: BorderRadius.circular(SeniorRadius.xbig),
      ),
      child: Stack(
        children: [
          _buildMessageArea(
              textColor: style?.textColor ??
                  theme.messageCardTheme?.style?.textColor ??
                  SeniorColors.grayscale90),
          _buildFeedbackArea(
            feedbackItemsColor: style?.feedbackItemsColor ??
                theme.messageCardTheme?.style?.feedbackItemsColor ??
                SeniorColors.grayscale60,
            feedbackIconsSize: SeniorIconSize.small,
          ),
        ],
      ),
    );
  }
}

class SeniorMessageCardFeedbackOptions {
  /// The feedback settings for the SeniorMessageCard component.
  ///
  /// The [feedback], [label] and [onChangedFeedback] parameters are required.
  SeniorMessageCardFeedbackOptions({
    required this.feedback,
    required this.label,
    required this.onChangedFeedback,
  });

  /// SeniorMessageCard Feedback.
  final SeniorMessageCardFeedbacks feedback;

  /// The SeniorMessageCard feedback label.
  final String label;

  /// Function performed when feedback is changed.
  /// Receives the current feedback as a parameter.
  final ChangeFeedbackCallback onChangedFeedback;
}
