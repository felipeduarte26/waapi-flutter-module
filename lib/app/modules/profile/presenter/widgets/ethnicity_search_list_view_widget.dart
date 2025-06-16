import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/constants/assets_path.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../../core/widgets/waapi_loading_widget.dart';
import '../blocs/search_ethnicity_bloc/search_ethnicity_bloc.dart';

class EthnicitySearchListViewWidget extends StatelessWidget {
  final SearchEthnicityBloc searchEthnicityBloc;
  final String initialTitle;
  final String initialSubtitle;
  final String noFoundTitle;
  final String noFoundSubtitle;

  const EthnicitySearchListViewWidget({
    super.key,
    required this.searchEthnicityBloc,
    required this.initialTitle,
    required this.initialSubtitle,
    required this.noFoundTitle,
    required this.noFoundSubtitle,
  });

  @override
  Widget build(BuildContext context) {
    final searchEthnicityState = searchEthnicityBloc.state;
    if (searchEthnicityState is LoadingSearchEthnicityState || searchEthnicityState is InitialSearchEthnicityState) {
      return const SliverToBoxAdapter(
        child: Align(
          key: Key('profile-Ethnicity_search_list_view_widget-loading_state'),
          alignment: Alignment.topCenter,
          child: WaapiLoadingWidget(),
        ),
      );
    } else if (searchEthnicityState is EmptySearchEthnicityState) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: EmptyStateWidget(
          key: const Key('profile-Ethnicity_search_list_view_widget-empty_state'),
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
              'profile-Ethnicity_search_list_view_widget-item_$index',
            ),
            title: searchEthnicityState.ethnicityList[index].name ?? '',
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              searchEthnicityBloc.add(
                SelectEthnicityFromEntityToProfileEvent(
                  ethnicityEntity: searchEthnicityState.ethnicityList[index],
                ),
              );
              Modular.to.pop();
            },
          );
        },
        childCount: searchEthnicityState.ethnicityList.length,
      ),
    );
  }
}
