import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/constants/assets_path.dart';
import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/helper/date_time_helper.dart';
import '../../../../../../core/helper/locale_helper.dart';
import '../../../../../../core/helper/string_helper.dart';
import '../../../../../../core/widgets/empty_state_widget.dart';
import '../../../../../../core/widgets/error_state_widget.dart';
import '../../../../../../core/widgets/waapi_card_widget.dart';
import '../../../../../../core/widgets/waapi_loading_widget.dart';
import '../../../../../../routes/routes.dart';
import '../../../../enums/vacation_document_status_enum.dart';
import '../../../../enums/vacation_period_situation_enum.dart';
import '../../../blocs/vacations_bloc/vacations_event.dart';
import '../../../blocs/vacations_bloc/vacations_state.dart';
import '../bloc/vacations_screen_bloc.dart';
import '../bloc/vacations_screen_state.dart';

class OpenPeriodsDetailsWidget extends StatefulWidget {
  final String employeeId;

  const OpenPeriodsDetailsWidget({
    required this.employeeId,
    Key? key,
  }) : super(key: key);

  @override
  State<OpenPeriodsDetailsWidget> createState() {
    return _OpenPeriodsDetailsWidgetState();
  }
}

class _OpenPeriodsDetailsWidgetState extends State<OpenPeriodsDetailsWidget> {
  late final VacationsScreenBloc _vacationsScreenBloc;

  @override
  void initState() {
    super.initState();
    _vacationsScreenBloc = Modular.get<VacationsScreenBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VacationsScreenBloc, VacationsScreenState>(
      bloc: _vacationsScreenBloc,
      builder: (context, state) {
        final vacationsState = state.vacationsState;

        final isLoading = (vacationsState is LoadingVacationsState);

        if (isLoading || vacationsState is InitialVacationsState) {
          return Container(
            padding: const EdgeInsets.only(
              top: SeniorSpacing.normal,
            ),
            alignment: Alignment.topCenter,
            child: const WaapiLoadingWidget(
              key: Key('vacations-open_periods_details-loading_indicator'),
            ),
          );
        }

        if (vacationsState is ErrorVacationsState) {
          return ErrorStateWidget(
            key: const Key('vacations-open_periods_details-error_state'),
            title: context.translate.openPeriodsError,
            subTitle: context.translate.openPeriodsErrorDescription,
            imagePath: AssetsPath.vacationErrorState,
            onTapTryAgain: () => _vacationsScreenBloc.vacationsBloc.add(
              GetVacationsEvent(
                employeeId: vacationsState.employeeId,
              ),
            ),
          );
        }

        final openVacations = vacationsState.vacations!.where((vacation) {
          return vacation.vacationPeriodSituation == VacationPeriodSituationEnum.opened;
        }).toList();

        if (openVacations.isEmpty) {
          return EmptyStateWidget(
            title: context.translate.openPeriodsEmpty,
            subTitle: context.translate.openPeriodsEmptyDescription,
            imagePath: AssetsPath.vacationEmptyState,
          );
        }

        return Scrollbar(
          child: ListView.separated(
            key: const Key('vacations-open_periods_details-list'),
            padding: const EdgeInsets.all(SeniorSpacing.normal),
            itemCount: openVacations.length,
            separatorBuilder: (_, __) => const SizedBox(
              height: SeniorSpacing.normal,
            ),
            itemBuilder: (_, index) {
              final vacation = openVacations[index];
              final hasAction = vacation.vacationReceipts != null ||
                  vacation.vacationSchedule != null ||
                  vacation.vacationWaitingApproval != null ||
                  vacation.vacationUnderAnalysis != null ||
                  vacation.vacationRequestExpired != null;

              var vacationDays = 0.0;
              var vacationBonusDays = 0.0;

              var hasSignature = false;

              if (vacation.vacationReceipts != null) {
                for (final receipt in vacation.vacationReceipts!) {
                  vacationDays += receipt.vacationDays ?? 0;
                  vacationBonusDays += receipt.vacationBonusDays ?? 0;
                  if ((receipt.vacationNoticeSignatureData != null &&
                          receipt.vacationNoticeSignatureData!.status == VacationDocumentStatusEnum.inSignature) ||
                      (receipt.vacationReceiptSignatureData != null &&
                          receipt.vacationReceiptSignatureData!.status == VacationDocumentStatusEnum.inSignature)) {
                    hasSignature = true;
                  }
                }
              }

              if (vacation.vacationSchedule != null) {
                for (final schedule in vacation.vacationSchedule!) {
                  if ((schedule.vacationNoticeSignatureData != null &&
                          schedule.vacationNoticeSignatureData!.status == VacationDocumentStatusEnum.inSignature) ||
                      (schedule.vacationReceiptSignatureData != null &&
                          schedule.vacationReceiptSignatureData!.status == VacationDocumentStatusEnum.inSignature)) {
                    hasSignature = true;
                  }
                }
              }

              return Column(
                children: [
                  if (vacationsState is LoadedVacationsState)
                    if (index == 0)
                      _titleGroup(
                        title: context.translate.periodsCurrent,
                      ),
                  if (vacationsState is LoadedVacationsState)
                    if (index == 1)
                      _titleGroup(
                        title: context.translate.periodsFuture,
                      ),
                  if (vacationsState is LoadedVacationsState)
                    WaapiCardWidget(
                      key: Key('vacations-open_periods_details-list-card-$index'),
                      showActionIcon: hasAction,
                      onTap: hasAction
                          ? () => _goToOpenPeriodDetailsScreen(
                                vacationPeriodId: vacation.vacationPeriodId,
                                employeeId: vacationsState.employeeId,
                              )
                          : null,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SeniorText.labelBold(
                            context.translate.rangeDate(
                              DateTimeHelper.formatWithDefaultDatePattern(
                                dateTime: vacation.startDate!,
                                locale: LocaleHelper.languageAndCountryCode(
                                  locale: Localizations.localeOf(context),
                                ),
                              ),
                              DateTimeHelper.formatWithDefaultDatePattern(
                                dateTime: vacation.endDate!,
                                locale: LocaleHelper.languageAndCountryCode(
                                  locale: Localizations.localeOf(context),
                                ),
                              ),
                            ),
                            color: index == 0 ? SeniorColors.neutralColor800 : SeniorColors.neutralColor900,
                          ),
                          if (vacation.vacationBalance != null || vacationDays + vacationBonusDays > 0)
                            const SizedBox(
                              height: SeniorSpacing.xsmall,
                            ),
                          if (vacation.vacationBalance != null)
                            vacation.vacationBalance == 0
                                ? SeniorText.body(
                                    context.translate.balanceVacationNone,
                                    color: index == 0 ? SeniorColors.neutralColor800 : SeniorColors.neutralColor900,
                                  )
                                : RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '${context.translate.balanceDescription}: ',
                                          style: SeniorTypography.body(
                                            color: _getTextSpanColor(
                                              context: context,
                                              index: index,
                                            ),
                                          ),
                                        ),
                                        TextSpan(
                                          text: '${StringHelper.doubleToStringFormatter(
                                            value: vacation.vacationBalance!,
                                          )} ',
                                          style: SeniorTypography.body(
                                            color: _getTextSpanColor(
                                              context: context,
                                              index: index,
                                            ),
                                          ),
                                        ),
                                        TextSpan(
                                          text: vacation.vacationBalance! <= 1
                                              ? context.translate.day
                                              : context.translate.days,
                                          style: SeniorTypography.body(
                                            color: _getTextSpanColor(
                                              context: context,
                                              index: index,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          if (vacation.vacationReturnedToAdjustments != null &&
                              vacation.vacationReturnedToAdjustments!.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(
                                top: SeniorSpacing.xxsmall,
                              ),
                              child: Row(
                                children: [
                                  const SeniorIcon(
                                    icon: FontAwesomeIcons.solidTriangleExclamation,
                                    style: SeniorIconStyle(
                                      color: SeniorColors.manchesterColorOrange500,
                                    ),
                                    size: SeniorSpacing.small,
                                  ),
                                  const SizedBox(
                                    width: SeniorSpacing.xxsmall,
                                  ),
                                  Expanded(
                                    child: SeniorText.small(
                                      context.translate.adjustmentPeriod,
                                      color: SeniorColors.secondaryColor700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (hasSignature)
                            Padding(
                              padding: const EdgeInsets.only(
                                top: SeniorSpacing.xxsmall,
                              ),
                              child: Row(
                                children: [
                                  const SeniorIcon(
                                    icon: FontAwesomeIcons.solidTriangleExclamation,
                                    style: SeniorIconStyle(
                                      color: SeniorColors.manchesterColorOrange500,
                                    ),
                                    size: SeniorIconSize.small,
                                  ),
                                  Expanded(
                                    child: SeniorText.smallBold(
                                      ' ${context.translate.pedingDocumentsSignature}',
                                      color: SeniorColors.grayscale70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

Color? _getTextSpanColor({
  required int index,
  required BuildContext context,
}) {
  if (Provider.of<ThemeRepository>(context).isDarkTheme()) {
    return Provider.of<ThemeRepository>(context).theme.textTheme!.bodyStyle!.color;
  }
  if (index == 0) {
    return SeniorColors.neutralColor800;
  }
  return SeniorColors.neutralColor900;
}

void _goToOpenPeriodDetailsScreen({
  required String vacationPeriodId,
  required String employeeId,
}) {
  Modular.to.pushNamed(
    VacationsRoutes.openedPeriodDetailsScreenInitialRoute,
    arguments: {
      'vacationPeriodId': vacationPeriodId,
      'employeeId': employeeId,
    },
  );
}

Widget _titleGroup({
  required String title,
}) {
  return Padding(
    padding: const EdgeInsets.only(
      bottom: SeniorSpacing.normal,
    ),
    child: Align(
      alignment: Alignment.topLeft,
      child: SeniorText.label(
        title,
        color: SeniorColors.secondaryColor900,
      ),
    ),
  );
}
