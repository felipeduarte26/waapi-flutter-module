import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../core/constants/assets_path.dart';
import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/widgets/error_state_widget.dart';
import '../../../../../core/widgets/waapi_colorful_header.dart';
import '../../../../../core/widgets/waapi_loading_widget.dart';
import '../../../domain/entities/social_feed_entity.dart';
import '../../../domain/entities/social_space_entity.dart';
import '../../../enums/social_space_privacy_enum.dart';
import '../../bloc/social_screen/social_screen_bloc.dart';
import '../../bloc/social_space_feed/social_space_feed_bloc.dart';
import '../../bloc/social_space_feed/social_space_feed_event.dart';
import '../../bloc/social_space_feed/social_space_feed_state.dart';
import '../../widget/create_post_action_button.dart';
import '../../widget/modal/social_modal.dart';
import '../../widget/social_feed_empty_state_widget.dart';
import '../../widget/social_timeline_widget.dart';

class SocialSpaceScreen extends StatelessWidget {
  final SocialSpaceFeedBloc socialSpaceFeedBloc;
  final String permaname;

  const SocialSpaceScreen({
    required this.permaname,
    required this.socialSpaceFeedBloc,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);
    final isCustomTheme = themeRepository.isCustomTheme();
    final socialScreenBloc = Modular.get<SocialScreenBloc>();

    return Scaffold(
      floatingActionButton: BlocBuilder<SocialSpaceFeedBloc, SocialSpaceFeedState>(
        bloc: socialSpaceFeedBloc,
        builder: (_, state) {
          return canStateShowPage(state)
              ? CreatePostActionButton(
                  socialScreenBloc: socialScreenBloc,
                  themeRepository: themeRepository,
                  spaceSelected: socialSpaceFeedBloc.state.space,
                )
              : const SizedBox.shrink();
        },
      ),
      body: WaapiColorfulHeader(
        title: SeniorText.label(
          context.translate.group,
          color: SeniorColors.pureWhite,
          darkColor: SeniorColors.grayscale5,
        ),
        body: BlocBuilder<SocialSpaceFeedBloc, SocialSpaceFeedState>(
          bloc: socialSpaceFeedBloc,
          builder: (_, state) {
            if (state is LoadingSocialSpaceFeedState) {
              return const WaapiLoadingWidget();
            }

            if (state is ErrorSocialSpaceFeedState) {
              return ErrorStateWidget(
                imagePath: AssetsPath.generalErrorState,
                title: context.translate.socialPostErrorTitle,
                subTitle: context.translate.tryAgainSoon,
                onTapTryAgain: () {
                  _getFeed();
                },
              );
            }

            if (state is EmptySocialSpaceFeedState) {
              return SocialFeedEmptyStateWidget(
                onPublish: () async {
                  await SocialModal.createPostModal(
                    context: context,
                    socialScreenBloc: socialScreenBloc,
                    spaceSelected: state.space,
                  );
                },
              );
            }

            if (canStateShowPage(state)) {
              return RefreshIndicator(
                onRefresh: () async => _getFeed(),
                color: isCustomTheme ? themeRepository.theme.primaryColor : SeniorColors.primaryColor,
                child: SocialTimelineWidget(
                  isLoading: state is LoadingMoreSocialSpaceFeedState,
                  endReached: state is EmptyLoadedMoreSocialSpaceFeedState,
                  name: state.space!.name,
                  memberCount: state.space!.memberCount,
                  spacePrivacy: state.space!.privacy,
                  administratedBy:
                      state.space!.privacy == SocialSpacePrivacyEnum.private ? state.space!.owner!.name : null,
                  posts: state.socialFeedEntity.posts,
                  getMorePosts: () => _getFeed(
                    socialFeedEntity: state.socialFeedEntity,
                    socialSpaceEntity: state.space,
                  ),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  bool canStateShowPage(SocialSpaceFeedState state) {
    return state is LoadedSocialSpaceFeedState ||
        state is LoadedMoreSocialSpaceFeedState ||
        state is LoadingMoreSocialSpaceFeedState ||
        state is EmptyLoadedMoreSocialSpaceFeedState;
  }

  void _getFeed({SocialFeedEntity? socialFeedEntity, SocialSpaceEntity? socialSpaceEntity}) {
    socialSpaceFeedBloc.add(
      GetSocialSpaceFeedEvent(
        spacePermaname: permaname,
        since: DateTime.now(),
        socialFeedEntity: socialFeedEntity,
        space: socialSpaceEntity,
      ),
    );
  }
}
