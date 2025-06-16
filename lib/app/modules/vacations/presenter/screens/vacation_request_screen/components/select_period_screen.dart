import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/tokens/senior_colors.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';
import 'package:senior_design_tokens/tokens/senior_typography.dart';

import '../../../../../../core/constants/assets_path.dart';
import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/helper/date_time_helper.dart';
import '../../../../../../core/helper/locale_helper.dart';
import '../../../../../../core/helper/string_helper.dart';
import '../../../../../../core/widgets/empty_state_widget.dart';
import '../../../../../../core/widgets/error_state_widget.dart';
import '../../../../../../core/widgets/waapi_card_widget.dart';
import '../../../../../../core/widgets/waapi_loading_widget.dart';
import '../../../../../../core/widgets/warning_widget.dart';
import '../../../../../authorization/presenter/blocs/authorization_bloc/authorization_bloc.dart';
import '../../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../../../domain/entities/vacations_entity.dart';
import '../../../../enums/vacation_period_situation_enum.dart';
import '../../../blocs/vacations_bloc/vacations_bloc.dart';
import '../../../blocs/vacations_bloc/vacations_event.dart';
import '../../../blocs/vacations_bloc/vacations_state.dart';
import '../bloc/vacation_request_screen_bloc.dart';

class SelectPeriodScreen extends StatefulWidget {
  final String? vacationPeriodId;
  final ValueChanged<VacationsEntity> onSelected;
  final bool isRequestVacationUpdate;

  const SelectPeriodScreen({
    Key? key,
    required this.vacationPeriodId,
    required this.onSelected,
    required this.isRequestVacationUpdate,
  }) : super(key: key);

  @override
  State<SelectPeriodScreen> createState() {
    return _SelectPeriodScreenState();
  }
}

class _SelectPeriodScreenState extends State<SelectPeriodScreen> {
  late final VacationRequestScreenBloc _vacationRequestScreenBloc;

  @override
  void initState() {
    super.initState();
    _vacationRequestScreenBloc = Modular.get<VacationRequestScreenBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VacationsBloc, VacationsState>(
      bloc: _vacationRequestScreenBloc.vacationsBloc,
      builder: (context, state) {
        final isLoading = (state is LoadingVacationsState && state.vacations == null);

        if (isLoading || state is InitialVacationsState) {
          return Center(
            child: Container(
              padding: const EdgeInsets.only(
                top: SeniorSpacing.normal,
              ),
              alignment: Alignment.topCenter,
              child: const WaapiLoadingWidget(
                key: Key('vacations-request_vacations-loading'),
              ),
            ),
          );
        }

        if (state is ErrorVacationsState) {
          return ErrorStateWidget(
            key: const Key('vacations-request_vacations-error_state'),
            title: context.translate.openPeriodsError,
            subTitle: context.translate.openPeriodsErrorDescription,
            imagePath: AssetsPath.vacationErrorState,
            onTapTryAgain: () => _vacationRequestScreenBloc.vacationsBloc.add(
              GetVacationsEvent(
                employeeId: state.employeeId,
              ),
            ),
          );
        }

        final openVacations = state.vacations!.where((vacation) {
          return vacation.vacationPeriodSituation == VacationPeriodSituationEnum.opened;
        }).toList();

        if (widget.isRequestVacationUpdate) {
          openVacations.removeWhere((item) => item.vacationPeriodId != widget.vacationPeriodId);
        }

        if (openVacations.isEmpty) {
          return EmptyStateWidget(
            title: context.translate.openPeriodsEmpty,
            subTitle: context.translate.openPeriodsEmptyDescription,
            imagePath: AssetsPath.vacationEmptyState,
          );
        }

        return ListView(
          padding: EdgeInsets.zero,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: SeniorSpacing.normal,
                left: SeniorSpacing.normal,
                right: SeniorSpacing.normal,
              ),
              child: SeniorText.h4(
                context.translate.vacationReceiptPeriod,
              ),
            ),
            BlocBuilder<AuthorizationBloc, AuthorizationState>(
              bloc: _vacationRequestScreenBloc.authorizationBloc,
              builder: (context, state) {
                final String? vacationPolicy =
                    state is LoadedAuthorizationState ? state.authorizationEntity.vacationHelpDescription : null;

                if (vacationPolicy == null || vacationPolicy.isEmpty) {
                  return const SizedBox.shrink();
                }

                return WarningWidget(
                  message: vacationPolicy,
                );
              },
            ),
            widget.isRequestVacationUpdate
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.only(
                      left: SeniorSpacing.normal,
                      right: SeniorSpacing.normal,
                    ),
                    child: SeniorText.label(
                      context.translate.selectPeriod,
                    ),
                  ),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(
                top: SeniorSpacing.normal,
              ),
              shrinkWrap: true,
              itemCount: openVacations.length,
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: SeniorSpacing.xsmall,
                );
              },
              itemBuilder: (context, index) {
                return WaapiCardWidget(
                  key: const Key('vacations-vacation_request_screen-list-card-0'),
                  showActionIcon: false,
                  showRadioButton: true,
                  leftBorder: widget.vacationPeriodId == openVacations[index].vacationPeriodId,
                  selectedRadioButton: widget.vacationPeriodId == openVacations[index].vacationPeriodId,
                  margin: const EdgeInsets.symmetric(
                    horizontal: SeniorSpacing.normal,
                  ),
                  onTap: () {
                    widget.onSelected(openVacations[index]);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: SeniorSpacing.xxsmall,
                        ),
                        child: SeniorText.labelBold(
                          context.translate.rangeDate(
                            DateTimeHelper.formatWithDefaultDatePattern(
                              dateTime: openVacations[index].startDate!,
                              locale: LocaleHelper.languageAndCountryCode(
                                locale: Localizations.localeOf(context),
                              ),
                            ),
                            DateTimeHelper.formatWithDefaultDatePattern(
                              dateTime: openVacations[index].endDate!,
                              locale: LocaleHelper.languageAndCountryCode(
                                locale: Localizations.localeOf(context),
                              ),
                            ),
                          ),
                          color: SeniorColors.neutralColor900,
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '${context.translate.balanceDescription}: ',
                              style: SeniorTypography.body(
                                color: Provider.of<ThemeRepository>(context).isDarkTheme()
                                    ? SeniorColors.pureWhite
                                    : SeniorColors.neutralColor600,
                              ),
                            ),
                            TextSpan(
                              text: '${StringHelper.doubleToStringFormatter(
                                value: openVacations[index].vacationBalance!,
                              )} ',
                              style: SeniorTypography.body(
                                color: Provider.of<ThemeRepository>(context).isDarkTheme()
                                    ? SeniorColors.pureWhite
                                    : SeniorColors.neutralColor900,
                              ),
                            ),
                            TextSpan(
                              text: openVacations[index].vacationBalance! <= 1
                                  ? context.translate.day
                                  : context.translate.days,
                              style: SeniorTypography.body(
                                color: Provider.of<ThemeRepository>(context).isDarkTheme()
                                    ? SeniorColors.pureWhite
                                    : SeniorColors.neutralColor600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(
              height: SeniorSpacing.xsmall,
            ),
          ],
        );
      },
    );
  }
}
