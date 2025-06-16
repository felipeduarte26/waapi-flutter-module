import 'package:flutter_modular/flutter_modular.dart';

import '../presenter/screens/management_panel/blocs/management_panel_feedback/management_panel_feedback_bloc.dart';
import '../presenter/screens/management_panel/blocs/management_panel_screen/management_panel_screen_bloc.dart';

class ManagementPanelPresenterBinds {
  static List<Bind<Object>> binds = [
    // Blocs
    Bind.singleton<ManagementPanelScreenBloc>(
      (i) {
        return ManagementPanelScreenBloc(
          managementPanelFeedbackBloc: i.get(),
          authorizationBloc: i.get(),
          authenticationBloc: i.get(),
          profileBloc: i.get(),
          contractEmployeeBloc: i.get(),
          personBloc: i.get(),
          activeContractBloc: i.get(),
          signOutBloc: i.get(),
          onboardingBloc: i.get(),
          vacationAnalyticsBloc: i.get(),
          attachmentBloc: i.get(),
          userRoleBloc: i.get(),
          connectivityBloc: i.get(),
          personalizationBloc: i.get(),
          hasClockingBloc: i.get(),
          moodsBloc: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton<ManagementPanelFeedbackBloc>(
      (i) {
        return ManagementPanelFeedbackBloc(
          getLatestFeedbacksUsecase: i.get(),
        );
      },
      export: true,
    ),
  ];
}
