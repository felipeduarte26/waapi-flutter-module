import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/constants/assets_path.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../../core/widgets/waapi_loading_widget.dart';
import '../blocs/search_nationality/search_nationality_bloc.dart';
import '../blocs/search_nationality/search_nationality_event.dart';
import '../blocs/search_nationality/search_nationality_state.dart';

class NationalitySearchListViewWidget extends StatelessWidget {
  final SearchNationalityBloc searchNationalityBloc;
  final String initialTitle;
  final String initialSubtitle;
  final String noFoundTitle;
  final String noFoundSubtitle;

  const NationalitySearchListViewWidget({
    Key? key,
    required this.searchNationalityBloc,
    required this.initialTitle,
    required this.initialSubtitle,
    required this.noFoundTitle,
    required this.noFoundSubtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchNationalityState = searchNationalityBloc.state;

    if (searchNationalityState is InitialSearchNationalityState) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: EmptyStateWidget(
          key: const Key('profile-nationality_search_list_view_widget-initial_state'),
          title: initialTitle,
          subTitle: initialSubtitle,
          imagePath: AssetsPath.generalSearchState,
          imageHeight: 120,
        ),
      );
    } else if (searchNationalityState is LoadingSearchNationalityState) {
      return const SliverToBoxAdapter(
        child: Align(
          key: Key('profile-nationality_search_list_view_widget-loading_state'),
          alignment: Alignment.topCenter,
          child: WaapiLoadingWidget(),
        ),
      );
    } else if (searchNationalityState is EmptyStateSearchNationalityState) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: EmptyStateWidget(
          key: const Key('profile-nationality_search_list_view_widget-empty_state'),
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
              'profile-nationality_search_list_view_widget-item_$index',
            ),
            title: searchNationalityState.nationalityList[index].name!,
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              searchNationalityBloc.add(
                SelectNationalityFromEntityToProfileEvent(
                  nationalityEntity: searchNationalityState.nationalityList[index],
                ),
              );
              Modular.to.pop();
            },
          );
        },
        childCount: searchNationalityState.nationalityList.length,
      ),
    );
  }
}
