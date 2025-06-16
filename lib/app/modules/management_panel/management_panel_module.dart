import 'package:flutter_modular/flutter_modular.dart';

import '../../routes/routes.dart';
import 'binds/management_panel_presenter_binds.dart';
import 'presenter/screens/documentation_mood_diary_screen/documentation_mood_diary_screen.dart';
import 'presenter/screens/documentation_waapi_lite_screen/documentation_waapi_lite_screen.dart';

class ManagementPanelModule extends Module {
  @override
  List<Bind<Object>> get binds {
    return [
      ...ManagementPanelPresenterBinds.binds,
    ];
  }

  @override
  List<ModularRoute> get routes {
    return [
      ChildRoute(
        ManagementPanelRoutes.documentationHappinessScreenRoute,
        transition: TransitionType.noTransition,
        child: (_, __) {
          return const DocumentationMoodDiaryScreen();
        },
      ),
      ChildRoute(
        ManagementPanelRoutes.documentationWaapiLiteScreenRoute,
        transition: TransitionType.noTransition,
        child: (_, __) {
          return const DocumentationWaapiLiteScreen();
        },
      ),
    ];
  }
}
