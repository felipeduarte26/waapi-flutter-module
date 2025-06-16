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

abstract class ManagementPanelScreenEvent extends Equatable {}

class ChangeAuthorizationStateEvent extends ManagementPanelScreenEvent {
  final AuthorizationState authorizationState;

  ChangeAuthorizationStateEvent({
    required this.authorizationState,
  });

  @override
  List<Object?> get props {
    return [
      authorizationState,
    ];
  }
}

class ChangeAuthenticationStateEvent extends ManagementPanelScreenEvent {
  final AuthenticationState authenticationState;

  ChangeAuthenticationStateEvent({
    required this.authenticationState,
  });

  @override
  List<Object?> get props {
    return [
      authenticationState,
    ];
  }
}

class ChangeManagementPanelFeedbackStateEvent extends ManagementPanelScreenEvent {
  final ManagementPanelFeedbackState managementPanelFeedbackState;

  ChangeManagementPanelFeedbackStateEvent({
    required this.managementPanelFeedbackState,
  });

  @override
  List<Object?> get props {
    return [
      managementPanelFeedbackState,
    ];
  }
}

class ChangeVacationAnalyticsStateEvent extends ManagementPanelScreenEvent {
  final VacationsAnalyticsState vacationAnalyticsState;

  ChangeVacationAnalyticsStateEvent({
    required this.vacationAnalyticsState,
  });

  @override
  List<Object?> get props {
    return [
      vacationAnalyticsState,
    ];
  }
}

class ChangeAttachmentStateEvent extends ManagementPanelScreenEvent {
  final AttachmentState attachmentState;

  ChangeAttachmentStateEvent({
    required this.attachmentState,
  });

  @override
  List<Object?> get props {
    return [
      attachmentState,
    ];
  }
}

class ChangeProfileStateEvent extends ManagementPanelScreenEvent {
  final ProfileState profileState;

  ChangeProfileStateEvent({
    required this.profileState,
  });

  @override
  List<Object?> get props {
    return [
      profileState,
    ];
  }
}

class ChangeContractEmployeeStateEvent extends ManagementPanelScreenEvent {
  final ContractEmployeeState contractEmployeeState;

  ChangeContractEmployeeStateEvent({
    required this.contractEmployeeState,
  });

  @override
  List<Object?> get props {
    return [
      contractEmployeeState,
    ];
  }
}

class ChangePersonStateEvent extends ManagementPanelScreenEvent {
  final PersonState personState;

  ChangePersonStateEvent({
    required this.personState,
  });

  @override
  List<Object?> get props {
    return [
      personState,
    ];
  }
}

class ChangeActiveContractStateEvent extends ManagementPanelScreenEvent {
  final ActiveContractState activeContractState;

  ChangeActiveContractStateEvent({
    required this.activeContractState,
  });

  @override
  List<Object?> get props {
    return [
      activeContractState,
    ];
  }
}

class ChangeSignOutStateEvent extends ManagementPanelScreenEvent {
  final SignOutState signOutState;

  ChangeSignOutStateEvent({
    required this.signOutState,
  });

  @override
  List<Object?> get props {
    return [
      signOutState,
    ];
  }
}

class ChangeOnboardingStateEvent extends ManagementPanelScreenEvent {
  final OnboardingState onboardingState;

  ChangeOnboardingStateEvent({
    required this.onboardingState,
  });

  @override
  List<Object?> get props {
    return [
      onboardingState,
    ];
  }
}

class ChangeUserRoleStateEvent extends ManagementPanelScreenEvent {
  final UserRoleState userRoleState;

  ChangeUserRoleStateEvent({
    required this.userRoleState,
  });

  @override
  List<Object?> get props {
    return [
      userRoleState,
    ];
  }
}

class ChangeManagementPanelConnectivityStateEvent extends ManagementPanelScreenEvent {
  final ConnectivityState managementPanelConnectivityState;

  ChangeManagementPanelConnectivityStateEvent({
    required this.managementPanelConnectivityState,
  });

  @override
  List<Object?> get props {
    return [
      managementPanelConnectivityState,
    ];
  }
}

class ChangePersonalizationStateEvent extends ManagementPanelScreenEvent {
  final PersonalizationState personalizationState;

  ChangePersonalizationStateEvent({
    required this.personalizationState,
  });

  @override
  List<Object?> get props {
    return [
      personalizationState,
    ];
  }
}

class ChangeHasClockingStateEvent extends ManagementPanelScreenEvent {
  final HasClockingState hasClockingState;

  ChangeHasClockingStateEvent({
    required this.hasClockingState,
  });

  @override
  List<Object?> get props {
    return [
      hasClockingState,
    ];
  }
}

class ChangeManagementPanelMoodsStateEvent extends ManagementPanelScreenEvent {
  final MoodsState moodsState;

  ChangeManagementPanelMoodsStateEvent({
    required this.moodsState,
  });

  @override
  List<Object?> get props {
    return [
      moodsState,
    ];
  }
}
