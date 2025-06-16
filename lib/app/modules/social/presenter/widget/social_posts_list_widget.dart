import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/repositories/theme_repository.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../domain/entities/social_post_entity.dart';
import '../bloc/social_like_bloc/social_like_event.dart';
import '../bloc/social_screen/social_screen_bloc.dart';
import 'social_post_widget.dart';

class SocialPostListWidget extends StatelessWidget {
  final List<SocialPostEntity> posts;
  final double _dividerThickness = 8;
  const SocialPostListWidget({required this.posts, super.key});

  @override
  Widget build(BuildContext context) {
    final socialScreenBloc = Modular.get<SocialScreenBloc>();
    final socialAuthorizationEntity = (socialScreenBloc.authorizationBloc.state as LoadedAuthorizationState)
        .authorizationEntity
        .socialAuthorizationEntity;
    bool isDarkColor = Provider.of<ThemeRepository>(context).isDarkTheme();

    return ListView.separated(
      separatorBuilder: (context, index) {
        return Divider(
          color: isDarkColor ? SeniorColors.grayscale70 : SeniorColors.grayscale10,
          thickness: _dividerThickness,
        );
      },
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return SocialPostWidget(
          socialPostEntity: posts[index],
          socialAuthorizationEntity: socialAuthorizationEntity,
          onLikeChanged: (liked) {
            socialScreenBloc.socialLikeBloc.add(
              SetSocialLikeEvent(
                postId: posts[index].id,
                isLiked: liked!,
                posts: posts,
              ),
            );
          },
          openComments: true,
          socialScreenBloc: socialScreenBloc,
          urls: const {},
        );
      },
    );
  }
}
