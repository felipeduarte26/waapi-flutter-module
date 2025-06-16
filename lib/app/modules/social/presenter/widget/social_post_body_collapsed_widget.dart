import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/patterns.dart';
import '../../../../core/extension/translate_extension.dart';
import '../../../../core/helper/string_helper.dart';
import '../../../../core/theme/waapi_style_theme.dart';
import '../../../../core/widgets/waapi_video_player_widget.dart';
import '../../../../routes/routes.dart';
import '../../domain/entities/social_mention_entity.dart';
import '../bloc/social_tag_feed/social_tag_feed_bloc.dart';

class SocialPostBodyCollapsedWidget extends StatefulWidget {
  final List<SocialMentionEntity>? mentions;
  final Function({required bool val})? callback;
  final String data;
  final TextStyle? delimiterStyle;
  final int maxLines;
  final bool hasImage;
  final bool isComment;

  const SocialPostBodyCollapsedWidget(
    this.data, {
    this.mentions,
    super.key,
    this.delimiterStyle,
    this.callback,
    required this.maxLines,
    required this.hasImage,
    required this.isComment,
  });

  @override
  SocialPostBodyCollapsedWidgetState createState() => SocialPostBodyCollapsedWidgetState();
}

class SocialPostBodyCollapsedWidgetState extends State<SocialPostBodyCollapsedWidget> {
  bool _readMore = true;

  void _onTapLink() {
    setState(() {
      _readMore = !_readMore;
      widget.callback?.call(val: _readMore);
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);
    bool isDarkColor = themeRepository.isDarkTheme();

    final effectiveTextStyle = widget.delimiterStyle ?? WaapiStyleTheme.effectiveTextStyle(isDarkColor: isDarkColor);
    final defaultMoreStyle = themeRepository.isCustomTheme()
        ? WaapiStyleTheme.defaultMoreStyle(isDarkColor: isDarkColor)!.copyWith(
            color: SeniorServiceColor.getContrastAdjustedColorTheme(color: themeRepository.theme.primaryColor!),
          )
        : WaapiStyleTheme.defaultMoreStyle(isDarkColor: isDarkColor);

    TextSpan link = TextSpan(
      text: _readMore ? context.translate.seeMore : '',
      style: _readMore ? defaultMoreStyle : null,
      recognizer: TapGestureRecognizer()..onTap = _onTapLink,
    );

    TextSpan delimiter = TextSpan(
      text: _readMore ? StringHelper.ellipsis : '',
      style: effectiveTextStyle,
      recognizer: TapGestureRecognizer()..onTap = _onTapLink,
    );

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        assert(constraints.hasBoundedWidth);
        final double maxWidth = constraints.maxWidth;
        var countVideos = 0;
        var text = widget.data;
        final youTubeMatch = Patterns.youTube.firstMatch(text);
        final vimeoMatch = Patterns.vimeo.firstMatch(text);

        Pattern videoPatterns = RegExp(
          {
            Patterns.youTube,
            Patterns.vimeo,
          }.map((e) => e.pattern).join('|'),
        );

        text.splitMapJoin(
          videoPatterns,
          onMatch: (match) {
            text = text.replaceFirst(match[0] ?? '', '');
            countVideos++;
            return '';
          },
        );

        final textSpanInitial = TextSpan(
          text: text.trim(),
          style: effectiveTextStyle,
        );

        TextPainter textPainter = TextPainter(
          text: textSpanInitial,
          maxLines: widget.maxLines,
          ellipsis: '...',
          textDirection: TextDirection.ltr,
        );

        textPainter.text = link;
        textPainter.layout(minWidth: 0, maxWidth: maxWidth);
        final linkSize = textPainter.size;

        textPainter.text = delimiter;
        textPainter.layout(minWidth: 0, maxWidth: maxWidth);
        final delimiterSize = textPainter.size;

        textPainter.text = textSpanInitial;
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);

        int endIndex;

        //"SeniorSpacing.xxbig" because "maxWidth" does not consider text border spaces
        final readMoreSize = linkSize.width + delimiterSize.width + SeniorSpacing.xxbig;

        final pos = textPainter.getPositionForOffset(
          Offset(
            maxWidth - readMoreSize,
            maxWidth,
          ),
        );

        endIndex = textPainter.getOffsetBefore(pos.offset) ?? 0;

        TextSpan textSpan;

        textSpan = _buildData(
          data: textPainter.didExceedMaxLines && _readMore ? text.substring(0, endIndex).trim() : text.trim(),
          children: textPainter.didExceedMaxLines || countVideos > 1 || (countVideos > 0 && widget.hasImage)
              ? [delimiter, link]
              : [],
        );

        if (text.isNotEmpty) {
          var vimeoId = '';
          if (vimeoMatch != null) {
            vimeoId = extractVimeoId(vimeoMatch.group(0)!);
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  softWrap: true,
                  overflow: TextOverflow.clip,
                ),
              ),
              if (youTubeMatch != null && !widget.hasImage)
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: SeniorSpacing.normal,
                  ),
                  child: WaapiVideoPlayerWidget(
                    videoUrl: youTubeMatch.group(0)!,
                    isYoutube: true,
                  ),
                ),
              if (youTubeMatch == null && vimeoMatch != null && !widget.hasImage)
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: SeniorSpacing.normal,
                  ),
                  child: WaapiVideoPlayerWidget(
                    videoUrl: vimeoId,
                    isVimeo: true,
                  ),
                ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

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
    required List<TextSpan> children,
  }) {
    final themeRepository = Provider.of<ThemeRepository>(context);
    bool isDarkColor = themeRepository.isDarkTheme();

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
            text: matched,
            style: TextStyle(
              color: isMatched
                  ? isDarkColor
                      ? SeniorColors.primaryColor400
                      : themeRepository.isCustomTheme()
                          ? SeniorServiceColor.getContrastAdjustedColorTheme(
                              color: themeRepository.theme.primaryColor!,
                            )
                          : SeniorColors.primaryColor500
                  : isDarkColor
                      ? SeniorColors.grayscale30
                      : SeniorColors.grayscale90,
              fontFamily: 'OpenSans',
              fontSize: 14,
              fontWeight: isMatched ? FontWeight.w700 : FontWeight.w400,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = Patterns.link.hasMatch(matched!) ||
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
            style: WaapiStyleTheme.effectiveTextStyle(isDarkColor: isDarkColor),
          ),
        );
        return non;
      },
    );

    return TextSpan(
      children: textSpans..addAll(children),
    );
  }
}
