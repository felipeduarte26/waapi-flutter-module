import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/constants/assets_path.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../../core/widgets/waapi_loading_widget.dart';
import '../blocs/search_naturality/search_naturality_bloc.dart';
import '../blocs/search_naturality/search_naturality_event.dart';
import '../blocs/search_naturality/search_naturality_state.dart';

class NaturalitySearchListViewWidget extends StatelessWidget {
  final SearchNaturalityBloc searchNaturalityBloc;
  final String initialTitle;
  final String initialSubtitle;
  final String noFoundTitle;
  final String noFoundSubtitle;

  const NaturalitySearchListViewWidget({
    Key? key,
    required this.searchNaturalityBloc,
    required this.initialTitle,
    required this.initialSubtitle,
    required this.noFoundTitle,
    required this.noFoundSubtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchNaturalityState = searchNaturalityBloc.state;

    if (searchNaturalityState is InitialSearchNaturalityState) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: EmptyStateWidget(
          key: const Key('profile-naturality_search_list_view_widget-initial_state'),
          title: initialTitle,
          subTitle: initialSubtitle,
          imagePath: AssetsPath.generalSearchState,
          imageHeight: 120,
        ),
      );
    } else if (searchNaturalityState is LoadingSearchNaturalityState) {
      return const SliverToBoxAdapter(
        child: Align(
          key: Key('profile-naturality_search_list_view_widget-loading_state'),
          alignment: Alignment.topCenter,
          child: WaapiLoadingWidget(),
        ),
      );
    } else if (searchNaturalityState is EmptyStateSearchNaturalityState) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: EmptyStateWidget(
          key: const Key('profile-naturality_search_list_view_widget-empty_state'),
          title: noFoundTitle,
          subTitle: noFoundSubtitle,
          imagePath: AssetsPath.generalSearchState,
          imageHeight: 120,
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, index) {
          return SeniorMenuItemList(
            rightPadding: SeniorSpacing.normal,
            leftPadding: SeniorSpacing.normal,
            key: Key(
              'profile-naturality_search_list_view_widget-item_$index',
            ),
            title: searchNaturalityState.naturalityList[index].name!,
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              searchNaturalityBloc.add(
                SelectNaturalityFromEntityToProfileEvent(
                  naturalityEntity: searchNaturalityState.naturalityList[index],
                ),
              );
              Modular.to.pop();
            },
          );
        },
        childCount: searchNaturalityState.naturalityList.length,
      ),
    );
  }
}
