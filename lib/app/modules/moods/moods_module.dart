import 'package:flutter_modular/flutter_modular.dart';

import '../../routes/moods_routes.dart';
import 'binds/moods_domain_binds.dart';
import 'binds/moods_external_binds.dart';
import 'binds/moods_infra_binds.dart';
import 'binds/moods_presenter_binds.dart';
import 'presenter/screens/moods_empty_screen.dart';

class MoodsModule extends Module {
  @override
  List<Bind<Object>> get binds {
    return [
      ...MoodsDomainBinds.binds,
      ...MoodsInfraBinds.binds,
      ...MoodsExternalBinds.binds,
      ...MoodsPresenterBinds.binds,
    ];
  }

  @override
  List<ModularRoute> get routes {
    return [
      ChildRoute(
        MoodsRoutes.moodsScreenRoute,
        child: (_, args) {
          return const MoodsEmptyScreen();
        },
      ),
    ];
  }
}
