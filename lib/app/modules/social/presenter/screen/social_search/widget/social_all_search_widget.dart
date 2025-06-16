import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:senior_design_tokens/tokens/senior_spacing.dart';
import '../../../../../../core/extension/translate_extension.dart';
import '../../../../domain/entities/social_post_entity.dart';
import '../../../../domain/entities/social_profile_entity.dart';
import '../../../../domain/entities/social_space_entity.dart';
import '../../../../enums/social_search_item_enum.dart';
import '../../../bloc/social_search/social_search_bloc.dart';

import '../../../bloc/social_search/social_search_state.dart';
import 'social_card_search_not_found_widget.dart';
import 'social_search_card_widget.dart';
import 'social_search_hashtags_list_widget.dart';
import 'social_search_people_list_widget.dart';
import 'social_search_post_list_widget.dart';
import 'social_search_space_list_widget.dart';

class SocialAllSearchWidget extends StatelessWidget {
  final int maxLean;
  final List<SocialProfileEntity> profiles;
  final List<SocialPostEntity> posts;
  final List<String> hashtags;
  final List<SocialSpaceEntity> spaces;
  final VoidCallback onButtonPressedProfiles;
  final VoidCallback onButtonPressedSpaces;
  final VoidCallback onButtonPressedTags;
  final VoidCallback onButtonPressedPosts;
  final VoidCallback onButtonSearchTryAgain;
  final SocialSearchBloc socialSearchBloc;

  const SocialAllSearchWidget({
    super.key,
    required this.maxLean,
    required this.profiles,
    required this.posts,
    required this.hashtags,
    required this.spaces,
    required this.onButtonPressedProfiles,
    required this.onButtonPressedSpaces,
    required this.onButtonPressedTags,
    required this.onButtonPressedPosts,
    required this.socialSearchBloc,
    required this.onButtonSearchTryAgain,
  });

  @override
  Widget build(BuildContext context) {
    bool contentError = false;
    bool spaceError = false;
    return BlocBuilder<SocialSearchBloc, SocialSearchState>(
      bloc: socialSearchBloc,
      builder: (context, state) {
        if (state is LoadedSocialSearchState) {
          contentError = state.getContentError;
          spaceError = state.getSpaceError;
        }
        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: SeniorSpacing.small),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SocialSearchCardWidget(
                  showButton: profiles.isNotEmpty,
                  title: context.translate.people,
                  buttonText: context.translate.seeMorePeople,
                  onButtonPressed: onButtonPressedProfiles,
                  child: profiles.isEmpty
                      ? SocialCardSearchNotFoundWidget(
                          onTap: onButtonSearchTryAgain,
                          errorStatus: contentError,
                          searchItemEnum: SocialSearchItemEnum.profiles,
                        )
                      : SocialSearchPeopleListWidget(
                          maxLeanProfile: profiles.length < maxLean ? profiles.length : maxLean,
                          profiles: profiles,
                        ),
                ),
                const Divider(),
                SocialSearchCardWidget(
                  showButton: spaces.isNotEmpty,
                  title: context.translate.groups,
                  buttonText: context.translate.seeMoreGroups,
                  onButtonPressed: onButtonPressedSpaces,
                  child: spaces.isEmpty
                      ? SocialCardSearchNotFoundWidget(
                          onTap: onButtonSearchTryAgain,
                          errorStatus: spaceError,
                          searchItemEnum: SocialSearchItemEnum.space,
                        )
                      : SocialSearchSpaceListWidget(
                          maxLeanSpace: spaces.length < maxLean ? spaces.length : maxLean,
                          spaces: spaces,
                        ),
                ),
                const Divider(),
                SocialSearchCardWidget(
                  showButton: hashtags.isNotEmpty,
                  title: context.translate.hashtags,
                  buttonText: context.translate.seeMoreHashtags,
                  onButtonPressed: onButtonPressedTags,
                  child: hashtags.isEmpty
                      ? SocialCardSearchNotFoundWidget(
                          onTap: onButtonSearchTryAgain,
                          errorStatus: contentError,
                          searchItemEnum: SocialSearchItemEnum.tags,
                        )
                      : SocialSearchHashtagsListWidget(
                          maxLeanHashtag: hashtags.length < maxLean ? hashtags.length : maxLean,
                          hashtags: hashtags,
                        ),
                ),
                const Divider(),
                SocialSearchCardWidget(
                  showButton: posts.isNotEmpty,
                  title: context.translate.posts,
                  buttonText: context.translate.seeMorePosts,
                  onButtonPressed: onButtonPressedPosts,
                  child: posts.isEmpty
                      ? SocialCardSearchNotFoundWidget(
                          onTap: onButtonSearchTryAgain,
                          searchItemEnum: SocialSearchItemEnum.posts,
                          errorStatus: contentError,
                        )
                      : SocialSearchPostListWidget(
                          maxLeanPosts: posts.length < maxLean ? posts.length : maxLean,
                          posts: posts,
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
