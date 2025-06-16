import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../core/extension/media_query_extension.dart';
import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/widgets/employee_bottom_sheet_widget.dart';
import '../../../../../core/widgets/waapi_colorful_header.dart';
import '../../../../../routes/routes.dart';
import '../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../blocs/vacations_bloc/vacations_event.dart';
import '../../blocs/vacations_bloc/vacations_state.dart';
import '../vacation_calendar_staff_view_screen/vacation_calendar_staff_view_screen.dart';
import 'bloc/vacations_screen_bloc.dart';
import 'bloc/vacations_screen_state.dart';
import 'widgets/open_periods_details_widget.dart';
import 'widgets/paid_periods_details_widget.dart';
import 'widgets/vacation_information_status.dart';

class VacationsScreen extends StatefulWidget {
  final String employeeId;

  const VacationsScreen({
    Key? key,
    required this.employeeId,
  }) : super(key: key);

  @override
  State<VacationsScreen> createState() {
    return _VacationsScreenState();
  }
}

class _VacationsScreenState extends State<VacationsScreen> with SingleTickerProviderStateMixin {
  late VacationsScreenBloc _vacationsScreenBloc;
  bool openPeriodsSelected = true;
  bool paidPeriodsSelected = false;
  bool calendarSelected = false;
  int tabIndex = 0;

  PageController pageController = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();
    _vacationsScreenBloc = Modular.get<VacationsScreenBloc>();

    _vacationsScreenBloc.vacationsBloc.add(
      GetVacationsEvent(
        employeeId: widget.employeeId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);
    return Scaffold(
      body: BlocConsumer<VacationsScreenBloc, VacationsScreenState>(
        bloc: _vacationsScreenBloc,
        listener: (context, state) {
          final authorizationState = state.authorizationState;

          final allowToViewVacations = authorizationState is LoadedAuthorizationState &&
              authorizationState.authorizationEntity.allowToViewVacations;

          if (!allowToViewVacations) {
            calendarSelected = true;
            openPeriodsSelected = false;
            paidPeriodsSelected = false;
          }
        },
        builder: (context, state) {
          final authorizationState = state.authorizationState;

          final canRequestVacations = authorizationState is LoadedAuthorizationState &&
              authorizationState.authorizationEntity.allowEmployeeRequestVacation;

          final allowToViewCalendarVacations = authorizationState is LoadedAuthorizationState &&
              authorizationState.authorizationEntity.allowToViewCalendarVacations;

          final allowToViewVacations = authorizationState is LoadedAuthorizationState &&
              authorizationState.authorizationEntity.allowToViewVacations;

          final List<String> tabs = [];
          if (allowToViewVacations) {
            tabs.add(context.translate.open);
            tabs.add(context.translate.paid);
          }

          if (allowToViewCalendarVacations) {
            tabs.add(context.translate.calendar);
          }

          return WaapiColorfulHeader(
            titleLabel: context.translate.vacations,
            actions: [
              if (allowToViewCalendarVacations && calendarSelected)
                IconButton(
                  icon: SeniorIcon(
                    icon: FontAwesomeIcons.solidCircleInfo,
                    size: SeniorSpacing.normal,
                    style: SeniorIconStyle(
                      color: themeRepository.isCustomTheme()
                          ? SeniorServiceColor.getOptimalContrastColorTheme(
                              color: themeRepository.theme.secondaryColor!,
                            )
                          : SeniorColors.pureWhite,
                    ),
                  ),
                  color: SeniorColors.pureWhite,
                  onPressed: () {
                    _viewInformation(context);
                  },
                ),
            ],
            tabBarConfig: _tabBarConfig(
              tabs: tabs,
            ),
            body: Column(
              children: [
                Expanded(
                  child: BlocListener<VacationsScreenBloc, VacationsScreenState>(
                    bloc: _vacationsScreenBloc,
                    listener: (context, state) {
                      if (state.vacationsState is ErrorUpdatingVacationsState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SeniorSnackBar.error(
                            message: context.translate.errorUpdatingVacations,
                            action: SeniorSnackBarAction(
                              label: context.translate.repeat,
                              onPressed: () => _vacationsScreenBloc.vacationsBloc.add(
                                GetVacationsEvent(
                                  employeeId: widget.employeeId,
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    },
                    child: PageView(
                      controller: pageController,
                      children: [
                        if (allowToViewVacations)
                          OpenPeriodsDetailsWidget(
                            employeeId: widget.employeeId,
                          ),
                        if (allowToViewVacations) const PaidPeriodsDetailsWidget(),
                        if (allowToViewCalendarVacations)
                          VacationCalendarStaffViewScreen(
                            employeeId: widget.employeeId,
                          ),
                      ],
                      onPageChanged: (value) => setState(() {
                        tabIndex = value;
                      }),
                    ),
                  ),
                ),
                canRequestVacations &&
                        state.vacationsState is LoadedVacationsState &&
                        pageController.page == 0 &&
                        allowToViewVacations
                    ? EmployeeBottomSheetWidget(
                        horizontalPadding: true,
                        key: const Key('vacations-vacations_screen-employee_bottom_sheet'),
                        seniorButtons: [
                          Offstage(
                            offstage: (!canRequestVacations || state.vacationsState.vacations!.isEmpty),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                bottom: SeniorSpacing.normal,
                              ),
                              child: SeniorButton(
                                key: const Key('vacations-vacations_screen-request_vacation_button'),
                                fullWidth: true,
                                label: context.translate.requestVacation,
                                onPressed: () async {
                                  final isRequested = await Modular.to.pushNamed(
                                    VacationsRoutes.requestVacationScreenInitialRoute,
                                    arguments: {
                                      'employeeId': widget.employeeId,
                                    },
                                  );

                                  if (isRequested != null) {
                                    _vacationsScreenBloc.vacationsBloc.add(
                                      GetVacationsEvent(
                                        employeeId: widget.employeeId,
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          );
        },
      ),
    );
  }

  void _viewInformation(BuildContext context) {
    SeniorBottomSheet.showBottomSheet(
      context: context,
      height: context.bottomSheetSize,
      content: [
        const Expanded(
          child: VacationInformationStatus(),
        ),
      ],
      hasCloseButton: true,
      onTapCloseButton: () {
        Modular.to.pop();
      },
    );
  }

  dynamic _onSelect(int newValue) {
    if (newValue == 0) {
      setState(() {
        openPeriodsSelected = true;
        paidPeriodsSelected = false;
        calendarSelected = false;
        pageController.jumpToPage(0);
      });
    }

    if (newValue == 1) {
      setState(() {
        openPeriodsSelected = false;
        paidPeriodsSelected = true;
        calendarSelected = false;
        pageController.jumpToPage(1);
      });
    }

    if (newValue == 2) {
      setState(() {
        openPeriodsSelected = false;
        paidPeriodsSelected = false;
        calendarSelected = true;
        pageController.jumpToPage(2);
      });
    }
    tabIndex = newValue;
  }

  TabBarConfig _tabBarConfig({
    required List<String> tabs,
  }) {
    return TabBarConfig(
      tabs: tabs,
      onSelect: _onSelect,
      tabIndex: tabIndex,
    );
  }
}
