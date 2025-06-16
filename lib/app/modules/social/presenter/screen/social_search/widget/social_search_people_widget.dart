import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/constants/assets_path.dart';
import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/widgets/empty_state_widget.dart';
import '../../../../domain/entities/social_profile_entity.dart';
import '../../../bloc/social_search/social_search_bloc.dart';
import '../../../bloc/social_search/social_search_state.dart';
import 'social_search_people_list_widget.dart';

class SocialSearchPeopleWidget extends StatelessWidget {
  final int? maxLeanProfile;
  final List<SocialProfileEntity> profiles;
  final SocialSearchBloc socialSearchBloc;
  final String termToSearch;

  const SocialSearchPeopleWidget({
    super.key,
    this.maxLeanProfile,
    required this.profiles,
    required this.socialSearchBloc,
    this.termToSearch = '',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        maxLeanProfile != null
            ? Padding(
                padding: const EdgeInsets.only(
                  left: SeniorSpacing.normal,
                  bottom: SeniorSpacing.xsmall,
                  top: SeniorSpacing.normal,
                ),
                child: SeniorText.body(
                  context.translate.people,
                  textProperties: const TextProperties(
                    textAlign: TextAlign.left,
                  ),
                ),
              )
            : const SizedBox.shrink(),
        if (socialSearchBloc.state is InitialSocialSearchState || socialSearchBloc.state is CleanSocialSearchState)
          EmptyStateWidget(
            key: const Key('search_social_content_empty_state_widget'),
            title: context.translate.searchPeople,
            imagePath: AssetsPath.generalSearchState,
            imageHeight: 120,
          ),
        if (socialSearchBloc.state is EmptySocialSearchState)
          EmptyStateWidget(
            key: const Key('search_social_content_empty_state_widget'),
            title: context.translate.noPersonFoundTerm,
            subTitle: context.translate.pleaseCheckTermUsingDifferentKeywordsResults,
            imagePath: AssetsPath.generalEmptyState,
            imageHeight: 120,
          ),
        if (socialSearchBloc.state is LoadedSocialSearchState || socialSearchBloc.state is LoadedMoreSocialSearchState)
          Expanded(
            child: SocialSearchPeopleListWidget(
              maxLeanProfile: maxLeanProfile,
              profiles: profiles,
              socialSearchBloc: socialSearchBloc,
              termToSearch: termToSearch,
            ),
          ),
      ],
    );
  }
}
