import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/constants/assets_path.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../../core/widgets/waapi_loading_widget.dart';
import '../blocs/feedback_person_bloc/feedback_person_bloc.dart';
import '../blocs/feedback_person_bloc/feedback_person_event.dart';
import '../blocs/search_employee_bloc/search_employee_bloc.dart';
import '../blocs/search_employee_bloc/search_employee_event.dart';
import '../blocs/search_employee_bloc/search_employee_state.dart';

class EmployeesSearchListViewWidget extends StatefulWidget {
  final SearchEmployeeBloc searchEmployeeBloc;
  final String initialTitle;
  final String initialSubtitle;
  final String noFoundTitle;
  final String noFoundSubtitle;

  const EmployeesSearchListViewWidget({
    Key? key,
    required this.searchEmployeeBloc,
    required this.initialTitle,
    required this.initialSubtitle,
    required this.noFoundTitle,
    required this.noFoundSubtitle,
  }) : super(key: key);

  @override
  State<EmployeesSearchListViewWidget> createState() => _EmployeesSearchListViewWidgetState();
}

class _EmployeesSearchListViewWidgetState extends State<EmployeesSearchListViewWidget> {
  late final FeedbackPersonBloc personBloc;

  @override
  void initState() {
    super.initState();
    personBloc = Modular.get<FeedbackPersonBloc>();
  }

  @override
  Widget build(BuildContext context) {
    final searchEmployeeState = widget.searchEmployeeBloc.state;

    if (searchEmployeeState is InitialSearchEmployeeState) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: EmptyStateWidget(
          key: const Key('feedback-employee_search_list_view_widget-initial_state'),
          title: widget.initialTitle,
          subTitle: widget.initialSubtitle,
          imagePath: AssetsPath.searchPersonEmptyState,
          imageHeight: 120,
        ),
      );
    } else if (searchEmployeeState is LoadingSearchEmployeeState) {
      return const SliverToBoxAdapter(
        child: Align(
          key: Key('feedback-employee_search_list_view_widget-loading_state'),
          alignment: Alignment.topCenter,
          child: WaapiLoadingWidget(),
        ),
      );
    } else if (searchEmployeeState is EmptyStateSearchEmployeesState) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: EmptyStateWidget(
          key: const Key('feedback-employee_search_list_view_widget-empty_state'),
          title: widget.noFoundTitle,
          subTitle: widget.noFoundSubtitle,
          imagePath: AssetsPath.searchPersonEmptyState,
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
              'feedback-employee_search_list_view_widget-item_$index',
            ),
            title: searchEmployeeState.employeeList[index].name,
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              widget.searchEmployeeBloc.add(
                SelectEmployeeFromEntityToWriteFeedbackEvent(
                  employeeEntity: searchEmployeeState.employeeList[index],
                ),
              );

              personBloc.add(
                GetFeedbackPersonIdEvent(
                  employeeId: searchEmployeeState.employeeList[index].id,
                ),
              );
            },
          );
        },
        childCount: searchEmployeeState.employeeList.length,
      ),
    );
  }
}
