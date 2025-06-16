import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/patterns.dart';
import '../../../../core/theme/waapi_style_theme.dart';
import '../../../../core/widgets/waapi_video_player_widget.dart';
import '../../../../routes/social_routers.dart';
import '../../domain/entities/social_mention_entity.dart';
import '../bloc/social_tag_feed/social_tag_feed_bloc.dart';
import 'social_post_body_collapsed_widget.dart';

class SocialPostBodyContentWidget extends StatefulWidget {
  final String text;
  final List<SocialMentionEntity>? mentions;
  final bool hasImage;
  final ThemeRepository themeRepository;
  final double maxWidth;
  final bool isComment;

  const SocialPostBodyContentWidget({
    super.key,
    required this.text,
    required this.hasImage,
    required this.themeRepository,
    this.mentions,
    required this.maxWidth,
    required this.isComment,
  });

  @override
  State<SocialPostBodyContentWidget> createState() => _SocialPostBodyContentWidgetState();
}

class _SocialPostBodyContentWidgetState extends State<SocialPostBodyContentWidget> {
  RegExpMatch? youTubeMatch;
  RegExpMatch? vimeoMatch;
  String videoUrl = '';
  bool hasUrl = false;
  List<Widget> widgets = [];
  List<String> parts = [];
  bool didExceedMaxLines = false;
  bool readMore = false;

  String extractVimeoId(String url) {
    if (url.contains('vimeo.com/')) {
      final match = RegExp(r'vimeo.com/(\d+)').firstMatch(url);
      if (match != null && match.groupCount >= 1) {
        return match.group(1) ?? '';
      }
    }

    return '';
  }

  TextSpan _buildData({
    required String data,
  }) {
    List<TextSpan> textSpans = [];

    Pattern patterns = RegExp(
      {
        Patterns.hashtag,
        Patterns.mention,
        Patterns.link,
        Patterns.email,
      }.map((e) => e.pattern).join('|'),
    );

    data.splitMapJoin(
      patterns,
      onMatch: (match) {
        var matched = match[0];
        var isMatched = true;

        if (matched![0] == '@') {
          if (widget.mentions == null) {
            isMatched = false;
          }

          for (var mention in widget.mentions ?? []) {
            if (mention.mentionKey == matched!.replaceAll('@', '')) {
              matched = '@${mention.mentionValue}';
              isMatched = true;
              break;
            } else {
              isMatched = false;
            }
          }
        }

        textSpans.add(
          TextSpan(
            text: matched!.trim(),
            style: TextStyle(
              color: isMatched
                  ? widget.themeRepository.isDarkTheme()
                      ? SeniorColors.primaryColor400
                      : widget.themeRepository.isCustomTheme()
                          ? SeniorServiceColor.getContrastAdjustedColorTheme(
                              color: widget.themeRepository.theme.primaryColor!,
                            )
                          : SeniorColors.primaryColor500
                  : widget.themeRepository.isDarkTheme()
                      ? SeniorColors.grayscale30
                      : SeniorColors.grayscale90,
              fontFamily: 'OpenSans',
              fontSize: 14,
              fontWeight: isMatched ? FontWeight.w700 : FontWeight.w400,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = Patterns.link.hasMatch(matched) ||
                      Patterns.hashtag.hasMatch(matched) ||
                      Patterns.mention.hasMatch(matched)
                  ? () async {
                      if (Patterns.link.hasMatch(matched!)) {
                        await launchUrl(Uri.parse(matched));
                      } else if (Patterns.hashtag.hasMatch(matched)) {
                        Modular.to.pushNamed(
                          SocialRouters.socialTagInitialRoute,
                          arguments: {
                            'tag': matched,
                            'socialTagFeedBloc': Modular.get<SocialTagFeedBloc>(),
                          },
                        );
                      } else if (Patterns.mention.hasMatch(matched)) {
                        final mention =
                            widget.mentions?.where((mention) => '@${mention.mentionValue}' == matched).first;
                        final permaname = mention?.mentionKey;
                        Modular.to.pushNamed(
                          SocialRouters.socialProfileInitialRoute,
                          arguments: {
                            'permaname': permaname,
                          },
                        );
                      }
                    }
                  : null,
          ),
        );

        return matched;
      },
      onNonMatch: (non) {
        textSpans.add(
          TextSpan(
            text: non,
            style: WaapiStyleTheme.effectiveTextStyle(isDarkColor: widget.themeRepository.isDarkTheme()),
          ),
        );
        return non;
      },
    );

    return TextSpan(
      children: textSpans,
    );
  }

  @override
  Widget build(BuildContext context) {
    Pattern patterns = RegExp(
      {
        Patterns.youTube,
        Patterns.vimeo,
      }.map((e) => e.pattern).join('|'),
    );

    var linesText = '';
    var countVideos = 0;
    widget.text.splitMapJoin(
      patterns,
      onMatch: (match) {
        countVideos++;
        return '';
      },
      onNonMatch: (non) {
        linesText += non;
        return '';
      },
    );

    TextPainter textPainter = TextPainter(
      text: TextSpan(text: linesText),
      maxLines: 3,
      ellipsis: '...',
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(minWidth: 0, maxWidth: widget.maxWidth);

    youTubeMatch = Patterns.youTube.firstMatch(widget.text);
    vimeoMatch = Patterns.vimeo.firstMatch(widget.text);

    if ((textPainter.didExceedMaxLines || countVideos > 1 || (countVideos > 0 && widget.hasImage)) && !readMore) {
      didExceedMaxLines = true;
    } else {
      widgets = [];

      Pattern patterns = RegExp(
        {
          Patterns.youTube,
          Patterns.vimeo,
        }.map((e) => e.pattern).join('|'),
      );

      widget.text.splitMapJoin(
        patterns,
        onMatch: (match) {
          youTubeMatch = Patterns.youTube.firstMatch(match[0]!);
          vimeoMatch = Patterns.vimeo.firstMatch(match[0]!);

          if (youTubeMatch != null) {
            widgets.add(
              Padding(
                padding: const EdgeInsets.only(
                  bottom: SeniorSpacing.normal,
                ),
                child: WaapiVideoPlayerWidget(
                  videoUrl: youTubeMatch!.group(0)!,
                  isYoutube: true,
                ),
              ),
            );
          } else {
            String vimeoId = extractVimeoId(vimeoMatch!.group(0)!);

            widgets.add(
              Padding(
                padding: const EdgeInsets.only(
                  bottom: SeniorSpacing.normal,
                ),
                child: WaapiVideoPlayerWidget(
                  videoUrl: vimeoId,
                  isVimeo: true,
                ),
              ),
            );
          }
          return '';
        },
        onNonMatch: (non) {
          TextSpan textSpan;

          textSpan = _buildData(
            data: non.trim(),
          );

          if (non.isNotEmpty) {
            widgets.add(
              Padding(
                padding: EdgeInsets.only(
                  left: widget.isComment ? SeniorSpacing.xsmall : SeniorSpacing.normal,
                  right: widget.isComment ? SeniorSpacing.xsmall : SeniorSpacing.normal,
                  bottom: SeniorSpacing.xsmall,
                ),
                child: Text.rich(
                  TextSpan(
                    children: [
                      textSpan,
                    ],
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            );
          }
          return '';
        },
      );
    }

    if (didExceedMaxLines && !readMore) {
      return SocialPostBodyCollapsedWidget(
        widget.text,
        mentions: widget.mentions,
        maxLines: 3,
        hasImage: widget.hasImage,
        callback: ({required bool val}) {
          setState(() {
            readMore = true;
          });
        },
        isComment: widget.isComment,
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}
