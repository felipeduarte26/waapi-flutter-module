import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/extension/translate_extension.dart';
import '../../../../routes/social_routers.dart';
import '../../../authorization/domain/entities/social_authorization_entity.dart';
import '../../domain/entities/social_post_entity.dart';
import '../bloc/social_like_bloc/social_like_bloc.dart';
import '../bloc/social_like_bloc/social_like_state.dart';
import '../bloc/social_screen/social_screen_bloc.dart';

class SocialPostFooterWidget extends StatefulWidget {
  final bool blockedComment;
  final SocialAuthorizationEntity socialAuthorizationEntity;
  final ValueChanged<bool?> onLikeChanged;
  final SocialPostEntity post;
  final bool openComments;
  final SocialScreenBloc socialScreenBloc;

  const SocialPostFooterWidget({
    super.key,
    required this.blockedComment,
    required this.socialAuthorizationEntity,
    required this.onLikeChanged,
    required this.post,
    required this.openComments,
    required this.socialScreenBloc,
  });

  @override
  State<SocialPostFooterWidget> createState() => _SocialPostFooterWidgetState();
}

class _SocialPostFooterWidgetState extends State<SocialPostFooterWidget> {
  bool isLiked = false;
  bool likeIsBlocked = false;
  var url = '';

  @override
  void initState() {
    super.initState();
    isLiked = widget.post.gotMyLike;
  }

  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);
    bool isDarkColor = themeRepository.isDarkTheme();
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: SeniorSpacing.xsmall,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BlocBuilder<SocialLikeBloc, SocialLikeState>(
            bloc: widget.socialScreenBloc.socialLikeBloc,
            builder: (context, state) {
              if (state is LoadedSocialLikeState) {
                isLiked = state.posts.where((post) => post.id == widget.post.id).firstOrNull?.gotMyLike ??
                    widget.post.gotMyLike;
                likeIsBlocked = state.likeIsBlocked;
              }

              return Visibility(
                visible: widget.socialAuthorizationEntity.canPostLike,
                child: Expanded(
                  child: GestureDetector(
                    onTap: () {
                      isLiked = !isLiked;
                      widget.onLikeChanged(isLiked);
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        children: [
                          (isLiked)
                              ? BounceInDown(
                                  animate: true,
                                  from: SeniorSpacing.xxbig,
                                  child: SeniorIcon(
                                    icon: FontAwesomeIcons.solidThumbsUp,
                                    size: SeniorSpacing.medium,
                                    style: SeniorIconStyle(
                                      color: themeRepository.isCustomTheme()
                                          ? SeniorServiceColor.getContrastAdjustedColorTheme(
                                              color: themeRepository.theme.primaryColor!,
                                            )
                                          : SeniorColors.primaryColor500,
                                    ),
                                  ),
                                )
                              : SeniorIcon(
                                  icon: FontAwesomeIcons.thumbsUp,
                                  style: SeniorIconStyle(
                                    color: isDarkColor ? SeniorColors.grayscale40 : SeniorColors.grayscale50,
                                  ),
                                  size: SeniorSpacing.medium,
                                ),
                          const SizedBox(
                            height: SeniorSpacing.xxsmall,
                          ),
                          SeniorText.small(
                            isLiked ? context.translate.liked : context.translate.like,
                            color: isLiked
                                ? themeRepository.isCustomTheme()
                                    ? SeniorServiceColor.getContrastAdjustedColorTheme(
                                        color: themeRepository.theme.primaryColor!,
                                      )
                                    : SeniorColors.primaryColor500
                                : null,
                            darkColor: isLiked ? SeniorColors.primaryColor500 : null,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          Visibility(
            visible: widget.socialAuthorizationEntity.canPostComments && !widget.blockedComment,
            child: Expanded(
              child: GestureDetector(
                onTap: widget.openComments
                    ? () {
                        Modular.to.pushNamed(
                          SocialRouters.socialCommentsScreenInitialRoute,
                          arguments: {
                            'post': widget.post,
                            'onLikeChanged': widget.onLikeChanged,
                            'socialScreenBloc': widget.socialScreenBloc,
                            'openWithFocus': true,
                          },
                        );
                      }
                    : null,
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      SeniorIcon(
                        icon: FontAwesomeIcons.message,
                        style: SeniorIconStyle(
                          color: isDarkColor ? SeniorColors.grayscale40 : SeniorColors.grayscale50,
                        ),
                        size: SeniorSpacing.medium,
                      ),
                      const SizedBox(
                        height: SeniorSpacing.xxsmall,
                      ),
                      SeniorText.small(
                        context.translate.comment,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: widget.socialAuthorizationEntity.canViewProfiles &&
                widget.socialAuthorizationEntity.canViewSpacesMembers,
            child: Expanded(
              child: GestureDetector(
                onTap: () {
                  Modular.to.pushNamed(
                    SocialRouters.socialListMembersScreenInitialRoute,
                    arguments: {
                      'socialScreenBloc': widget.socialScreenBloc,
                      'postId': widget.post.id,
                    },
                  );
                },
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      SeniorIcon(
                        icon: FontAwesomeIcons.shareFromSquare,
                        style: SeniorIconStyle(
                          color: isDarkColor ? SeniorColors.grayscale40 : SeniorColors.grayscale50,
                        ),
                        size: SeniorSpacing.medium,
                      ),
                      const SizedBox(
                        height: SeniorSpacing.xxsmall,
                      ),
                      SeniorText.small(
                        context.translate.share,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
