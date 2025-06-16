import 'package:flutter_modular/flutter_modular.dart';

import '../../routes/happiness_index_routes.dart';
import 'binds/happiness_index_domain_binds.dart';
import 'binds/happiness_index_external_binds.dart';
import 'binds/happiness_index_infra_binds.dart';
import 'binds/happiness_index_presenter_binds.dart';
import 'presenter/screens/happiness_index_report/happiness_index_report_screen.dart';
import 'presenter/screens/mood_details/mood_details_screen.dart';

class HappinessIndexModule extends Module {
  @override
  List<Bind> get binds {
    return [
      ...HappinessIndexDomainBinds.binds,
      ...HappinessIndexInfraBinds.binds,
      ...HappinessIndexExternalBinds.binds,
      ...HappinessIndexPresenterBinds.binds,
    ];
  }

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          HappinessIndexRoutes.happinessIndexScreenRoute,
          child: (_, args) {
            return HappinessIndexReportScreen(
              employeeId: args.data['employeeId'],
            );
          },
        ),
        ChildRoute(
          HappinessIndexRoutes.moodDetailsScreenRoute,
          child: (_, args) {
            return MoodDetailsScreen(
              mood: args.data,
            );
          },
        ),
      ];
}
