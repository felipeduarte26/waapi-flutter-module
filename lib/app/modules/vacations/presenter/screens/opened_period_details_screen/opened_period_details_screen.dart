import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../core/extension/media_query_extension.dart';
import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/widgets/waapi_colorful_header.dart';
import '../../../../../core/widgets/waapi_date_period_card_widget.dart';
import '../../../../../core/widgets/waapi_loading_widget.dart';
import '../../../../../routes/vacations_routes.dart';
import '../../blocs/vacations_bloc/vacations_bloc.dart';
import '../../blocs/vacations_bloc/vacations_event.dart';
import '../../blocs/vacations_bloc/vacations_state.dart';
import '../../widgets/vacation_receipt_card_widget.dart';
import '../../widgets/vacation_schedule_card_widget.dart';

class OpenedPeriodDetailsScreen extends StatefulWidget {
  final String vacationPeriodId;
  final String employeeId;

  const OpenedPeriodDetailsScreen({
    Key? key,
    required this.vacationPeriodId,
    required this.employeeId,
  }) : super(key: key);

  @override
  State<OpenedPeriodDetailsScreen> createState() {
    return _OpenedPeriodDetailsScreenState();
  }
}

class _OpenedPeriodDetailsScreenState extends State<OpenedPeriodDetailsScreen> {
  late final VacationsBloc _vacationsBloc;

  @override
  void initState() {
    super.initState();
    _vacationsBloc = Modular.get<VacationsBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WaapiColorfulHeader(
        hasTopPadding: false,
        titleLabel: context.translate.openPeriodDetails,
        body: BlocBuilder<VacationsBloc, VacationsState>(
          bloc: _vacationsBloc,
          builder: (_, state) {
            if (state is LoadingVacationsState) {
              return Container(
                padding: const EdgeInsets.only(
                  top: SeniorSpacing.normal,
                ),
                alignment: Alignment.topCenter,
                child: const WaapiLoadingWidget(
                  key: Key('vacations-paid_opened_details-loading_indicator'),
                ),
              );
            }

            final vacation = state.vacations!.firstWhere(
              (vacation) => vacation.vacationPeriodId == widget.vacationPeriodId,
            );

            var listItemIndex = 0;
            final vacationDetails = <Widget>[];

            vacationDetails.add(
              WaapiDatePeriodCardWidget(
                key: const Key('vacations-open_periods_details-header'),
                startDate: vacation.startDate!,
                endDate: vacation.endDate!,
                title: context.translate.vacationReceiptPeriod,
                padding: const EdgeInsets.only(
                  top: SeniorSpacing.normal,
                ),
              ),
            );

            if (vacation.vacationWaitingApproval != null && vacation.vacationWaitingApproval!.isNotEmpty) {
              final vacationWaitingApproval = vacation.vacationWaitingApproval?.map(
                (vacationWaitingApproval) {
                  return VacationScheduleCardWidget(
                    key: Key('vacations-open_periods_schedule-awaiting-approval-card${listItemIndex++}'),
                    vacationScheduleEntity: vacationWaitingApproval,
                    showActionIcon: true,
                    onTap: () async {
                      final isVacationCancel = await Modular.to.pushNamed(
                        VacationsRoutes.requestVacationDetailsScreenInitialRoute,
                        arguments: {
                          'vacationDetails': vacationWaitingApproval,
                          'employeeId': widget.employeeId,
                        },
                      );

                      if (isVacationCancel != null) {
                        _vacationsBloc.add(
                          GetVacationsEvent(
                            employeeId: widget.employeeId,
                          ),
                        );
                      }
                    },
                  );
                },
              ).toList();
              vacationDetails.addAll(vacationWaitingApproval!);
            }

            if (vacation.vacationUnderAnalysis != null && vacation.vacationUnderAnalysis!.isNotEmpty) {
              final vacationUnderAnalysis = vacation.vacationUnderAnalysis?.map(
                (vacationUnderAnalysis) {
                  return VacationScheduleCardWidget(
                    key: Key('vacations-open_periods_schedule-awaiting-vacationUnderAnalysis-card${listItemIndex++}'),
                    vacationScheduleEntity: vacationUnderAnalysis,
                    showActionIcon: true,
                    onTap: () async {
                      final isVacationCancel = await Modular.to.pushNamed(
                        VacationsRoutes.requestVacationDetailsScreenInitialRoute,
                        arguments: {
                          'vacationDetails': vacationUnderAnalysis,
                          'employeeId': widget.employeeId,
                        },
                      );

                      if (isVacationCancel != null) {
                        _vacationsBloc.add(
                          GetVacationsEvent(
                            employeeId: widget.employeeId,
                          ),
                        );
                      }
                    },
                  );
                },
              ).toList();
              vacationDetails.addAll(vacationUnderAnalysis!);
            }

            if (vacation.vacationReturnedToAdjustments != null && vacation.vacationReturnedToAdjustments!.isNotEmpty) {
              final vacationReturnedToAdjustments = vacation.vacationReturnedToAdjustments?.map(
                (vacationReturnedToAdjustments) {
                  return VacationScheduleCardWidget(
                    key: Key('vacations-open_periods_schedule-returned-adjustments-card${listItemIndex++}'),
                    vacationScheduleEntity: vacationReturnedToAdjustments,
                    showActionIcon: true,
                    onTap: () async {
                      final isVacationCancel = await Modular.to.pushNamed(
                        VacationsRoutes.requestVacationDetailsScreenInitialRoute,
                        arguments: {
                          'vacationDetails': vacationReturnedToAdjustments,
                          'employeeId': widget.employeeId,
                          'vacationPeriodId': widget.vacationPeriodId,
                        },
                      );

                      if (isVacationCancel != null) {
                        _vacationsBloc.add(
                          GetVacationsEvent(
                            employeeId: widget.employeeId,
                          ),
                        );
                      }
                    },
                  );
                },
              ).toList();
              vacationDetails.addAll(vacationReturnedToAdjustments!);
            }

            if (vacation.vacationSchedule != null && vacation.vacationSchedule!.isNotEmpty) {
              final vacationSchedule = vacation.vacationSchedule!.map(
                (vacationSchedule) {
                  return VacationScheduleCardWidget(
                    key: Key('vacations-open_periods_schedule-card-${listItemIndex++}'),
                    vacationScheduleEntity: vacationSchedule,
                    showActionIcon: true,
                    onTap: () async {
                      final isVacationCancel = await Modular.to.pushNamed(
                        VacationsRoutes.requestVacationDetailsScreenInitialRoute,
                        arguments: {
                          'vacationDetails': vacationSchedule,
                          'employeeId': widget.employeeId,
                        },
                      );

                      if (isVacationCancel != null) {
                        _vacationsBloc.add(
                          GetVacationsEvent(
                            employeeId: widget.employeeId,
                          ),
                        );
                      }
                    },
                  );
                },
              ).toList();
              vacationDetails.addAll(vacationSchedule);
            }

            if (vacation.vacationReceipts != null && vacation.vacationReceipts!.isNotEmpty) {
              final vacationReceipts = vacation.vacationReceipts!.map(
                (vacationReceipt) {
                  return VacationReceiptCardWidget(
                    key: Key('vacations-open_periods_receipt-card-${listItemIndex++}'),
                    vacationReceiptEntity: vacationReceipt,
                    showActionIcon: true,
                    onTap: () {
                      Modular.to.pushNamed(
                        VacationsRoutes.requestVacationDetailsScreenInitialRoute,
                        arguments: {
                          'vacationDetails': vacationReceipt,
                          'employeeId': widget.employeeId,
                        },
                      );
                    },
                  );
                },
              ).toList();
              vacationDetails.addAll(vacationReceipts);
            }

            if (vacation.vacationRequestExpired != null && vacation.vacationRequestExpired!.isNotEmpty) {
              final vacationRequestExpired = vacation.vacationRequestExpired!.map(
                (vacationRequestExpired) {
                  return VacationScheduleCardWidget(
                    key: Key('vacations-open_periods_receipt-card-${listItemIndex++}'),
                    vacationScheduleEntity: vacationRequestExpired,
                    showActionIcon: true,
                    onTap: () {
                      Modular.to.pushNamed(
                        VacationsRoutes.requestVacationDetailsScreenInitialRoute,
                        arguments: {
                          'vacationDetails': vacationRequestExpired,
                          'employeeId': widget.employeeId,
                          'vacationPeriodId': widget.vacationPeriodId,
                        },
                      );
                    },
                  );
                },
              ).toList();
              vacationDetails.addAll(vacationRequestExpired);
            }

            return Scrollbar(
              child: ListView.separated(
                padding: EdgeInsets.only(
                  bottom: SeniorSpacing.normal + context.bottomSize,
                ),
                separatorBuilder: (_, __) => const SizedBox(
                  height: SeniorSpacing.normal,
                ),
                key: const Key('vacations-open_periods_details-list'),
                itemCount: vacationDetails.length,
                itemBuilder: (_, index) => vacationDetails[index],
              ),
            );
          },
        ),
      ),
    );
  }
}
