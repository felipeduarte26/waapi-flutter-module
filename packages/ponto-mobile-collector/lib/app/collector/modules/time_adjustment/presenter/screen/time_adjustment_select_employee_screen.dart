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
import '../bloc/time_adjustment_select_employee_bloc/time_adjustment_select_employee_bloc.dart';
import '../bloc/time_adjustment_select_employee_bloc/time_adjustment_select_employee_event.dart';
import '../bloc/time_adjustment_select_employee_bloc/time_adjustment_select_employee_state.dart';
import '../bloc/timer_adjustment/timer_adjustment_bloc.dart';
import '../bloc/timer_adjustment/timer_adjustment_event.dart';

class TimeAdjustmentSelectEmployeeScreen extends StatefulWidget {
  final TimeAdjustmentSelectEmployeeBloc _timeAdjustmentSelectEmployeeBloc;
  final IUtils _utils;
  final TimerAdjustmentBloc _timerAdjustmentBloc;
  final NavigatorService _navigatorService;
  final Object? _routeArguments;

  const TimeAdjustmentSelectEmployeeScreen({
    required TimeAdjustmentSelectEmployeeBloc timeAdjustmentSelectEmployeeBloc,
    required TimerAdjustmentBloc timerAdjustmentBloc,
    required IUtils utils,
    required NavigatorService navigatorService,
    required Object? routeArguments,
    super.key,
  })  : _timeAdjustmentSelectEmployeeBloc = timeAdjustmentSelectEmployeeBloc,
        _timerAdjustmentBloc = timerAdjustmentBloc,
        _navigatorService = navigatorService,
        _utils = utils,
        _routeArguments = routeArguments;

  @override
  TimeAdjustmentSelectEmployeeScreenState createState() =>
      TimeAdjustmentSelectEmployeeScreenState();
}

class TimeAdjustmentSelectEmployeeScreenState
    extends State<TimeAdjustmentSelectEmployeeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (widget._routeArguments != null) {
      widget._timeAdjustmentSelectEmployeeBloc.username =
          widget._routeArguments as String;
    }

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0) {
          widget._timeAdjustmentSelectEmployeeBloc.add(
            TimeAdjustmentSelectEmployeeLoadMore(),
          );
        }
      }
    });

    widget._timeAdjustmentSelectEmployeeBloc.add(
      TimeAdjustmentSelectEmployeeSearch(),
    );
  }

  @override
  void dispose() async {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeRepository>(context).isDarkTheme();

    return BlocBuilder<TimeAdjustmentSelectEmployeeBloc,
        TimeAdjustmentSelectEmployeeState>(
      bloc: widget._timeAdjustmentSelectEmployeeBloc,
      builder: (context, state) {
        var selectedEmployee =
            widget._timeAdjustmentSelectEmployeeBloc.selectedEmployee;

        var hasSelectedEmployee = selectedEmployee != null;

        var disableInputs = false;
        var showLoading = false;

        if (state is MultipleEmployeeSearchInProgress) {
          disableInputs = true;
        }

        if (state is MultipleEmployeeSearchInitial) {
          showLoading = true;
        }

        if (state is MultipleEmployeeSearchFailure) {
          return FeedbackScreen(
            feedbackType: FeedbackTypeEnum.alert,
            title: CollectorLocalizations.of(context).unresponsiveService,
            subtitle: CollectorLocalizations.of(context)
                .unresponsiveServiceDescription,
            buttons: [
              SeniorButton(
                label: CollectorLocalizations.of(context).facialBackStart,
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
            body: showLoading
                ? const LoadingWidget(bottomLabel: '')
                : Padding(
                    padding: const EdgeInsets.all(SeniorSpacing.normal),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: SeniorSpacing.xsmall,
                        ),
                        SeniorTextField(
                          disabled: disableInputs,
                          prefixWidget: IconButton(
                            color: isDark
                                ? SeniorColors.pureWhite
                                : SeniorColors.neutralColor800,
                            icon: const Icon(
                              FontAwesomeIcons.magnifyingGlass,
                            ),
                            iconSize: SeniorSpacing.small,
                            onPressed: () {
                              widget._timeAdjustmentSelectEmployeeBloc.add(
                                TimeAdjustmentSelectEmployeeSearch(),
                              );
                            },
                          ),
                          label:
                              CollectorLocalizations.of(context).searchEmployee,
                          keyboardType: TextInputType.text,
                          suffixWidget: IconButton(
                            onPressed: () {
                              widget._timeAdjustmentSelectEmployeeBloc.add(
                                TimeAdjustmentSelectEmployeeSearchClean(),
                              );
                            },
                            icon: const Icon(
                              FontAwesomeIcons.xmark,
                            ),
                          ),
                          controller: TextEditingController(
                            text: widget._timeAdjustmentSelectEmployeeBloc
                                .getNameSearch(),
                          ),
                          onChanged: (employeeNameSearch) {
                            widget._timeAdjustmentSelectEmployeeBloc.add(
                              TimeAdjustmentSelectEmployeeSearching(
                                employeeNameSearch: employeeNameSearch,
                              ),
                            );
                          },
                          onEditingComplete: () {
                            widget._timeAdjustmentSelectEmployeeBloc.add(
                              TimeAdjustmentSelectEmployeeSearch(),
                            );
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
                              if (state is MultipleReadyContent ||
                                  state is MultipleEmployeeSelected) {
                                return ListView.builder(
                                  controller: _scrollController,
                                  itemCount: widget
                                      ._timeAdjustmentSelectEmployeeBloc
                                      .employees
                                      .length,
                                  itemBuilder: (context, index) {
                                    var employee = widget
                                        ._timeAdjustmentSelectEmployeeBloc
                                        .employees[index];

                                    bool isEmployeeSelect = widget
                                            ._timeAdjustmentSelectEmployeeBloc
                                            .selectedEmployee ==
                                        employee.id;

                                    return EmployeeItemWidget(
                                      selected: isEmployeeSelect,
                                      index: index,
                                      onTap: () {
                                        widget._timeAdjustmentSelectEmployeeBloc
                                            .add(
                                          TimeAdjustmentSelectedEmployee(
                                            employeeId: employee.id,
                                          ),
                                        );
                                      },
                                      name: employee.name,
                                      identifier: widget._utils.maskCPF(
                                        cpf: employee.identifier,
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
                            is MultipleEmployeeSearchLoadMoreInProgress) ...[
                          const Padding(
                            padding: EdgeInsets.all(SeniorSpacing.xxsmall),
                            child: SeniorLoading(),
                          ),
                        ],
                        const SizedBox(height: SeniorSpacing.normal),
                        SeniorButton(
                          disabled: !hasSelectedEmployee,
                          fullWidth: true,
                          label: CollectorLocalizations.of(context).selectItem,
                          onPressed: () {
                            if (hasSelectedEmployee) {
                              widget._timerAdjustmentBloc.add(
                                ChangedSelectedEmployee(selectedEmployee),
                              );
                              widget._navigatorService.pop();
                            }
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
                          label: CollectorLocalizations.of(context).close,
                          onPressed: () {
                            widget._navigatorService.pop();
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
}
