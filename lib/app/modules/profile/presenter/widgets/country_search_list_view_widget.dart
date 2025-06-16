import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/constants/assets_path.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../../core/widgets/waapi_loading_widget.dart';
import '../blocs/search_country_bloc/search_country_bloc.dart';
import '../blocs/search_country_bloc/search_country_event.dart';
import '../blocs/search_country_bloc/search_country_state.dart';

class CountrySearchListViewWidget extends StatelessWidget {
  final SearchCountryBloc searchCountryBloc;
  final String initialTitle;
  final String initialSubtitle;
  final String noFoundTitle;
  final String noFoundSubtitle;

  const CountrySearchListViewWidget({
    Key? key,
    required this.searchCountryBloc,
    required this.initialTitle,
    required this.initialSubtitle,
    required this.noFoundTitle,
    required this.noFoundSubtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchCountryState = searchCountryBloc.state;

    if (searchCountryState is InitialSearchCountryState) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: EmptyStateWidget(
          key: const Key('profile-country_search_list_view_widget-initial_state'),
          title: initialTitle,
          subTitle: initialSubtitle,
          imagePath: AssetsPath.generalSearchState,
          imageHeight: 120,
        ),
      );
    } else if (searchCountryState is LoadingSearchCountryState) {
      return const SliverToBoxAdapter(
        child: Align(
          key: Key('profile-country_search_list_view_widget-loading_state'),
          alignment: Alignment.topCenter,
          child: WaapiLoadingWidget(),
        ),
      );
    } else if (searchCountryState is EmptyStateSearchCountryState) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: EmptyStateWidget(
          key: const Key('profile-country_search_list_view_widget-empty_state'),
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
              'profile-Country_search_list_view_widget-item_$index',
            ),
            title: searchCountryState.countryList[index].name!,
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              searchCountryBloc.add(
                SelectCountryFromEntityToProfileEvent(
                  countryEntity: searchCountryState.countryList[index],
                ),
              );
              Modular.to.pop();
            },
          );
        },
        childCount: searchCountryState.countryList.length,
      ),
    );
  }
}
