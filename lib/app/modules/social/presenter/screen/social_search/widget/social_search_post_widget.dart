import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/extension/translate_extension.dart';
import '../../../../domain/entities/social_post_entity.dart';
import 'social_search_post_list_widget.dart';

class SocialSearchPostWidget extends StatelessWidget {
  final int? maxLeanPosts;
  final List<SocialPostEntity> posts;

  const SocialSearchPostWidget({
    super.key,
    this.maxLeanPosts,
    required this.posts,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: SeniorSpacing.normal,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: SeniorSpacing.normal,
            ),
            child: SeniorText.body(
              context.translate.posts,
              textProperties: const TextProperties(
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Expanded(
            child: SocialSearchPostListWidget(
              maxLeanPosts: maxLeanPosts,
              posts: posts,
            ),
          ),
        ],
      ),
    );
  }
}
