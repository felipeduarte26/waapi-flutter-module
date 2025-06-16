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
import '../../bloc/social_screen/social_screen_bloc.dart';
import '../../bloc/social_tag_feed/social_tag_feed_bloc.dart';
import '../../bloc/social_tag_feed/social_tag_feed_event.dart';
import '../../bloc/social_tag_feed/social_tag_feed_state.dart';
import '../../widget/modal/social_modal.dart';
import '../../widget/social_feed_empty_state_widget.dart';
import '../../widget/social_timeline_widget.dart';

class SocialTagScreen extends StatelessWidget {
  final String tag;
  final SocialTagFeedBloc socialTagFeedBloc;
  const SocialTagScreen({
    required this.tag,
    required this.socialTagFeedBloc,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);
    final isCustomTheme = themeRepository.isCustomTheme();
    final socialScreenBloc = Modular.get<SocialScreenBloc>();

    return Scaffold(
      body: WaapiColorfulHeader(
        title: SeniorText.label(
          context.translate.hashtags,
          color: isCustomTheme
              ? SeniorServiceColor.getOptimalContrastColorTheme(color: themeRepository.theme.secondaryColor!)
              : SeniorColors.pureWhite,
          darkColor: SeniorColors.grayscale5,
        ),
        body: BlocBuilder<SocialTagFeedBloc, SocialTagFeedState>(
          bloc: socialTagFeedBloc,
          builder: (_, state) {
            if (state is LoadingSocialTagFeedState) {
              return const WaapiLoadingWidget();
            }

            if (state is ErrorSocialTagFeedState) {
              return ErrorStateWidget(
                imagePath: AssetsPath.generalErrorState,
                title: context.translate.socialPostErrorTitle,
                subTitle: context.translate.tryAgainSoon,
                onTapTryAgain: () {
                  _getFeed();
                },
              );
            }

            if (state is EmptySocialTagFeedState) {
              return SocialFeedEmptyStateWidget(
                onPublish: () async {
                  await SocialModal.createPostModal(
                    context: context,
                    socialScreenBloc: socialScreenBloc,
                  );
                },
              );
            }

            if (canStateShowPage(state)) {
              return RefreshIndicator(
                onRefresh: () async => _getFeed(),
                color: isCustomTheme ? themeRepository.theme.primaryColor : SeniorColors.primaryColor,
                child: SocialTimelineWidget(
                  isLoading: state is LoadingMoreSocialTagFeedState,
                  endReached: state is EmptyLoadedMoreSocialTagFeedState,
                  name: tag,
                  getMorePosts: () {
                    _getFeed(socialFeedEntity: state.socialFeedEntity);
                  },
                  posts: state.socialFeedEntity!.posts,
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  void _getFeed({SocialFeedEntity? socialFeedEntity}) {
    socialTagFeedBloc.add(
      GetSocialTagFeedEvent(
        since: DateTime.now(),
        tag: tag,
        socialFeedEntity: socialFeedEntity,
      ),
    );
  }

  bool canStateShowPage(SocialTagFeedState state) {
    return state is LoadedSocialTagFeedState ||
        state is LoadedMoreSocialTagFeedState ||
        state is LoadingMoreSocialTagFeedState ||
        state is EmptyLoadedMoreSocialTagFeedState;
  }
}
