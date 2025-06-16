import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/constants/patterns.dart';
import '../../../../core/theme/waapi_style_theme.dart';
import '../../domain/entities/social_profile_entity.dart';

class SocialCommentEditingController extends TextEditingController {
  List<SocialProfileEntity> mentions = [];

  SocialCommentEditingController() {
    addListener(_handleTextChange);
  }

  void addMention({
    required SocialProfileEntity mention,
  }) {
    mentions.add(mention);
  }

  String get textToSend {
    String textToSend = text;

    for (SocialProfileEntity mention in mentions) {
      textToSend = textToSend.replaceAll('@${mention.userName}', '@${mention.permaname}');
    }

    return textToSend.trim();
  }

  String _previousText = '';

  void _handleTextChange() {
    String currentText = text;

    if (_isPartialMentionRemoval(_previousText, currentText)) {
      _removeMention(_previousText, currentText);
    }

    _previousText = currentText;
  }

  @override
  TextSpan buildTextSpan({BuildContext? context, TextStyle? style, bool? withComposing}) {
    final themeRepository = Provider.of<ThemeRepository>(context!);
    bool isDarkColor = themeRepository.isDarkTheme();
    bool isCustomColor = themeRepository.isCustomTheme();

    List<TextSpan> textSpans = [];

    Pattern patterns = RegExp(
      {
        RegExp(
          r'\B@[\w\u00C0-\u017F.-]+',
          unicode: true,
        ),
        Patterns.hashtag,
        Patterns.link,
        Patterns.email,
      }.map((e) => e.pattern).join('|'),
    );

    text.splitMapJoin(
      patterns,
      onMatch: (match) {
        var matched = match[0];
        var isMatched = true;

        if (matched![0] == '@') {
          if (mentions.isEmpty) {
            isMatched = false;
          }

          for (SocialProfileEntity mention in mentions) {
            if (mention.userName == matched!.replaceAll('@', '')) {
              matched = '@${mention.userName}';
              isMatched = true;

              textSpans.add(
                TextSpan(
                  text: '@${mention.name}',
                  style: TextStyle(
                    color: isDarkColor
                        ? SeniorColors.primaryColor400
                        : isCustomColor
                            ? SeniorServiceColor.getContrastAdjustedColorTheme(
                                color: themeRepository.theme.primaryColor!,
                              )
                            : SeniorColors.primaryColor500,
                    fontFamily: 'OpenSans',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              );

              return matched;
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
                      : isCustomColor
                          ? SeniorServiceColor.getContrastAdjustedColorTheme(color: themeRepository.theme.primaryColor!)
                          : SeniorColors.primaryColor500
                  : isDarkColor
                      ? SeniorColors.grayscale30
                      : SeniorColors.grayscale90,
              fontFamily: 'OpenSans',
              fontSize: 14,
              fontWeight: isMatched ? FontWeight.w700 : FontWeight.w400,
            ),
          ),
        );

        return matched!;
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
      children: textSpans,
    );
  }

  bool _isPartialMentionRemoval(String oldText, String newText) {
    for (SocialProfileEntity mention in mentions) {
      String mentionName = '@${mention.userName}';
      if (newText.contains(mentionName)) {
        continue;
      }

      if (oldText.contains(mentionName) && newText.contains('@') && !newText.contains(mentionName)) {
        return true;
      }
    }
    return false;
  }

  void _removeMention(String oldText, String newText) {
    int cursorPosition = selection.baseOffset;

    for (SocialProfileEntity mention in mentions) {
      String mentionName = '@${mention.userName}';
      int mentionStartIndex = oldText.indexOf(mentionName);

      if (mentionStartIndex != -1) {
        int mentionEndIndex = mentionStartIndex + mentionName.length - 1;

        if (cursorPosition > mentionStartIndex && cursorPosition <= mentionEndIndex) {
          newText = newText.replaceRange(mentionStartIndex, mentionEndIndex, '');

          mentions.remove(mention);

          value = value.copyWith(
            text: newText,
            selection: TextSelection.collapsed(offset: mentionStartIndex),
          );
          return;
        }
      }
    }
  }
}
