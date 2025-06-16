import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../../../../../core/services/has_clocking/presenter/bloc/has_clocking_bloc.dart';
import '../../../../../../active_contract/presenter/blocs/active_contract_bloc/active_contract_bloc.dart';
import '../../../../../../attachment/presenter/blocs/attachment_bloc/attachment_bloc.dart';
import '../../../../../../authentication/presenter/blocs/sign_out/sign_out_bloc.dart';
import '../../../../../../authorization/presenter/blocs/authorization_bloc/authorization_bloc.dart';
import '../../../../../../home/presenter/bloc/connectivity_bloc/connectivity_bloc.dart';
import '../../../../../../moods/presenter/blocs/moods_bloc/moods_bloc.dart';
import '../../../../../../onboarding/presenter/blocs/onboarding_bloc/onboarding_bloc.dart';
import '../../../../../../personalization/presenter/bloc/personalization_bloc/personalization_bloc.dart';
import '../../../../../../profile/presenter/blocs/contract_employee_bloc/contract_employee_bloc.dart';
import '../../../../../../profile/presenter/blocs/person_bloc/person_bloc.dart';
import '../../../../../../profile/presenter/blocs/profile_bloc/profile_bloc.dart';
import '../../../../../../profile/presenter/blocs/user_role/user_role_bloc.dart';
import '../../../../../../vacations/presenter/blocs/vacation_analytics/vacations_analytics_bloc.dart';
import '../management_panel_feedback/management_panel_feedback_bloc.dart';
import 'management_panel_screen_event.dart';
import 'management_panel_screen_state.dart';

class ManagementPanelScreenBloc extends Bloc<ManagementPanelScreenEvent, ManagementPanelScreenState> {
  final AuthorizationBloc authorizationBloc;
  final AuthenticationBloc authenticationBloc;
  final ManagementPanelFeedbackBloc managementPanelFeedbackBloc;
  final ProfileBloc profileBloc;
  final ContractEmployeeBloc contractEmployeeBloc;
  final PersonBloc personBloc;
  final ActiveContractBloc activeContractBloc;
  final SignOutBloc signOutBloc;
  final OnboardingBloc onboardingBloc;
  final VacationsAnalyticsBloc vacationAnalyticsBloc;
  final AttachmentBloc attachmentBloc;
  final UserRoleBloc userRoleBloc;
  final ConnectivityBloc connectivityBloc;
  final PersonalizationBloc personalizationBloc;
  final HasClockingBloc hasClockingBloc;
  final MoodsBloc moodsBloc;

  late StreamSubscription authorizationSubscription;
  late StreamSubscription authenticationSubscription;
  late StreamSubscription managementPanelFeedbackSubscription;
  late StreamSubscription permissionNotificationSubscription;
  late StreamSubscription counterNotificationsSubscription;
  late StreamSubscription profileSubscription;
  late StreamSubscription contractEmployeeSubscription;
  late StreamSubscription personSubscription;
  late StreamSubscription activeContractSubscription;
  late StreamSubscription signOutSubscription;
  late StreamSubscription onboardingSubscription;
  late StreamSubscription vacationAnalyticsSubscription;
  late StreamSubscription attachmentSubscription;
  late StreamSubscription userRoleSubscription;
  late StreamSubscription managementPanelConnectivitySubscription;
  late StreamSubscription personalizationSubscription;
  late StreamSubscription hasClockingSubscription;
  late StreamSubscription moodsSubscription;

  ManagementPanelScreenBloc({
    required this.authorizationBloc,
    required this.authenticationBloc,
    required this.managementPanelFeedbackBloc,
    required this.profileBloc,
    required this.contractEmployeeBloc,
    required this.personBloc,
    required this.activeContractBloc,
    required this.signOutBloc,
    required this.onboardingBloc,
    required this.vacationAnalyticsBloc,
    required this.attachmentBloc,
    required this.userRoleBloc,
    required this.connectivityBloc,
    required this.personalizationBloc,
    required this.hasClockingBloc,
    required this.moodsBloc,
  }) : super(
          CurrentManagementPanelScreenState(
            authorizationState: authorizationBloc.state,
            authenticationState: authenticationBloc.state,
            managementPanelFeedbackState: managementPanelFeedbackBloc.state,
            profileState: profileBloc.state,
            contractEmployeeState: contractEmployeeBloc.state,
            personState: personBloc.state,
            activeContractState: activeContractBloc.state,
            signOutState: signOutBloc.state,
            onboardingState: onboardingBloc.state,
            vacationsAnalyticsState: vacationAnalyticsBloc.state,
            attachmentState: attachmentBloc.state,
            userRoleState: userRoleBloc.state,
            managementPanelConnectivityState: connectivityBloc.state,
            personalizationState: personalizationBloc.state,
            hasClockingState: hasClockingBloc.state,
            moodsState: moodsBloc.state,
          ),
        ) {
    on<ChangeAuthorizationStateEvent>(_changeAuthorizationStateEvent);
    on<ChangeAuthenticationStateEvent>(_changeAuthenticationStateEvent);
    on<ChangeManagementPanelFeedbackStateEvent>(_changeManagementPanelFeedbackStateEvent);
    on<ChangeProfileStateEvent>(_changeProfileStateEvent);
    on<ChangeContractEmployeeStateEvent>(_changeContractEmployeeStateEvent);
    on<ChangePersonStateEvent>(_changePersonStateEvent);
    on<ChangeActiveContractStateEvent>(_changeActiveContractStateEvent);
    on<ChangeSignOutStateEvent>(_changeSignOutStateEvent);
    on<ChangeOnboardingStateEvent>(_changeOnboardingStateEvent);
    on<ChangeVacationAnalyticsStateEvent>(_changeVacationAnalyticsStateEvent);
    on<ChangeAttachmentStateEvent>(_changeAttachmentStateEvent);
    on<ChangeUserRoleStateEvent>(_changeUserRoleStateEvent);
    on<ChangeManagementPanelConnectivityStateEvent>(_changeManagementPanelConnectivityStateEvent);
    on<ChangePersonalizationStateEvent>(_changePersonalizationStateEvent);
    on<ChangeHasClockingStateEvent>(_changeHasClockingStateEvent);
    on<ChangeManagementPanelMoodsStateEvent>(_changeMoodsStateEvent);

    managementPanelFeedbackSubscription = managementPanelFeedbackBloc.stream.listen(
      (managementPanelFeedbackBlocState) {
        add(
          ChangeManagementPanelFeedbackStateEvent(
            managementPanelFeedbackState: managementPanelFeedbackBlocState,
          ),
        );
      },
    );

    vacationAnalyticsSubscription = vacationAnalyticsBloc.stream.listen(
      (vacationAnalyticsState) {
        add(
          ChangeVacationAnalyticsStateEvent(
            vacationAnalyticsState: vacationAnalyticsState,
          ),
        );
      },
    );

    attachmentSubscription = attachmentBloc.stream.listen(
      (attachmentState) {
        add(
          ChangeAttachmentStateEvent(
            attachmentState: attachmentState,
          ),
        );
      },
    );

    authorizationSubscription = authorizationBloc.stream.listen(
      (authorizationBlocState) {
        add(
          ChangeAuthorizationStateEvent(
            authorizationState: authorizationBlocState,
          ),
        );
      },
    );

    personalizationSubscription = personalizationBloc.stream.listen(
      (personalizationState) {
        add(
          ChangePersonalizationStateEvent(
            personalizationState: personalizationState,
          ),
        );
      },
    );

    authenticationSubscription = authenticationBloc.stream.listen(
      (authenticationBlocState) {
        add(
          ChangeAuthenticationStateEvent(
            authenticationState: authenticationBlocState,
          ),
        );
      },
    );

    profileSubscription = profileBloc.stream.listen(
      (profileBlocState) {
        add(
          ChangeProfileStateEvent(
            profileState: profileBlocState,
          ),
        );
      },
    );

    contractEmployeeSubscription = contractEmployeeBloc.stream.listen(
      (contractEmployeeBlocState) {
        add(
          ChangeContractEmployeeStateEvent(
            contractEmployeeState: contractEmployeeBlocState,
          ),
        );
      },
    );

    personSubscription = personBloc.stream.listen(
      (personBlocState) {
        add(
          ChangePersonStateEvent(
            personState: personBlocState,
          ),
        );
      },
    );

    activeContractSubscription = activeContractBloc.stream.listen(
      (activeContractState) {
        add(
          ChangeActiveContractStateEvent(
            activeContractState: activeContractState,
          ),
        );
      },
    );

    signOutSubscription = signOutBloc.stream.listen(
      (signOutState) {
        add(
          ChangeSignOutStateEvent(
            signOutState: signOutState,
          ),
        );
      },
    );

    onboardingSubscription = onboardingBloc.stream.listen(
      (onboardingState) {
        add(
          ChangeOnboardingStateEvent(
            onboardingState: onboardingState,
          ),
        );
      },
    );

    userRoleSubscription = userRoleBloc.stream.listen(
      (userRoleBlocState) {
        add(
          ChangeUserRoleStateEvent(
            userRoleState: userRoleBlocState,
          ),
        );
      },
    );

    managementPanelConnectivitySubscription = connectivityBloc.stream.listen(
      (managementPanelConnectivityState) {
        add(
          ChangeManagementPanelConnectivityStateEvent(
            managementPanelConnectivityState: managementPanelConnectivityState,
          ),
        );
      },
    );

    hasClockingSubscription = hasClockingBloc.stream.listen(
      (hasClockingState) {
        add(
          ChangeHasClockingStateEvent(
            hasClockingState: hasClockingState,
          ),
        );
      },
    );

    moodsSubscription = moodsBloc.stream.listen(
      (moodsState) {
        add(
          ChangeManagementPanelMoodsStateEvent(
            moodsState: moodsState,
          ),
        );
      },
    );
  }

  Future<void> _changeAuthorizationStateEvent(
    ChangeAuthorizationStateEvent event,
    Emitter<ManagementPanelScreenState> emit,
  ) async {
    emit(
      state.currentState(
        authorizationState: event.authorizationState,
      ),
    );
  }

  Future<void> _changePersonalizationStateEvent(
    ChangePersonalizationStateEvent event,
    Emitter<ManagementPanelScreenState> emit,
  ) async {
    emit(
      state.currentState(
        personalizationState: event.personalizationState,
      ),
    );
  }

  Future<void> _changeManagementPanelFeedbackStateEvent(
    ChangeManagementPanelFeedbackStateEvent event,
    Emitter<ManagementPanelScreenState> emit,
  ) async {
    emit(
      state.currentState(
        managementPanelFeedbackState: event.managementPanelFeedbackState,
      ),
    );
  }

  Future<void> _changeVacationAnalyticsStateEvent(
    ChangeVacationAnalyticsStateEvent event,
    Emitter<ManagementPanelScreenState> emit,
  ) async {
    emit(
      state.currentState(
        vacationsAnalyticsState: event.vacationAnalyticsState,
      ),
    );
  }

  Future<void> _changeAttachmentStateEvent(
    ChangeAttachmentStateEvent event,
    Emitter<ManagementPanelScreenState> emit,
  ) async {
    emit(
      state.currentState(
        attachmentState: event.attachmentState,
      ),
    );
  }

  Future<void> _changeAuthenticationStateEvent(
    ChangeAuthenticationStateEvent event,
    Emitter<ManagementPanelScreenState> emit,
  ) async {
    emit(
      state.currentState(
        authenticationState: event.authenticationState,
      ),
    );
  }

  Future<void> _changeProfileStateEvent(
    ChangeProfileStateEvent event,
    Emitter<ManagementPanelScreenState> emit,
  ) async {
    emit(
      state.currentState(
        profileState: event.profileState,
      ),
    );
  }

  Future<void> _changeContractEmployeeStateEvent(
    ChangeContractEmployeeStateEvent event,
    Emitter<ManagementPanelScreenState> emit,
  ) async {
    emit(
      state.currentState(
        contractEmployeeState: event.contractEmployeeState,
      ),
    );
  }

  Future<void> _changePersonStateEvent(
    ChangePersonStateEvent event,
    Emitter<ManagementPanelScreenState> emit,
  ) async {
    emit(
      state.currentState(
        personState: event.personState,
      ),
    );
  }

  Future<void> _changeActiveContractStateEvent(
    ChangeActiveContractStateEvent event,
    Emitter<ManagementPanelScreenState> emit,
  ) async {
    emit(
      state.currentState(
        activeContractState: event.activeContractState,
      ),
    );
  }

  Future<void> _changeSignOutStateEvent(
    ChangeSignOutStateEvent event,
    Emitter<ManagementPanelScreenState> emit,
  ) async {
    emit(
      state.currentState(
        signOutState: event.signOutState,
      ),
    );
  }

  Future<void> _changeOnboardingStateEvent(
    ChangeOnboardingStateEvent event,
    Emitter<ManagementPanelScreenState> emit,
  ) async {
    emit(
      state.currentState(
        onboardingState: event.onboardingState,
      ),
    );
  }

  Future<void> _changeUserRoleStateEvent(
    ChangeUserRoleStateEvent event,
    Emitter<ManagementPanelScreenState> emit,
  ) async {
    emit(
      state.currentState(
        userRoleState: event.userRoleState,
      ),
    );
  }

  Future<void> _changeManagementPanelConnectivityStateEvent(
    ChangeManagementPanelConnectivityStateEvent event,
    Emitter<ManagementPanelScreenState> emit,
  ) async {
    emit(
      state.currentState(
        managementPanelConnectivityState: event.managementPanelConnectivityState,
      ),
    );
  }

  Future<void> _changeHasClockingStateEvent(
    ChangeHasClockingStateEvent event,
    Emitter<ManagementPanelScreenState> emit,
  ) async {
    emit(
      state.currentState(
        hasClockingState: event.hasClockingState,
      ),
    );
  }

  Future<void> _changeMoodsStateEvent(
    ChangeManagementPanelMoodsStateEvent event,
    Emitter<ManagementPanelScreenState> emit,
  ) async {
    emit(
      state.currentState(
        moodsState: event.moodsState,
      ),
    );
  }

  @override
  Future<void> close() async {
    await authenticationSubscription.cancel();
    await authorizationSubscription.cancel();
    await managementPanelFeedbackSubscription.cancel();
    await permissionNotificationSubscription.cancel();
    await counterNotificationsSubscription.cancel();
    await profileSubscription.cancel();
    await activeContractSubscription.cancel();
    await signOutSubscription.cancel();
    await onboardingSubscription.cancel();
    await vacationAnalyticsSubscription.cancel();
    await userRoleSubscription.cancel();
    await managementPanelConnectivitySubscription.cancel();
    await personalizationSubscription.cancel();
    await hasClockingSubscription.cancel();
    await moodsSubscription.cancel();

    return super.close();
  }
}
