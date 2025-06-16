import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../authorization/domain/entities/social_authorization_entity.dart';
import '../../domain/entities/social_post_entity.dart';
import '../bloc/social_screen/social_screen_bloc.dart';
import 'social_post_body_widget.dart';
import 'social_post_comments_widget.dart';
import 'social_post_footer_widget.dart';
import 'social_post_header_widget.dart';

class SocialPostWidget extends StatefulWidget {
  final SocialPostEntity socialPostEntity;
  final SocialAuthorizationEntity socialAuthorizationEntity;
  final bool openComments;
  final ValueChanged<bool?> onLikeChanged;
  final Map<String, dynamic> urls;
  final SocialScreenBloc socialScreenBloc;

  const SocialPostWidget({
    super.key,
    required this.socialPostEntity,
    required this.socialAuthorizationEntity,
    required this.openComments,
    required this.urls,
    required this.onLikeChanged,
    required this.socialScreenBloc,
  });

  @override
  State<SocialPostWidget> createState() => _SocialPostWidgetState();
}

class _SocialPostWidgetState extends State<SocialPostWidget> {
  @override
  Widget build(BuildContext context) {
    bool isDarkColor = Provider.of<ThemeRepository>(context).isDarkTheme();
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: SeniorSpacing.xsmall,
      ),
      decoration: BoxDecoration(
        color: isDarkColor ? SeniorColors.grayscale90 : SeniorColors.grayscale0,
        boxShadow: isDarkColor
            ? [
                BoxShadow(
                  color: SeniorColors.pureBlack.withOpacity(0.1),
                  blurRadius: 5,
                  spreadRadius: 2,
                  offset: const Offset(0, 3),
                ),
              ]
            : null,
      ),
      child: Column(
        children: [
          SocialPostHeaderWidget(
            socialPostEntity: widget.socialPostEntity,
          ),
          const Divider(
            color: SeniorColors.neutralColor400,
            thickness: 1,
          ),
          SocialPostBodyWidget(
            socialPostEntity: widget.socialPostEntity,
            openComments: widget.openComments,
            onLikeChanged: widget.onLikeChanged,
            socialScreenBloc: widget.socialScreenBloc,
          ),
          const Divider(
            color: SeniorColors.neutralColor400,
            thickness: 1,
          ),
          SocialPostFooterWidget(
            socialAuthorizationEntity: widget.socialAuthorizationEntity,
            blockedComment: widget.socialPostEntity.blockedComment,
            openComments: widget.openComments,
            post: widget.socialPostEntity,
            onLikeChanged: widget.onLikeChanged,
            socialScreenBloc: widget.socialScreenBloc,
          ),
          if (!widget.openComments)
            SocialPostCommentsWidget(
              socialPostEntity: widget.socialPostEntity,
              urls: widget.urls,
              socialScreenBloc: widget.socialScreenBloc,
            ),
        ],
      ),
    );
  }
}
