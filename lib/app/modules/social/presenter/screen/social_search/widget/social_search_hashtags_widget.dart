import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/extension/translate_extension.dart';
import 'social_search_hashtags_list_widget.dart';

class SocialSearchHashtagsWidget extends StatelessWidget {
  final int? maxLeanHashtag;
  final List<String> hashtags;

  const SocialSearchHashtagsWidget({
    super.key,
    this.maxLeanHashtag,
    required this.hashtags,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        maxLeanHashtag != null
            ? Padding(
                padding: const EdgeInsets.only(
                  left: SeniorSpacing.normal,
                  bottom: SeniorSpacing.xsmall,
                  top: SeniorSpacing.normal,
                ),
                child: SeniorText.body(
                  context.translate.hashtags,
                  textProperties: const TextProperties(
                    textAlign: TextAlign.left,
                  ),
                ),
              )
            : const SizedBox.shrink(),
        Expanded(
          child: SocialSearchHashtagsListWidget(
            maxLeanHashtag: maxLeanHashtag,
            hashtags: hashtags,
          ),
        ),
      ],
    );
  }
}
