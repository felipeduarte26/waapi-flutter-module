import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../../../core/extension/media_query_extension.dart';
import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/helper/locale_helper.dart';
import '../../../../../core/pagination/pagination_requirements.dart';
import '../../../../../core/services/has_clocking/presenter/bloc/has_clocking_state.dart';
import '../../../../../core/services/has_clocking_configuration/external/drivers/get_clocking_configuration_driver_impl.dart';
import '../../../../../core/services/has_clocking_configuration/external/get_clocking_configuration.dart';
import '../../../../../core/services/internal_storage/internal_storage_service.dart';
import '../../../../../core/services/rest_client/rest_service.dart';
import '../../../../../core/widgets/waapi_colorful_header.dart';
import '../../../../../core/widgets/waapi_loading_widget.dart';
import '../../../../active_contract/presenter/blocs/active_contract_bloc/active_contract_state.dart';
import '../../../../authentication/presenter/blocs/sign_out/sign_out_state.dart';
import '../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../../../corporate_mural/presenter/blocs/birthday_employees/birthday_employees_bloc.dart';
import '../../../../corporate_mural/presenter/blocs/birthday_employees/birthday_employees_event.dart';
import '../../../../corporate_mural/presenter/blocs/company_birthdays/company_birthdays_bloc.dart';
import '../../../../corporate_mural/presenter/blocs/company_birthdays/company_birthdays_event.dart';
import '../../../../corporate_mural/presenter/widgets/next_birthday_employees_widget.dart';
import '../../../../corporate_mural/presenter/widgets/next_company_birthdays_widget.dart';
import '../../../../happiness_index/presenter/blocs/happiness_index/happiness_index_bloc.dart';
import '../../../../happiness_index/presenter/blocs/happiness_index/happiness_index_event.dart';
import '../../../../happiness_index/presenter/blocs/happiness_index/happiness_index_state.dart';
import '../../../../home/presenter/bloc/connectivity_bloc/connectivity_state.dart';
import '../../../../moods/presenter/blocs/moods_bloc/moods_event.dart';
import '../../../../moods/presenter/blocs/moods_bloc/moods_state.dart';
import '../../../../profile/presenter/blocs/contract_employee_bloc/contract_employee_bloc.dart';
import '../../../../profile/presenter/blocs/contract_employee_bloc/contract_employee_event.dart';
import '../../../../profile/presenter/blocs/contract_employee_bloc/contract_employee_state.dart';
import '../../../../profile/presenter/blocs/person_bloc/person_bloc.dart';
import '../../../../profile/presenter/blocs/person_bloc/person_event.dart';
import '../../../../profile/presenter/blocs/person_bloc/person_state.dart';
import '../../../../profile/presenter/blocs/profile_bloc/profile_bloc.dart';
import '../../../../profile/presenter/blocs/profile_bloc/profile_event.dart';
import '../../../../profile/presenter/blocs/profile_bloc/profile_state.dart';
import '../../../../profile/presenter/blocs/user_role/user_role_bloc.dart';
import '../../../../profile/presenter/blocs/user_role/user_role_event.dart';
import '../../../../profile/presenter/blocs/user_role/user_role_state.dart';
import '../../../../profile/presenter/screens/profile_menu_screen/profile_menu_screen.dart';
import '../../../../vacations/presenter/blocs/vacation_analytics/vacations_analytics_bloc.dart';
import '../../../../vacations/presenter/blocs/vacation_analytics/vacations_analytics_event.dart';
import '../../../helpers/name_user_helper.dart';
import 'blocs/management_panel_feedback/management_panel_feedback_event.dart';
import 'blocs/management_panel_feedback/management_panel_feedback_state.dart';
import 'blocs/management_panel_screen/management_panel_screen_bloc.dart';
import 'blocs/management_panel_screen/management_panel_screen_state.dart';
import 'widgets/happiness_index/happiness_index_board_widget.dart';
import 'widgets/management_panel_actions_senior_colorful_header_structure_widget.dart';
import 'widgets/my_shortcuts_widget.dart';
import 'widgets/not_allow_to_view_my_feedbacks_widget.dart';
import 'widgets/offline_widget.dart';
import 'widgets/recent_feedback_widget.dart';
import 'widgets/vacations_analytics_widget.dart';
import 'widgets/waapi_clocking_event_widget.dart';
import 'widgets/waapi_lite_information_widget.dart';
import 'widgets/welcome_widget.dart';


class ManagementPanelScreen extends StatefulWidget {
  final ManagementPanelScreenBloc managementPanelScreenBloc;
  final Future<void> dataClockingFutureToBuild;
  final bool clockingIsActive;
  final bool Function({required bool clockingIsActive}) clockingIsActiveCall;
  final bool hasPermission;
  final bool isWaapiLiteProfile;

  const ManagementPanelScreen({
    Key? key,
    required this.managementPanelScreenBloc,
    required this.clockingIsActiveCall,
    required this.clockingIsActive,
    required this.hasPermission,
    required this.isWaapiLiteProfile,
    required this.dataClockingFutureToBuild,
  }) : super(key: key);

  @override
  State<ManagementPanelScreen> createState() {
    return _ManagementPanelScreenState();
  }
}

class _ManagementPanelScreenState extends State<ManagementPanelScreen> with WidgetsBindingObserver {
  late final BirthdayEmployeesBloc _birthdayEmployeesBloc;
  late final CompanyBirthdaysBloc _companyBirthdaysBloc;
  late final HappinessIndexBloc _happinessIndexBloc;
  late final VacationsAnalyticsBloc _vacationsAnalyticsBloc;
  late final InternalStorageService _internalStorageService;
  late final RestService _restService;

  late ManagementPanelScreenBloc _managementPanelScreenBloc;

  var _isAllowedToViewMyFeedbacks = false;
  bool allowGpoOnApp = false;

  late bool clockingIsActive;
  bool isWaitingEmployeeContract = true;
  User? _user;
  String? userName;

  @override
  void initState() {
    super.initState();

    _birthdayEmployeesBloc = Modular.get<BirthdayEmployeesBloc>();
    _companyBirthdaysBloc = Modular.get<CompanyBirthdaysBloc>();
    _happinessIndexBloc = Modular.get<HappinessIndexBloc>();
    _vacationsAnalyticsBloc = Modular.get<VacationsAnalyticsBloc>();
    _managementPanelScreenBloc = widget.managementPanelScreenBloc;
    _internalStorageService = Modular.get<InternalStorageService>();
    _restService = Modular.get<RestService>();
    clockingIsActive = widget.clockingIsActive;
    WidgetsBinding.instance.addObserver(this);

    getPermissionGpoOnApp();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ManagementPanelScreenBloc, ManagementPanelScreenState>(
          bloc: _managementPanelScreenBloc,
          listener: (_, state) {
            final authenticationState = state.authenticationState;

            if (authenticationState.status == AuthenticationStatus.authenticated) {
              _getUser().then((user) => _user = user);
            }

            final activeContractState = state.activeContractState;

            if (activeContractState is LoadedActiveContractState &&
                state.managementPanelFeedbackState is InitialManagementPanelLatestFeedbacksState) {
              var authorizationState = (state.authorizationState as LoadedAuthorizationState);

              _managementPanelScreenBloc.moodsBloc.add(
                GetMoodsEvent(
                  userId: activeContractState.activeContractEntity.employeeId,
                ),
              );

              _isAllowedToViewMyFeedbacks = authorizationState.authorizationEntity.allowToViewMyFeedbacks;

              _managementPanelScreenBloc.managementPanelFeedbackBloc.add(
                GetLatestFeedbacksEvent(
                  isAllowToViewMyFeedbacks: _isAllowedToViewMyFeedbacks,
                ),
              );

              _managementPanelScreenBloc.personBloc.add(
                GetPersonIdEvent(
                  employeeId: activeContractState.activeContractEntity.employeeId,
                ),
              );

              if (authorizationState.authorizationEntity.allowToViewVacationAnalytics) {
                _vacationsAnalyticsBloc.add(
                  GetVacationsAnalyticsEvent(
                    employeeId: activeContractState.activeContractEntity.employeeId,
                  ),
                );
              }

              if (_managementPanelScreenBloc.userRoleBloc.state is LoadedUserRoleState) {
                if (authorizationState.authorizationEntity.allowToViewBirthdayCorporateMural) {
                  _birthdayEmployeesBloc.add(
                    GetNext15DaysBirthdayEmployeesEvent(
                      paginationRequirements: const PaginationRequirements(
                        page: 1,
                      ),
                      currentDate: DateTime.now(),
                      employeeId: activeContractState.activeContractEntity.employeeId,
                    ),
                  );
                }

                if (authorizationState.authorizationEntity.allowToViewCompanyBirthdayCorporateMural) {
                  _companyBirthdaysBloc.add(
                    GetNext15DaysBirthdaysCompanyEvent(
                      paginationRequirements: const PaginationRequirements(
                        page: 1,
                      ),
                      currentDate: DateTime.now(),
                      employeeId: activeContractState.activeContractEntity.employeeId,
                    ),
                  );
                }
              }
              _updateHappinessIndexModule();
            }
          },
        ),
        BlocListener<PersonBloc, PersonState>(
          bloc: _managementPanelScreenBloc.personBloc,
          listener: (context, state) {
            if (state is LoadedPersonState) {
              final activeContractState = _managementPanelScreenBloc.activeContractBloc.state;
              if (activeContractState is LoadedActiveContractState) {
                _managementPanelScreenBloc.profileBloc.add(
                  GetProfileEvent(
                    employeeId: activeContractState.activeContractEntity.employeeId,
                    personId: state.personId,
                  ),
                );
              }
            }
          },
        ),
        BlocListener<ProfileBloc, ProfileState>(
          bloc: _managementPanelScreenBloc.profileBloc,
          listener: (context, state) {
            if (state is ErrorProfileState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SeniorSnackBar.error(
                  message: context.translate.errorGetProfile,
                  action: SeniorSnackBarAction(
                    label: context.translate.repeat,
                    onPressed: () {
                      final activeContractBlocState = _managementPanelScreenBloc.activeContractBloc.state;
                      final personBlocState = _managementPanelScreenBloc.personBloc.state;
                      if (activeContractBlocState is LoadedActiveContractState &&
                          personBlocState is LoadedPersonState) {
                        _managementPanelScreenBloc.profileBloc.add(
                          GetProfileEvent(
                            employeeId: activeContractBlocState.activeContractEntity.employeeId,
                            personId: personBlocState.personId,
                          ),
                        );
                      }
                    },
                  ),
                ),
              );
            }

            if (state is ErrorUpdateProfileState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SeniorSnackBar.error(
                  message: context.translate.errorOnUpdateProfile,
                  action: SeniorSnackBarAction(
                    label: context.translate.repeat,
                    onPressed: () {
                      final activeContractBlocState = _managementPanelScreenBloc.activeContractBloc.state;
                      final personBlocState = _managementPanelScreenBloc.personBloc.state;
                      if (activeContractBlocState is LoadedActiveContractState &&
                          personBlocState is LoadedPersonState) {
                        _managementPanelScreenBloc.profileBloc.add(
                          GetProfileEvent(
                            employeeId: activeContractBlocState.activeContractEntity.employeeId,
                            personId: personBlocState.personId,
                          ),
                        );
                      }
                    },
                  ),
                ),
              );
            }

            if (state is LoadedProfileState) {
              final activeContractBlocState = _managementPanelScreenBloc.activeContractBloc.state;

              if (activeContractBlocState is LoadedActiveContractState) {
                _managementPanelScreenBloc.contractEmployeeBloc.add(
                  GetContractEmployeeEvent(
                    employeeId: activeContractBlocState.activeContractEntity.employeeId,
                  ),
                );

                final userRoleBloc = Modular.get<UserRoleBloc>();
                if (userRoleBloc.state is! LoadedUserRoleState) {
                  _managementPanelScreenBloc.userRoleBloc.add(const GetUserRoleIdEvent());
                }
              }

              if (state.profileEntity!.name.isNotEmpty) {
                userName = state.profileEntity!.name;
              }
            }
          },
        ),
        BlocListener<ContractEmployeeBloc, ContractEmployeeState>(
          bloc: _managementPanelScreenBloc.contractEmployeeBloc,
          listener: (context, state) {
            if (state is LoadedContractEmployeeState) {
              isWaitingEmployeeContract = false;
            }

            if (state is ErrorContractEmployeeState) {
              isWaitingEmployeeContract = false;
              ScaffoldMessenger.of(context).showSnackBar(
                SeniorSnackBar.error(
                  message: context.translate.errorGetContractEmployee,
                  action: SeniorSnackBarAction(
                    label: context.translate.repeat,
                    onPressed: () {
                      final activeContractBlocState = _managementPanelScreenBloc.activeContractBloc.state;

                      if (activeContractBlocState is LoadedActiveContractState) {
                        _managementPanelScreenBloc.contractEmployeeBloc.add(
                          GetContractEmployeeEvent(
                            employeeId: activeContractBlocState.activeContractEntity.employeeId,
                          ),
                        );
                      }
                    },
                  ),
                ),
              );
            }

            if (state is ErrorUpdateContractEmployeeState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SeniorSnackBar.error(
                  message: context.translate.errorOnUpdateProfile,
                  action: SeniorSnackBarAction(
                    label: context.translate.repeat,
                    onPressed: () {
                      final activeContractBlocState = _managementPanelScreenBloc.activeContractBloc.state;

                      if (activeContractBlocState is LoadedActiveContractState) {
                        _managementPanelScreenBloc.contractEmployeeBloc.add(
                          GetContractEmployeeEvent(
                            employeeId: activeContractBlocState.activeContractEntity.employeeId,
                          ),
                        );
                      }
                    },
                  ),
                ),
              );
            }
          },
        ),
        BlocListener<HappinessIndexBloc, HappinessIndexState>(
          bloc: _happinessIndexBloc,
          listenWhen: (oldState, newState) => oldState != newState,
          listener: (context, state) {
            if (state is HappinessIndexIsEnabledState) {
              _happinessIndexBloc.add(
                GetCurrentHappinessIndexEvent(
                  language: LocaleHelper.languageAndCountryCode(
                    locale: Localizations.localeOf(context),
                  ),
                ),
              );
            }

            if (state is ErrorOnSaveHappinessIndexState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SeniorSnackBar.error(
                  message: state.message ?? context.translate.happinessIndexErrorMessage,
                ),
              );
              _updateHappinessIndexModule();
            }

            if (state is SuccessOnSaveHappinessIndexState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SeniorSnackBar.success(
                  message: context.translate.happinessIndexSuccessMessage,
                ),
              );
              _updateHappinessIndexModule();
            }
          },
        ),
      ],
      child: BlocBuilder<ManagementPanelScreenBloc, ManagementPanelScreenState>(
        bloc: _managementPanelScreenBloc,
        builder: (_, state) {
          final hasClockingState = state.hasClockingState;
          final authorizationState = state.authorizationState;
          final activeContractState = state.activeContractState;
          final connectivityState = state.managementPanelConnectivityState;

          final isOffline = connectivityState is OfflineConnectivityState;

          final happinessIndexEnabled = (_happinessIndexBloc.state is! HappinessIndexIsNotEnabledState);

          final showClockingOffline =
              hasClockingState is LoadedClockingState && hasClockingState.hasClocking && isOffline;

          final hasMoods = (state.moodsState is LoadedMoodsState);

          if (hasClockingState is LoadedClockingState && authorizationState is! LoadedAuthorizationState) {
            if (!hasClockingState.hasClocking) {
              return Scaffold(
                body: WaapiColorfulHeader(
                  title: SeniorText.label(
                    color: SeniorColors.pureWhite,
                    darkColor: SeniorColors.grayscale5,
                    context.translate.appTitle,
                  ),
                  hideLeading: true,
                  body: const OfflineWidget(),
                ),
              );
            }
          }

          if (authorizationState is InitialAuthorizationState &&
              hasClockingState is LoadedClockingState &&
              !hasClockingState.hasClocking) {
            return WaapiColorfulHeader(
              title: SeniorText.label(
                color: SeniorColors.pureWhite,
                darkColor: SeniorColors.grayscale5,
                context.translate.appTitle,
              ),
              hideLeading: true,
              body: const SizedBox.shrink(),
            );
          }

          if (authorizationState is LoadingAuthorizationState ||
              activeContractState is LoadingActiveContractState ||
              (isWaitingEmployeeContract && widget.isWaapiLiteProfile)) {
            return WaapiColorfulHeader(
              title: SeniorText.label(
                color: SeniorColors.pureWhite,
                darkColor: SeniorColors.grayscale5,
                context.translate.appTitle,
              ),
              hideLeading: true,
              body: const WaapiLoadingWidget(),
            );
          }

          if (authorizationState is LoadedAuthorizationState) {
            final activeContract = activeContractState is LoadedActiveContractState;

            if (_managementPanelScreenBloc.profileBloc.state is LoadedProfileState &&
                _managementPanelScreenBloc.contractEmployeeBloc.state is LoadedContractEmployeeState &&
                widget.isWaapiLiteProfile) {
              return ProfileMenuScreen(
                isWaapiLiteProfile: widget.isWaapiLiteProfile,
                isOffline: isOffline,
                employeeId: _getEmployeerId(),
                showSearchPerson: authorizationState.authorizationEntity.allowToSearchPeople,
              );
            }

            return Scaffold(
              body: WaapiColorfulHeader(
                hasTopPadding: false,
                title: SeniorText.label(
                  color: SeniorColors.pureWhite,
                  darkColor: SeniorColors.grayscale5,
                  context.translate.appTitle,
                  key: const Key('management-panel_screen-label_title-text'),
                ),
                hideLeading: true,
                actions: [
                  if (activeContract ||
                      authorizationState.authorizationEntity.allowToViewTimeManagement ||
                      allowGpoOnApp)
                    ManagementPanelActionsSeniorColorfulHeaderStructureWidget(
                      employeeId: _getEmployeerId(),
                      disabled: isOffline,
                      showNotificationsIcon: activeContract,
                      isWaapiLite: authorizationState.authorizationEntity.isWaapiLite,
                      isWaapiLiteProfile: widget.isWaapiLiteProfile,
                      showSearchPerson: authorizationState.authorizationEntity.allowToSearchPeople,
                    ),
                ],
                notification: (showClockingOffline)
                    ? NotificationMessage(
                        icon: FontAwesomeIcons.triangleExclamation,
                        message: context.translate.timeControlNotification,
                        messageType: MessageTypes.messageInfo,
                        showCloseButton: false,
                      )
                    : isOffline
                        ? NotificationMessage(
                            icon: FontAwesomeIcons.triangleExclamation,
                            message: context.translate.offlineModeNotification,
                            messageType: MessageTypes.messageInfo,
                            showCloseButton: false,
                          )
                        : authorizationState.authorizationEntity.isWaapiLite
                            ? NotificationMessage(
                                message: context.translate.waapiLiteNotification,
                                messageType: MessageTypes.messageInfo,
                                icon: FontAwesomeIcons.solidCircleInfo,
                                showCloseButton: false,
                                actionNotification: ActionNotification(
                                  actionName: context.translate.checkOut,
                                  action: () {
                                    _showNotificationDescription(context);
                                  },
                                ),
                              )
                            : null,
                body: Scrollbar(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          height: SeniorSpacing.normal,
                        ),
                        if (state.signOutState.signOutStatus != SignOutStatusEnum.loading)
                          WelcomeWidget(
                            key: const Key('management-panel_screen-welcome_text'),
                            firstName: NameUserHelper.firstName(
                              fullName: userName ?? _user?.fullName,
                              defaultName: context.translate.employee,
                            ),
                            happinessIndexBloc: _happinessIndexBloc,
                          ),
                        Builder(
                          builder: (context) {
                            if (widget.hasPermission) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MyShortcutsWidget(
                                    key: const Key('management-panel_screen-screen_my_shortcuts'),
                                    showTimeManagement:
                                        (authorizationState.authorizationEntity.allowToViewTimeManagement &&
                                                clockingIsActive) ||
                                            allowGpoOnApp,
                                    isUserAllowedToViewProfile:
                                        state.profileState.profileEntity != null && activeContract,
                                    showProfileButton:
                                        _managementPanelScreenBloc.profileBloc.state is LoadedProfileState &&
                                            activeContract &&
                                            authorizationState.authorizationEntity.allowToViewMyProfile,
                                    showFeedbacksButton:
                                        authorizationState.authorizationEntity.allowToViewFeedbacksOrRequests &&
                                            activeContract,
                                    showVacationsButton: (authorizationState.authorizationEntity.allowToViewVacations ||
                                            authorizationState.authorizationEntity.allowToViewCalendarVacations) &&
                                        activeContract,
                                    showSearchPeople:
                                        authorizationState.authorizationEntity.allowToSearchPeople && activeContract,
                                    showFinancialData: false,
                                    showMoodDiary:
                                        happinessIndexEnabled && !authorizationState.authorizationEntity.isWaapiLite,
                                    showHyperlinks:
                                        authorizationState.authorizationEntity.allowToViewHyperlinks && activeContract,
                                    showMoods: hasMoods && activeContract,
                                    showSocial:
                                        authorizationState.authorizationEntity.socialAuthorizationEntity.canViewPosts,
                                    isWaapiLiteProfile: widget.isWaapiLiteProfile,
                                    counterUnreadNotifications: 0,
                                  ),
                                  if ((authorizationState.authorizationEntity.allowToViewTimeManagement) ||
                                      (hasClockingState is LoadedClockingState && hasClockingState.hasClocking))
                                    WaapiClockingEventWidget(
                                      dataClockingFutureToBuild: widget.dataClockingFutureToBuild,
                                      onStatusChanged: (status) {
                                        if (status != clockingIsActive) {
                                          WidgetsBinding.instance.addPostFrameCallback((_) {
                                            setState(() {
                                              clockingIsActive = status;
                                              widget.clockingIsActiveCall.call(
                                                clockingIsActive: status,
                                              );
                                            });
                                          });
                                        }
                                      },
                                    ),
                                  if (_managementPanelScreenBloc.activeContractBloc.state
                                          is LoadedActiveContractState &&
                                      happinessIndexEnabled &&
                                      !authorizationState.authorizationEntity.isWaapiLite)
                                    HappinessIndexBoardWidget(
                                      key: const Key('management-panel_screen-happiness_index_board'),
                                      employeeId: (state.activeContractState as LoadedActiveContractState)
                                          .activeContractEntity
                                          .employeeId,
                                      happinessIndexBloc: _happinessIndexBloc,
                                      disabled: isOffline,
                                    ),

                                  if (_managementPanelScreenBloc.activeContractBloc.state
                                          is LoadedActiveContractState &&
                                      authorizationState.authorizationEntity.allowToViewMyFeedbacks)
                                    RecentFeedbackWidget(
                                      key: const Key('management-panel_screen-session_recent_feedbacks-list_content'),
                                      disabled: isOffline,
                                    ),

                                  if (_managementPanelScreenBloc.activeContractBloc.state
                                          is LoadedActiveContractState &&
                                      authorizationState.authorizationEntity.allowToViewVacationAnalytics)
                                    VacationsAnalyticsWidget(
                                      key: const Key('management-panel_screen-vacation-analytics'),
                                      employeeId: (state.activeContractState as LoadedActiveContractState)
                                          .activeContractEntity
                                          .employeeId,
                                      authorizationBloc: _managementPanelScreenBloc.authorizationBloc,
                                      disabled: isOffline,
                                    ),

                                  if (_managementPanelScreenBloc.activeContractBloc.state
                                          is LoadedActiveContractState &&
                                      authorizationState.authorizationEntity.allowToViewBirthdayCorporateMural)
                                    NextBirthdayEmployeesWidget(
                                      key: const Key('management-panel_screen-next_birthday-list_birthdays_life'),
                                      employeeId: (state.activeContractState as LoadedActiveContractState)
                                          .activeContractEntity
                                          .employeeId,
                                      disabled: isOffline,
                                    ),

                                  if (_managementPanelScreenBloc.activeContractBloc.state
                                          is LoadedActiveContractState &&
                                      authorizationState.authorizationEntity.allowToViewCompanyBirthdayCorporateMural)
                                    NextCompanyBirthdaysWidget(
                                      key: const Key('management-panel_screen-next_birthdays-list_birthdays_company'),
                                      employeeId: (state.activeContractState as LoadedActiveContractState)
                                          .activeContractEntity
                                          .employeeId,
                                      disabled: isOffline,
                                    ),
                                  // This SizedBox ensure we have a small space between the last item of the ManagementPanel screen
                                  // and the bottom edge of the device on Android as well on iOS devices.
                                  SizedBox(
                                    height: context.bottomSize,
                                  ),
                                ],
                              );
                            }

                            return const NotAllowToViewMyFeedbacksWidget();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              backgroundColor: SeniorColors.neutralColor100,
            );
          }

          if (authorizationState is InitialAuthorizationState && showClockingOffline) {
            _getUser().then((user) => _user = user);
            return Scaffold(
              body: WaapiColorfulHeader(
                hasTopPadding: false,
                title: SeniorText.label(
                  color: SeniorColors.pureWhite,
                  darkColor: SeniorColors.grayscale5,
                  context.translate.appTitle,
                  key: const Key('management-panel_screen-label_title-text'),
                ),
                hideLeading: true,
                notification: NotificationMessage(
                  icon: FontAwesomeIcons.triangleExclamation,
                  message: context.translate.timeControlNotification,
                  messageType: MessageTypes.messageInfo,
                  showCloseButton: false,
                ),
                body: Scrollbar(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          height: SeniorSpacing.normal,
                        ),
                        if (state.signOutState.signOutStatus != SignOutStatusEnum.loading)
                          WelcomeWidget(
                            key: const Key('management-panel_screen-welcome_text'),
                            firstName: NameUserHelper.firstName(
                              fullName: userName ?? _user?.fullName,
                              defaultName: context.translate.employee,
                            ),
                            happinessIndexBloc: _happinessIndexBloc,
                          ),
                        Builder(
                          builder: (context) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                MyShortcutsWidget(
                                  key: const Key('management-panel_screen-screen_my_shortcuts'),
                                  showTimeManagement: clockingIsActive,
                                  isUserAllowedToViewProfile: false,
                                  showSocial: false,
                                  showFeedbacksButton: false,
                                  showFinancialData: false,
                                  showMoodDiary: false,
                                  showProfileButton: false,
                                  showSearchPeople: false,
                                  showVacationsButton: false,
                                  showHyperlinks: false,
                                  showMoods: false,
                                  isWaapiLiteProfile: false,
                                  counterUnreadNotifications: 0,
                                ),
                                WaapiClockingEventWidget(
                                  dataClockingFutureToBuild: widget.dataClockingFutureToBuild,
                                  onStatusChanged: (status) {
                                    if (status != clockingIsActive) {
                                      WidgetsBinding.instance.addPostFrameCallback((_) {
                                        setState(() {
                                          clockingIsActive = status;
                                          widget.clockingIsActiveCall.call(
                                            clockingIsActive: status,
                                          );
                                        });
                                      });
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              backgroundColor: SeniorColors.neutralColor100,
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Future<User?> _getUser() async {
    final user = await GetStoredUserUsecase().call(const UserName());
    return user;
  }

  void _updateHappinessIndexModule() {
    _happinessIndexBloc.add(
      HappinessIndexIsEnabledEvent(),
    );
  }

  String? _getEmployeerId() {
    final activeContractBlocState = _managementPanelScreenBloc.activeContractBloc.state;

    if (activeContractBlocState is LoadedActiveContractState) {
      return activeContractBlocState.activeContractEntity.employeeId;
    }
    return null;
  }

  void _showNotificationDescription(BuildContext context) {
    SeniorBottomSheet.showDynamicBottomSheet(
      title: context.translate.waapiLiteVersion,
      context: context,
      content: [
        const WaapiLiteInformationWidget(),
      ],
      hasCloseButton: true,
      onTapCloseButton: () {
        Modular.to.pop();
      },
    );
  }

  void getPermissionGpoOnApp() {
    final getClockingConfiguration = GetClockingConfiguration(
      restService: _restService,
      internalStorageService: _internalStorageService,
      getStoredTokenUsecase: GetStoredTokenUsecase(),
    );
    allowGpoOnApp = GetClockingConfigurationDriverImpl(internalStorageService: _internalStorageService)
            .call(key: getClockingConfiguration.keyAllowGpoOnApp) ??
        false;
  }
}
