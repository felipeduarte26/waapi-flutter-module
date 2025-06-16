import 'package:equatable/equatable.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../../../../../core/services/has_clocking/presenter/bloc/has_clocking_state.dart';
import '../../../../../../active_contract/presenter/blocs/active_contract_bloc/active_contract_state.dart';
import '../../../../../../attachment/presenter/blocs/attachment_bloc/attachment_state.dart';
import '../../../../../../authentication/presenter/blocs/sign_out/sign_out_state.dart';
import '../../../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../../../../../home/presenter/bloc/connectivity_bloc/connectivity_state.dart';
import '../../../../../../moods/presenter/blocs/moods_bloc/moods_state.dart';
import '../../../../../../onboarding/presenter/blocs/onboarding_bloc/onboarding_state.dart';
import '../../../../../../personalization/presenter/bloc/personalization_bloc/personalization_bloc.dart';
import '../../../../../../profile/presenter/blocs/contract_employee_bloc/contract_employee_state.dart';
import '../../../../../../profile/presenter/blocs/person_bloc/person_state.dart';
import '../../../../../../profile/presenter/blocs/profile_bloc/profile_state.dart';
import '../../../../../../profile/presenter/blocs/user_role/user_role_state.dart';
import '../../../../../../vacations/presenter/blocs/vacation_analytics/vacations_analytics_state.dart';
import '../management_panel_feedback/management_panel_feedback_state.dart';

abstract class ManagementPanelScreenState extends Equatable {
  final AuthorizationState authorizationState;
  final AuthenticationState authenticationState;
  final ManagementPanelFeedbackState managementPanelFeedbackState;
  final ProfileState profileState;
  final PersonState personState;
  final ContractEmployeeState contractEmployeeState;
  final ActiveContractState activeContractState;
  final SignOutState signOutState;
  final OnboardingState onboardingState;
  final VacationsAnalyticsState vacationsAnalyticsState;
  final AttachmentState attachmentState;
  final UserRoleState userRoleState;
  final ConnectivityState managementPanelConnectivityState;
  final PersonalizationState personalizationState;
  final HasClockingState hasClockingState;
  final MoodsState moodsState;

  const ManagementPanelScreenState({
    required this.authorizationState,
    required this.authenticationState,
    required this.managementPanelFeedbackState,
    required this.profileState,
    required this.contractEmployeeState,
    required this.personState,
    required this.activeContractState,
    required this.signOutState,
    required this.onboardingState,
    required this.vacationsAnalyticsState,
    required this.attachmentState,
    required this.userRoleState,
    required this.managementPanelConnectivityState,
    required this.personalizationState,
    required this.hasClockingState,
    required this.moodsState,
  });

  CurrentManagementPanelScreenState currentState({
    AuthorizationState? authorizationState,
    AuthenticationState? authenticationState,
    ManagementPanelFeedbackState? managementPanelFeedbackState,
    ProfileState? profileState,
    ContractEmployeeState? contractEmployeeState,
    PersonState? personState,
    ActiveContractState? activeContractState,
    SignOutState? signOutState,
    OnboardingState? onboardingState,
    VacationsAnalyticsState? vacationsAnalyticsState,
    AttachmentState? attachmentState,
    UserRoleState? userRoleState,
    final ConnectivityState? managementPanelConnectivityState,
    PersonalizationState? personalizationState,
    HasClockingState? hasClockingState,
    MoodsState? moodsState,
  }) {
    return CurrentManagementPanelScreenState(
      authorizationState: authorizationState ?? this.authorizationState,
      authenticationState: authenticationState ?? this.authenticationState,
      managementPanelFeedbackState: managementPanelFeedbackState ?? this.managementPanelFeedbackState,
      profileState: profileState ?? this.profileState,
      contractEmployeeState: contractEmployeeState ?? this.contractEmployeeState,
      personState: personState ?? this.personState,
      activeContractState: activeContractState ?? this.activeContractState,
      signOutState: signOutState ?? this.signOutState,
      onboardingState: onboardingState ?? this.onboardingState,
      vacationsAnalyticsState: vacationsAnalyticsState ?? this.vacationsAnalyticsState,
      attachmentState: attachmentState ?? this.attachmentState,
      userRoleState: userRoleState ?? this.userRoleState,
      managementPanelConnectivityState: managementPanelConnectivityState ?? this.managementPanelConnectivityState,
      personalizationState: personalizationState ?? this.personalizationState,
      hasClockingState: hasClockingState ?? this.hasClockingState,
      moodsState: moodsState ?? this.moodsState,
    );
  }

  @override
  List<Object?> get props {
    return [
      authorizationState,
      authenticationState,
      managementPanelFeedbackState,
      profileState,
      contractEmployeeState,
      personState,
      activeContractState,
      signOutState,
      onboardingState,
      vacationsAnalyticsState,
      attachmentState,
      userRoleState,
      managementPanelConnectivityState,
      personalizationState,
      hasClockingState,
      moodsState,
    ];
  }
}

class CurrentManagementPanelScreenState extends ManagementPanelScreenState {
  const CurrentManagementPanelScreenState({
    required AuthorizationState authorizationState,
    required AuthenticationState authenticationState,
    required ManagementPanelFeedbackState managementPanelFeedbackState,
    required ProfileState profileState,
    required ContractEmployeeState contractEmployeeState,
    required PersonState personState,
    required ActiveContractState activeContractState,
    required SignOutState signOutState,
    required OnboardingState onboardingState,
    required VacationsAnalyticsState vacationsAnalyticsState,
    required AttachmentState attachmentState,
    required UserRoleState userRoleState,
    required ConnectivityState managementPanelConnectivityState,
    required PersonalizationState personalizationState,
    required HasClockingState hasClockingState,
    required MoodsState moodsState,
  }) : super(
          authorizationState: authorizationState,
          authenticationState: authenticationState,
          managementPanelFeedbackState: managementPanelFeedbackState,
          profileState: profileState,
          contractEmployeeState: contractEmployeeState,
          personState: personState,
          activeContractState: activeContractState,
          signOutState: signOutState,
          onboardingState: onboardingState,
          vacationsAnalyticsState: vacationsAnalyticsState,
          attachmentState: attachmentState,
          userRoleState: userRoleState,
          managementPanelConnectivityState: managementPanelConnectivityState,
          personalizationState: personalizationState,
          hasClockingState: hasClockingState,
          moodsState: moodsState,
        );
}
