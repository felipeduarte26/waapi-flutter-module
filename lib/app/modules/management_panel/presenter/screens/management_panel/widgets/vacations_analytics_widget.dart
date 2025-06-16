import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/enums/analytics/analytics_event_enum.dart';
import '../../../../../../core/enums/analytics/waapi_loading_size_enum.dart';
import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/helper/snackbar_helper.dart';
import '../../../../../../core/theme/waapi_style_theme.dart';
import '../../../../../../core/widgets/icon_header_widget.dart';
import '../../../../../../core/widgets/information_widget.dart';
import '../../../../../../core/widgets/state_card_widget.dart';
import '../../../../../../core/widgets/waapi_bottomsheet.dart';
import '../../../../../../core/widgets/waapi_loading_widget.dart';
import '../../../../../../routes/vacations_routes.dart';
import '../../../../../authorization/presenter/blocs/authorization_bloc/authorization_bloc.dart';
import '../../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../../../../vacations/presenter/blocs/vacation_analytics/vacations_analytics_bloc.dart';
import '../../../../../vacations/presenter/blocs/vacation_analytics/vacations_analytics_event.dart';
import '../../../../../vacations/presenter/blocs/vacation_analytics/vacations_analytics_state.dart';
import '../../../../../vacations/presenter/widgets/vacations_analytics_card_widget.dart';

class VacationsAnalyticsWidget extends StatefulWidget {
  final String employeeId;
  final AuthorizationBloc authorizationBloc;
  final bool disabled;

  const VacationsAnalyticsWidget({
    Key? key,
    required this.employeeId,
    required this.authorizationBloc,
    required this.disabled,
  }) : super(key: key);

  @override
  State<VacationsAnalyticsWidget> createState() {
    return _VacationAnalyticsWidgetState();
  }
}

class _VacationAnalyticsWidgetState extends State<VacationsAnalyticsWidget> {
  late VacationsAnalyticsBloc _vacationsAnalyticsBloc;

  @override
  void initState() {
    super.initState();
    _vacationsAnalyticsBloc = Modular.get<VacationsAnalyticsBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(
            bottom: SeniorSpacing.normal,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: IconHeaderWidget(
                  key: const Key('management-Panel_screen-description_vacations_analytics'),
                  title: context.translate.vacationsAnalyticsHeader,
                  icon: FontAwesomeIcons.solidPlane,
                  removeBottomPadding: true,
                ),
              ),
            ],
          ),
        ),
        BlocBuilder<VacationsAnalyticsBloc, VacationsAnalyticsState>(
          bloc: _vacationsAnalyticsBloc,
          builder: (context, state) {
            if (state is ErrorVacationsAnalyticsState) {
              return StateCardWidget(
                key: const Key('vacation-analytics-error-state-card'),
                textButton: context.translate.tryAgain,
                message: context.translate.vacationsAnalyticsErrorState,
                onTap: () => _vacationsAnalyticsBloc.add(
                  GetVacationsAnalyticsEvent(
                    employeeId: state.employeeId,
                  ),
                ),
                showButton: true,
                iconData: FontAwesomeIcons.solidTriangleExclamation,
                disabled: widget.disabled,
              );
            }
            if (state is LoadingVacationsAnalyticsState) {
              return const Padding(
                padding: EdgeInsets.only(
                  bottom: SeniorSpacing.normal,
                ),
                child: Center(
                  child: WaapiLoadingWidget(
                    waapiLoadingSizeEnum: WaapiLoadingSizeEnum.small,
                    key: Key('vacation-analytics-loading_state'),
                  ),
                ),
              );
            }
            if (state is LoadedVacationsAnalyticsState) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SeniorSpacing.normal,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: VacationsAnalyticsCardWidget(
                            days: state.vacationsAnalyticsEntity.balance,
                            icon: FontAwesomeIcons.solidCalendarCheck,
                            title: context.translate.vacationsAnalyticsBalance,
                            disabled: widget.disabled,
                            onTap: () {
                              WaapiBottomsheet.showDynamicBottomSheet(
                                context: context,
                                content: [
                                  InformationWidget(
                                    title: context.translate.vacationsAnalyticsBalance,
                                    icon: FontAwesomeIcons.solidCalendarCheck,
                                    description: SeniorText.body(context.translate.messageInformationBalanceVacation),
                                    onTapThumbsUp: onTapInformationVacation(
                                      usefulVacationInformation: AnalyticsEventEnum.usefulBalanceVacationInformation,
                                    ),
                                    onTapThumbsDown: onTapInformationVacation(
                                      usefulVacationInformation: AnalyticsEventEnum.nonUsefulBalanceVacationInformation,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          width: SeniorSpacing.normal,
                        ),
                        Expanded(
                          child: VacationsAnalyticsCardWidget(
                            days: state.vacationsAnalyticsEntity.proportional,
                            icon: FontAwesomeIcons.solidCalendarDays,
                            title: context.translate.vacationsAnalyticsProportional,
                            disabled: widget.disabled,
                            onTap: () {
                              WaapiBottomsheet.showDynamicBottomSheet(
                                context: context,
                                content: [
                                  InformationWidget(
                                    title: context.translate.vacationsAnalyticsProportional,
                                    icon: FontAwesomeIcons.solidCalendarDays,
                                    description:
                                        SeniorText.body(context.translate.messageInformationProportionalVacation),
                                    onTapThumbsUp: onTapInformationVacation(
                                      usefulVacationInformation:
                                          AnalyticsEventEnum.usefulProportionalVacationInformation,
                                    ),
                                    onTapThumbsDown: onTapInformationVacation(
                                      usefulVacationInformation:
                                          AnalyticsEventEnum.nonUsefulProportionalVacationInformation,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: SeniorSpacing.xsmall,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: VacationsAnalyticsCardWidget(
                            days: state.vacationsAnalyticsEntity.pastDueBalance,
                            icon: FontAwesomeIcons.solidCalendarMinus,
                            title: context.translate.vacationsAnalyticspastDueBalance,
                            disabled: widget.disabled,
                            onTap: () {
                              WaapiBottomsheet.showDynamicBottomSheet(
                                context: context,
                                content: [
                                  InformationWidget(
                                    title: context.translate.vacationsAnalyticspastDueBalance,
                                    icon: FontAwesomeIcons.solidCalendarMinus,
                                    description:
                                        SeniorText.body(context.translate.messageInformationPastDueBalanceVacation),
                                    onTapThumbsUp: onTapInformationVacation(
                                      usefulVacationInformation: AnalyticsEventEnum.usefulDueBalanceVacationInformation,
                                    ),
                                    onTapThumbsDown: onTapInformationVacation(
                                      usefulVacationInformation:
                                          AnalyticsEventEnum.nonUsefulDueBalanceVacationInformation,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          width: SeniorSpacing.normal,
                        ),
                        Expanded(
                          child: VacationsAnalyticsCardWidget(
                            days: state.vacationsAnalyticsEntity.doubled,
                            icon: FontAwesomeIcons.solidCalendar,
                            title: context.translate.vacationsAnalyticspastDoubled,
                            disabled: widget.disabled,
                            onTap: () {
                              WaapiBottomsheet.showDynamicBottomSheet(
                                context: context,
                                content: [
                                  InformationWidget(
                                    title: context.translate.vacationsAnalyticspastDoubled,
                                    icon: FontAwesomeIcons.solidCalendar,
                                    description: SeniorText.body(context.translate.messageInformationDoubledVacation),
                                    onTapThumbsUp: onTapInformationVacation(
                                      usefulVacationInformation: AnalyticsEventEnum.usefulDoubledVacationInformation,
                                    ),
                                    onTapThumbsDown: onTapInformationVacation(
                                      usefulVacationInformation: AnalyticsEventEnum.nonUsefulDoubledVacationInformation,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: SeniorSpacing.normal,
                    ),
                    BlocBuilder<AuthorizationBloc, AuthorizationState>(
                      bloc: widget.authorizationBloc,
                      builder: (context, state) {
                        final canRequestVacation =
                            state is LoadedAuthorizationState && state.authorizationEntity.allowEmployeeRequestVacation;

                        final allowToViewVacations =
                            state is LoadedAuthorizationState && state.authorizationEntity.allowToViewVacations;

                        if (!canRequestVacation || !allowToViewVacations) {
                          return const SizedBox.shrink();
                        }

                        return Center(
                          child: SeniorButton(
                            fullWidth: true,
                            icon: FontAwesomeIcons.solidPaperPlane,
                            label: context.translate.requestVacation,
                            outlined: true,
                            style: WaapiStyleTheme.waapiSeniorButtonGhostOutlinedStyle(context),
                            onPressed: () async {
                              if (widget.disabled) {
                                SnackbarHelper.showSnackbar(
                                  context: context,
                                  message: context.translate.featureIsNotAvailableOffline,
                                );
                              } else {
                                await Modular.to.pushNamed(
                                  VacationsRoutes.requestVacationScreenInitialRoute,
                                  arguments: {
                                    'employeeId': widget.employeeId,
                                  },
                                );
                              }
                            },
                            disabled: widget.disabled,
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: SeniorSpacing.medium,
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  VoidCallback onTapInformationVacation({required AnalyticsEventEnum usefulVacationInformation}) {
    return () {
      Modular.to.pop();
      WaapiBottomsheet.showDynamicBottomSheet(
        context: context,
        content: [
          const InformationWidget(
            isThank: true,
          ),
        ],
      );
    };
  }
}
