import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_system/components/senior_bottom_sheet/senior_bottom_sheet_widget.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../core/extension/media_query_extension.dart';
import '../../../core/services/has_clocking/presenter/bloc/has_clocking_event.dart';
import '../../../core/services/has_clocking_configuration/external/drivers/get_clocking_configuration_driver_impl.dart';
import '../../../core/services/has_clocking_configuration/external/get_clocking_configuration.dart';
import '../../../core/services/internal_storage/internal_storage_service.dart';
import '../../../core/services/rest_client/rest_service.dart';
import '../../../routes/authentication_routes.dart';
import '../../active_contract/presenter/blocs/active_contract_bloc/active_contract_event.dart';
import '../../active_contract/presenter/blocs/active_contract_bloc/active_contract_state.dart';
import '../../authorization/domain/entities/authorization_entity.dart';
import '../../authorization/domain/entities/social_authorization_entity.dart';
import '../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../management_panel/helpers/management_panel_dialog_helper.dart';
import '../../management_panel/presenter/screens/management_panel/widgets/error_active_contract_widget.dart';
import '../../management_panel/presenter/screens/management_panel/widgets/no_active_contract_found_widget.dart';
import '../../onboarding/domain/enums/onboarding_view_key_enum.dart';
import '../../onboarding/presenter/blocs/onboarding_bloc/onboarding_event.dart';
import '../presenter/bloc/home_screen_bloc/home_screen_bloc.dart';

class HomeScreenListenerController {
  final BuildContext Function() getContext;
  final HomeScreenBloc homeScreenBloc;
  final bool Function({required bool isSignOut}) onSignOutChanged;
  bool isSignOut = false;
  bool _isManagementPanelActive = false;
  bool allowGpoOnApp = false;

  final RestService _restService = Modular.get<RestService>();
  final InternalStorageService _internalStorageService = Modular.get<InternalStorageService>();

  HomeScreenListenerController({
    required this.getContext,
    required this.homeScreenBloc,
    required this.onSignOutChanged,
  });

  void handleHomeScreenState({
    required AuthenticationState authenticationState,
    required BuildContext context,
  }) {
    if (authenticationState.status == AuthenticationStatus.unauthenticated) {
      Modular.to.navigate(AuthenticationRoutes.authenticationModuleRoute);
    } else if (homeScreenBloc.state.authorizationState is ErrorAuthorizationState) {
      homeScreenBloc.authenticationBloc.add(const AuthenticationStatusChanged(AuthenticationStatus.unauthenticated));
    }

    final authorizationState = homeScreenBloc.state.authorizationState;
    final activeContractState = homeScreenBloc.state.activeContractState;
    var allowToViewTimeManagement = false;
    allowGpoOnApp = getPermissionGpoOnApp();

    if (authorizationState is LoadedAuthorizationState && activeContractState is InitialActiveContractState) {
      homeScreenBloc.activeContractBloc.add(GetActiveContractEvent());
      _isManagementPanelActive = isManagementPanelActive(
        authorizationEntity: authorizationState.authorizationEntity,
      );
      allowToViewTimeManagement = authorizationState.authorizationEntity.allowToViewTimeManagement;

      if (allowToViewTimeManagement) {
        homeScreenBloc.hasClockingBloc.add(SetActiveHasClockingEvent());
      } else {
        homeScreenBloc.hasClockingBloc.add(SetInactiveHasClockingEvent());
      }
    }

    if (activeContractState is NoActiveContractState || !_isManagementPanelActive && !isSignOut) {
      if (authorizationState is LoadedAuthorizationState) {
        final authorizationEntity = authorizationState.authorizationEntity;

        allowToViewTimeManagement = authorizationEntity.allowToViewTimeManagement;

        final isSocialActive = this.isSocialActive(
          socialAuthorizationEntity: authorizationEntity.socialAuthorizationEntity,
        );

        if (!allowToViewTimeManagement && !isSocialActive && !allowGpoOnApp) {
          return _openNoActiveContractBottomSheet(
            context,
          );
        }
      }
    }

    if (activeContractState is ErrorActiveContractState && authorizationState is ErrorAuthorizationState) {
      _openErrorActiveContractBottomSheet(
        context: context,
      );
    }
  }

  void _openNoActiveContractBottomSheet(
    BuildContext context,
  ) {
    SeniorBottomSheet.showBottomSheet(
      context: context,
      height: context.bottomSheetSize,
      content: [
        Expanded(
          child: NoActiveContractFoundWidget(
            onSignOut: () => _openSignOutModelDialog(
              context: context,
            ),
          ),
        ),
      ],
      hasCloseButton: false,
      enableDrag: false,
      isDismissible: false,
    );
  }

  void _openSignOutModelDialog({
    required BuildContext context,
  }) {
    final onboardingBloc = homeScreenBloc.onboardingBloc;

    ManagementPanelDialogHelper.openSignOutModelDialog(
      context: context,
      onSignOut: () {
        onboardingBloc.add(
          const SaveAlreadyViewedOnboardingEvent(
            onboardingViewKeyEnum: OnboardingViewKeyEnum.tour,
            visualized: false,
          ),
        );
        isSignOut = true;

        onSignOutChanged.call(
          isSignOut: isSignOut,
        );
      },
    );
  }

  void _openErrorActiveContractBottomSheet({required BuildContext context}) {
    SeniorBottomSheet.showBottomSheet(
      context: getContext(),
      height: getContext().bottomSheetSize,
      content: [
        Expanded(
          child: ErrorActiveContractWidget(
            onSignOut: () => _openSignOutModelDialog(
              context: context,
            ),
            onTryAgain: () {
              Modular.to.pop();
              homeScreenBloc.activeContractBloc.add(GetActiveContractEvent());
            },
          ),
        ),
      ],
      hasCloseButton: false,
      enableDrag: false,
      isDismissible: false,
    );
  }

  bool isManagementPanelActive({
    required AuthorizationEntity authorizationEntity,
  }) {
    allowGpoOnApp = getPermissionGpoOnApp();
    return authorizationEntity.allowToViewFeedbacksOrRequests ||
        authorizationEntity.allowToViewMyFeedbacks ||
        authorizationEntity.allowToViewMyProfile ||
        authorizationEntity.allowToViewBirthdayCorporateMural ||
        authorizationEntity.allowToViewVacations ||
        authorizationEntity.allowToViewCalendarVacations ||
        authorizationEntity.allowToSearchPeople ||
        authorizationEntity.allowToViewVacationAnalytics ||
        authorizationEntity.allowToViewCompanyBirthdayCorporateMural ||
        authorizationEntity.allowToViewTimeManagement ||
        allowGpoOnApp ||
        (authorizationEntity.allowToFinancialData && authorizationEntity.allowToPayroll) ||
        authorizationEntity.allowToViewHyperlinks;
  }

  bool isSocialActive({
    required SocialAuthorizationEntity socialAuthorizationEntity,
  }) {
    return socialAuthorizationEntity.canViewPosts;
  }

  bool isWaapiLiteProfile({
    required AuthorizationEntity authorizationEntity,
    required bool happinessIndexEnabled,
  }) {
    return authorizationEntity.allowToViewMyProfile &&
        !authorizationEntity.allowToViewBirthdayCorporateMural &&
        !authorizationEntity.allowToViewCompanyBirthdayCorporateMural &&
        !authorizationEntity.allowToViewTimeManagement &&
        authorizationEntity.isWaapiLite &&
        !authorizationEntity.socialAuthorizationEntity.canViewPosts &&
        !happinessIndexEnabled;
  }

  bool getPermissionGpoOnApp() {
    final getClockingConfiguration = GetClockingConfiguration(
      restService: _restService,
      internalStorageService: _internalStorageService,
      getStoredTokenUsecase: GetStoredTokenUsecase(),
    );
    allowGpoOnApp = GetClockingConfigurationDriverImpl(internalStorageService: _internalStorageService)
            .call(key: getClockingConfiguration.keyAllowGpoOnApp) ??
        false;
    return allowGpoOnApp;
  }
}
