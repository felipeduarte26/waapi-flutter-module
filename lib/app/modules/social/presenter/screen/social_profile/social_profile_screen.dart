import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ponto_mobile_collector/app/collector/core/constants/assets_path.dart';
import 'package:ponto_mobile_collector/app/collector/core/widgets/error_state_widget.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/widgets/waapi_colorful_header.dart';
import '../../../../../core/widgets/waapi_loading_widget.dart';
import '../../../domain/entities/social_post_entity.dart';
import '../../../domain/entities/social_profile_entity.dart';
import '../../../enums/social_profile_type_enum.dart';
import '../../bloc/social_profile_posts/social_profile_posts_bloc.dart';
import '../../bloc/social_profile_posts/social_profile_posts_event.dart';
import '../../bloc/social_profile_posts/social_profile_posts_state.dart';
import '../../widget/social_feed_empty_state_widget.dart';
import '../../widget/social_timeline_widget.dart';

class SocialProfileScreen extends StatefulWidget {
  final String permaname;
  const SocialProfileScreen({
    required this.permaname,
    super.key,
  });

  @override
  State<SocialProfileScreen> createState() => _SocialProfileScreenState();
}

class _SocialProfileScreenState extends State<SocialProfileScreen> {
  late SocialProfilePostsBloc socialProfilePostsBloc;

  @override
  void initState() {
    super.initState();
    socialProfilePostsBloc = Modular.get<SocialProfilePostsBloc>();
    _getFeed();
  }

  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);
    final isCustomTheme = themeRepository.isCustomTheme();

    return Scaffold(
      body: WaapiColorfulHeader(
        title: SeniorText.label(
          color: isCustomTheme
              ? SeniorServiceColor.getOptimalContrastColorTheme(color: themeRepository.theme.secondaryColor!)
              : SeniorColors.pureWhite,
          darkColor: SeniorColors.grayscale5,
          context.translate.appTitle,
        ),
        body: BlocBuilder<SocialProfilePostsBloc, SocialProfilePostsState>(
          bloc: socialProfilePostsBloc,
          builder: (_, state) {
            if (state is LoadingSocialProfilePostsState) {
              return const WaapiLoadingWidget();
            }
            if (state is ErrorSocialProfilePostsState || state is ErrorLoadedMoreSocialProfilePostsState) {
              return ErrorStateWidget(
                imagePath: AssetsPath.generalErrorState,
                title: context.translate.socialPostErrorTitle,
                subTitle: context.translate.tryAgainSoon,
                onTapTryAgain: () {
                  _getFeed();
                },
              );
            }

            if (state is EmptySocialProfilePostsState) {
              return const SocialFeedEmptyStateWidget(
                showPublish: false,
              );
            }

            if (state is LoadedSocialProfilePostsState ||
                state is LoadedMoreSocialProfilePostsState ||
                state is LoadingMoreSocialProfilePostsState ||
                state is EmptyLoadedMoreSocialProfilePostsState) {
              return RefreshIndicator(
                onRefresh: () async => _getFeed(),
                color: isCustomTheme ? themeRepository.theme.primaryColor : SeniorColors.primaryColor,
                child: SocialTimelineWidget(
                  isLoading: state is LoadingMoreSocialProfilePostsState,
                  endReached: state is EmptyLoadedMoreSocialProfilePostsState,
                  name: state.socialProfileEntity!.name,
                  avatarUrl: state.socialProfileEntity!.avatarUrl,
                  isCorporateProfile: state.socialProfileEntity!.profileType == SocialProfileTypeEnum.corporateProfile,
                  getMorePosts: () => _getFeed(
                    socialPostsEntity: state.socialPostsEntity,
                    socialProfileEntity: state.socialProfileEntity,
                  ),
                  posts: state.socialPostsEntity,
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  void _getFeed({
    List<SocialPostEntity> socialPostsEntity = const [],
    SocialProfileEntity? socialProfileEntity,
  }) {
    socialProfilePostsBloc.add(
      GetSocialProfilePostsEvent(
        socialPostsEntity: socialPostsEntity,
        permaname: widget.permaname,
        lastSeenId: socialPostsEntity.isNotEmpty ? socialPostsEntity.last.id : null,
        socialProfileEntity: socialProfileEntity,
      ),
    );
  }
}
