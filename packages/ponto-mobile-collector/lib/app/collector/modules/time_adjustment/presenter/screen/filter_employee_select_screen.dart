import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../generated/l10n/collector_localizations.dart';
import '../../../../core/domain/services/navigator/navigator_service.dart';
import '../../../../core/infra/utils/iutils.dart';
import '../../../../core/presenter/widgets/loading/loading_widget.dart';
import '../../../facial_recognition/presenter/screens/employee_item_widget.dart';
import '../../../facial_recognition/presenter/screens/feedback_screen.dart';
import '../bloc/filter_employee_select/filter_employee_select_bloc.dart';
import '../bloc/filter_employee_select/filter_employee_select_event.dart';
import '../bloc/filter_employee_select/filter_employee_select_state.dart';
import '../bloc/period/period_bloc.dart';
import '../bloc/period/period_event.dart';
import '../bloc/timer_adjustment/timer_adjustment_bloc.dart';

class FilterEmployeeSelectScreen extends StatefulWidget {
  final FilterEmployeeSelectBloc _filterEmployeeSelectBloc;
  final IUtils _utils;
  final PeriodBloc _periodBloc;
  final TimerAdjustmentBloc _timerAdjustmentBloc;
  final NavigatorService _navigatorService;
  final Object? _routeArguments;

  const FilterEmployeeSelectScreen({
    required PeriodBloc periodBloc,
    required TimerAdjustmentBloc timerAdjustmentBloc,
    required FilterEmployeeSelectBloc filterEmployeeSelectBloc,
    required IUtils utils,
    required NavigatorService navigatorService,
    required Object? routeArguments,
    super.key,
  })  : _periodBloc = periodBloc,
        _timerAdjustmentBloc = timerAdjustmentBloc,
        _navigatorService = navigatorService,
        _filterEmployeeSelectBloc = filterEmployeeSelectBloc,
        _utils = utils,
        _routeArguments = routeArguments;

  @override
  FilterEmployeeSelectScreenState createState() =>
      FilterEmployeeSelectScreenState();
}

class FilterEmployeeSelectScreenState
    extends State<FilterEmployeeSelectScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    if (widget._routeArguments != null) {
      widget._filterEmployeeSelectBloc.username =
          widget._routeArguments as String;
    }

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0) {
          widget._filterEmployeeSelectBloc.add(FilterEmployeeLoadMoreEvent());
        }
      }
    });
    widget._filterEmployeeSelectBloc.add(FilterEmployeeInitEvent());
  }

  @override
  void dispose() async {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeRepository>(context).isDarkTheme();

    return BlocBuilder<FilterEmployeeSelectBloc, FilterEmployeeSelectState>(
      bloc: widget._filterEmployeeSelectBloc,
      builder: (context, state) {
        if (state is FilterEmployeeSearchOffline) {
          return FeedbackScreen(
            buttons: [
              SeniorButton(
                label: CollectorLocalizations.of(context).facialTryAgain,
                onPressed: () => widget._navigatorService.pop(),
                fullWidth: true,
                style: const SeniorButtonStyle(
                  backgroundColor: SeniorColors.primaryColor600,
                ),
              ),
            ],
            feedbackType: FeedbackTypeEnum.error,
            subtitle: CollectorLocalizations.of(context)
                .facialRegistrationOnlineCheckConnection,
            title: CollectorLocalizations.of(context).facialLooksLikeAreOffline,
            navigatorService: widget._navigatorService,
          );
        }

        if (state is FilterEmployeeSearchFailure) {
          return FeedbackScreen(
            feedbackType: FeedbackTypeEnum.alert,
            title: CollectorLocalizations.of(context).unresponsiveService,
            subtitle: CollectorLocalizations.of(context)
                .unresponsiveServiceDescription,
            buttons: [
              SeniorButton(
                label: CollectorLocalizations.of(context).facialTryAgain,
                onPressed: () => widget._navigatorService.pop(),
                fullWidth: true,
                style: const SeniorButtonStyle(
                  backgroundColor: SeniorColors.primaryColor600,
                ),
              ),
            ],
            navigatorService: widget._navigatorService,
          );
        }

        return Scaffold(
          body: SeniorColorfulHeaderStructure(
            hasTopPadding: true,
            hideLeading: true,
            title: const Text(''),
            actions: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  FontAwesomeIcons.xmark,
                  color: SeniorColors.pureWhite,
                ),
              ),
            ],
            body: state is FilterEmployeeSearchInitial
                ? const LoadingWidget(bottomLabel: '')
                : Padding(
                    padding: const EdgeInsets.all(SeniorSpacing.normal),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: SeniorSpacing.xsmall,
                        ),
                        SeniorTextField(
                          disabled: widget._filterEmployeeSelectBloc.state
                              is FilterEmployeeSearchInProgress,
                          prefixWidget: IconButton(
                            color: isDark
                                ? SeniorColors.pureWhite
                                : SeniorColors.neutralColor800,
                            icon: const Icon(
                              FontAwesomeIcons.magnifyingGlass,
                            ),
                            iconSize: SeniorSpacing.small,
                            onPressed: () {
                              widget._filterEmployeeSelectBloc.search();
                            },
                          ),
                          label:
                              CollectorLocalizations.of(context).searchEmployee,
                          keyboardType: TextInputType.text,
                          suffixWidget: IconButton(
                            onPressed: () {
                              widget._filterEmployeeSelectBloc
                                  .add(FilterEmployeeClearInputEvent());
                            },
                            icon: const Icon(
                              FontAwesomeIcons.xmark,
                            ),
                          ),
                          controller: TextEditingController(
                            text: widget._filterEmployeeSelectBloc
                                .getNameSearch(),
                          ),
                          onChanged: (employeeNameSearch) {
                            widget._filterEmployeeSelectBloc
                                .changeNameSearch(employeeNameSearch);
                          },
                          onEditingComplete: () {
                            widget._filterEmployeeSelectBloc
                                .add(FilterEmployeeSearchEvent(page: 0));
                          },
                        ),
                        Row(
                          children: [
                            SeniorText.small(
                              CollectorLocalizations.of(context).employeeList,
                            ),
                          ],
                        ),
                        Expanded(
                          child: Builder(
                            builder: (context) {
                              if (state is FilterReadyContent ||
                                  state is FilterEmployeeSelected) {
                                return ListView.builder(
                                  controller: _scrollController,
                                  itemCount: widget._filterEmployeeSelectBloc
                                      .employees.length,
                                  itemBuilder: (context, index) {
                                    bool isEmployeeSelect = isEmployeeSelected(
                                      index,
                                    );
                                    return EmployeeItemWidget(
                                      selected: isEmployeeSelect,
                                      index: index,
                                      onTap: () => {
                                        widget._filterEmployeeSelectBloc.add(
                                          FilterEmployeeSelectEmployeeEvent(
                                            employeeId: widget
                                                ._filterEmployeeSelectBloc
                                                .employees[index]
                                                .id,
                                          ),
                                        ),
                                      },
                                      name: widget._filterEmployeeSelectBloc
                                          .employees[index].name,
                                      identifier: widget._utils.maskCPF(
                                        cpf: widget._filterEmployeeSelectBloc
                                            .employees[index].identifier,
                                      ),
                                    );
                                  },
                                );
                              }

                              return const SizedBox();
                            },
                          ),
                        ),
                        if (state
                            is FilterEmployeeSearchLoadMoreInProgress) ...[
                          const Padding(
                            padding: EdgeInsets.all(SeniorSpacing.xxsmall),
                            child: SeniorLoading(),
                          ),
                        ],
                        const SizedBox(height: SeniorSpacing.normal),
                        SeniorButton(
                          disabled: widget._filterEmployeeSelectBloc
                              .employeesSelected.isEmpty,
                          fullWidth: true,
                          label:
                              '${CollectorLocalizations.of(context).filter}(${widget._filterEmployeeSelectBloc.employeesSelected.length})',
                          onPressed: () {
                            widget._periodBloc.add(
                              FilterEmployeeEvent(
                                employeesIds: widget._filterEmployeeSelectBloc
                                    .employeesSelected,
                                isEmployeesSelected: true,
                              ),
                            );
                            widget._timerAdjustmentBloc.employeeId = widget
                                ._filterEmployeeSelectBloc.employeesSelected.first;
                            widget._navigatorService.pop();
                          },
                        ),
                        SeniorButton(
                          style: SeniorButtonStyle(
                            backgroundColor: isDark
                                ? Colors.transparent
                                : SeniorColors.pureWhite,
                            contentColor: isDark
                                ? SeniorColors.primaryColor300
                                : SeniorColors.primaryColor,
                          ),
                          outlined: false,
                          disabled: false,
                          fullWidth: true,
                          label:
                              CollectorLocalizations.of(context).removeFilter,
                          onPressed: () {
                            widget._filterEmployeeSelectBloc
                                .add(FilterEmployeeClearSelectionEvent());
                          },
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }

  bool isEmployeeSelected(int index) {
    return widget._filterEmployeeSelectBloc.employeesSelected
        .contains(widget._filterEmployeeSelectBloc.employees[index].id);
  }
}
