import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/constants/assets_path.dart';
import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/widgets/empty_state_widget.dart';
import '../../../../../../core/widgets/error_state_widget.dart';
import '../../../../../../core/widgets/waapi_loading_widget.dart';
import '../../../../enums/social_search_item_enum.dart';
import '../../../bloc/social_search/social_search_bloc.dart';

import '../../../bloc/social_search/social_search_state.dart';

class SocialBaseSearchWidget extends StatelessWidget {
  final SocialSearchBloc socialSearchBloc;
  final Widget child;
  final String termToSearch;
  final bool isEmpty;
  final SocialSearchItemEnum searchItemEnum;
  final VoidCallback onTapTryAgain;

  const SocialBaseSearchWidget({
    super.key,
    required this.socialSearchBloc,
    required this.child,
    this.termToSearch = '',
    this.isEmpty = false,
    required this.searchItemEnum,
    required this.onTapTryAgain,
  });

  @override
  Widget build(BuildContext context) {
    bool showError = false;
    return BlocBuilder<SocialSearchBloc, SocialSearchState>(
      bloc: socialSearchBloc,
      builder: (context, state) {
        if (state is LoadedSocialSearchState && searchItemEnum != SocialSearchItemEnum.all) {
          if (searchItemEnum == SocialSearchItemEnum.space) {
            showError = state.getSpaceError;
          } else {
            showError = state.getContentError;
          }
        }
        if (state is ErrorSocialSearchContentState || showError) {
          return ErrorStateWidget(
            key: const Key('search_social_content_empty_state_widget'),
            title: context.translate.socialPostErrorTitle,
            subTitle: context.translate.tryAgainSoon,
            imagePath: AssetsPath.generalErrorState,
            onTapTryAgain: onTapTryAgain,
          );
        }
        if (state is InitialSocialSearchState || state is CleanSocialSearchState) {
          return EmptyStateWidget(
            key: const Key('search_social_content_empty_state_widget'),
            title: context.translate.searchPeopleHashtagsPublications,
            imagePath: AssetsPath.generalSearchState,
            imageHeight: 120,
          );
        }
        if (state is EmptySocialSearchState || (isEmpty && state is! LoadingSocialSearchState)) {
          return EmptyStateWidget(
            key: const Key('search_social_content_empty_state_widget'),
            title: context.translate.noResultsFoundForTheEnteredTerm,
            subTitle: context.translate.pleaseCheckTermUsingDifferentKeywordsResults,
            imagePath: AssetsPath.generalEmptyState,
            imageHeight: 120,
          );
        }
        if (state is LoadedSocialSearchState ||
            state is LoadedMoreSocialSearchState ||
            state is LoadingMoreSocialSearchState) {
          return child;
        }

        return const WaapiLoadingWidget();
      },
    );
  }
}
