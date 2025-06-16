import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:senior_design_system/components/components.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../ponto_mobile_collector.dart';
import '../../../../core/domain/services/navigator/navigator_service.dart';
import '../../../clocking_event/domain/usecase/show_bottom_sheet_usecase.dart';
import '../../../clocking_event/presenter/bloc/synchronize_clocking_event/synchronize_clocking_event_bloc.dart';
import '../../../routes/collector_routes.dart';
import '../../../routes/time_adjustment_multi_routes.dart';

class TimeAdjustmentPeriodScreen extends StatefulWidget {
  final PeriodBloc _periodBloc;
  final TimerAdjustmentBloc _timerAdjustmentBloc;
  final SynchronizeClockingEventBloc _synchronizeClockingEventBloc;
  final TabActionBloc _tabActionBloc;
  final IUtils _utils;
  final IShowBottomSheetUsecase _showBottomSheetUsecase;
  final bool isMulti;
  final bool isManagerOrAdmin;
  final NavigatorService _navigatorService;
  final String? username;

  const TimeAdjustmentPeriodScreen(
    this._navigatorService,
    this._periodBloc,
    this._tabActionBloc,
    this._timerAdjustmentBloc,
    this._synchronizeClockingEventBloc,
    this._utils,
    this._showBottomSheetUsecase,
    this.username, {
    this.isMulti = false,
    this.isManagerOrAdmin = false,
    super.key,
  });

  @override
  State<TimeAdjustmentPeriodScreen> createState() =>
      _TimeAdjustmentPeriodScreenState();
}

class _TimeAdjustmentPeriodScreenState
    extends State<TimeAdjustmentPeriodScreen> {
  DateFormat? formatter;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    widget._periodBloc.username = widget.username;
    widget._periodBloc.add(
      LoadPeriodEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    formatter ??= DateFormat(CollectorLocalizations.of(context).dateFormatter);

    return BlocBuilder<PeriodBloc, PeriodState>(
      bloc: widget._periodBloc,
      builder: (context, state) {
        if (state is LoadingDayInfoState) {
          return LoadingWidget(
            bottomLabel: CollectorLocalizations.of(context).loading,
          );
        }

        var initialDateFilter = widget._periodBloc.initialDateFilter;
        var finalDateFilter = widget._periodBloc.finalDateFilter;
        var isPeriodSelected = widget._periodBloc.isPeriodSelected;
        var isEmployeesSelected = widget._periodBloc.isEmployeesSelected;
        var requestDate = widget._periodBloc.requestDate;

        return Center(
          child: Column(
            children: [
              SeniorCalendarHeader(
                headerTitle: CollectorLocalizations.of(context).rangeDate(
                  formatter!.format(initialDateFilter),
                  formatter!.format(finalDateFilter),
                ),
                onLeftButtonPressed: () {
                  widget._periodBloc.add(
                    BackWeekPeriodEvent(),
                  );
                },
                onRightButtonPressed: () {
                  widget._periodBloc.add(
                    AheadWeekPeriodEvent(),
                  );
                },
                showHeader: true,
                showHeaderButtons: !widget._periodBloc.isPeriodSelected,
              ),

              /// Filters Badges
              BadgesSlider(
                badgesInfo: [
                  BadgeInfo(
                    isSelected: isPeriodSelected,
                    label: CollectorLocalizations.of(context).period,
                    value: FilterBadgeType.filterByPeriod,
                    callback: (isSelected) async {
                      if (isSelected) {
                        await widget._showBottomSheetUsecase.call(
                          context: context,
                          content: [
                            DatePeriodFilterWidget(
                              utils: widget._utils,
                              formKey: formKey,
                              onInitDateChanged: (value) {},
                              onEndDateChanged: (value) {},
                              onFilterPressed: (initDate, endDate) {
                                if (formKey.currentState?.validate() ?? false) {
                                  final collectorLocalizations =
                                      CollectorLocalizations.of(context);

                                  final initDateTime = DateFormat.yMd(
                                    collectorLocalizations.localeName,
                                  ).parse(
                                    initDate,
                                  );
                                  final endDateTime = DateFormat.yMd(
                                    collectorLocalizations.localeName,
                                  ).parse(
                                    endDate,
                                  );

                                  widget._periodBloc.add(
                                    FilterPeriodEvent(
                                      initDate: initDateTime,
                                      endDate: endDateTime,
                                      isPeriodSelected: isSelected,
                                    ),
                                  );

                                  Navigator.pop(context);
                                }
                              },
                            ),
                          ],
                        );
                      } else {
                        widget._periodBloc.add(
                          TodayPeriodEvent(),
                        );
                      }
                    },
                  ),
                  if (widget.isManagerOrAdmin) ...[
                    BadgeInfo(
                      label: CollectorLocalizations.of(context)
                          .cardReceiptEmployeeName,
                      value: FilterBadgeType.filterByEmployee,
                      isSelected: isEmployeesSelected,
                      callback: (isSelected) {
                        if (isSelected) {
                          widget._navigatorService.pushNamed(
                            route:
                                '/${PontoMobileCollectorRoutes.module}/${TimeAdjustmentMultiRoutes.filterEmployeeFull}',
                            arguments: widget.username,
                          );
                        } else {
                          // se não estiver selecionado, remove o filtro
                          widget._periodBloc.add(
                            FilterEmployeeEvent(
                              employeesIds: null,
                              isEmployeesSelected: isSelected,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ],
                multipleSelect: true,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SeniorSpacing.normal,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          FontAwesomeIcons.calendarWeek,
                          size: SeniorIconSize.small,
                          color: SeniorColors.secondaryColor600,
                        ),
                        const SizedBox(
                          width: SeniorSpacing.xsmall,
                        ),
                        Expanded(
                          child: SeniorText.labelBold(
                            CollectorLocalizations.of(context)
                                .periodClockingEvent,
                          ),
                        ),
                        IconButton(
                          alignment: Alignment.centerRight,
                          onPressed: () {
                            widget._showBottomSheetUsecase.call(
                              context: context,
                              content: [
                                const ClockingEventInfoWidget(
                                  showSynced: true,
                                  showOdd: true,
                                ),
                              ],
                            );
                          },
                          icon: const Icon(
                            FontAwesomeIcons.solidCircleQuestion,
                            size: SeniorIconSize.small,
                            color: SeniorColors.secondaryColor600,
                          ),
                        ),
                      ],
                    ),
                    SeniorText.small(
                      CollectorLocalizations.of(context).lastUpdate(
                        DateFormat(
                          DateFormat.YEAR_NUM_MONTH_DAY,
                          CollectorLocalizations.of(context).localeName,
                        ).format(
                          requestDate,
                        ),
                        DateFormat(
                          DateFormat.HOUR_MINUTE,
                          CollectorLocalizations.of(context).localeName,
                        ).format(
                          requestDate,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    widget._periodBloc.add(
                      RefreshPeriodEvent(),
                    );
                  },
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      vertical: SeniorSpacing.xsmall,
                    ),
                    itemCount: state.data.length,
                    separatorBuilder: (context, _) {
                      return const SizedBox(
                        height: SeniorSpacing.xsmall,
                      );
                    },
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          widget._timerAdjustmentBloc.selectedDay =
                              state.data[index].day;

                          widget._tabActionBloc.add(
                            ChangeTabActionEvent(
                              tabIndexToChange: 1,
                            ),
                          );

                          if (widget.isMulti) {
                            widget._timerAdjustmentBloc.employeeId =
                                state.data[index].employee?.id;
                          }
                        },
                        child: TimeAdjustmentWidget(
                          widget._timerAdjustmentBloc,
                          widget._synchronizeClockingEventBloc,
                          widget._utils,
                          widget._showBottomSheetUsecase,
                          dayInfoModel: state.data[index],
                          isCollapsed: true,
                          showEmployeeName: widget.isManagerOrAdmin,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
