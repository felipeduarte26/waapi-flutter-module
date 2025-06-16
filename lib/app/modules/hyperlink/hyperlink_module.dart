import 'package:flutter_modular/flutter_modular.dart';

import '../../routes/hyperlink_routes.dart';
import '../g5/g5_module.dart';
import 'binds/hyperlink_domain_binds.dart';
import 'binds/hyperlink_external_binds.dart';
import 'binds/hyperlink_infra_binds.dart';
import 'binds/hyperlink_presenter_binds.dart';
import 'presenter/screens/hyperlink_screen.dart';
import 'presenter/screens/hyperlink_selected_screen.dart';
import 'presenter/screens/hyperlink_state_screen.dart';

class HyperlinkModule extends Module {
  @override
  List<Bind<Object>> get binds {
    return [
      ...HyperlinkDomainBinds.binds,
      ...HyperlinkInfraBinds.binds,
      ...HyperlinkExternalBinds.binds,
      ...HyperlinkPresenterBinds.binds,
    ];
  }

  @override
  List<Module> get imports => [
        G5Module(),
      ];

  @override
  List<ModularRoute> get routes {
    return [
      ChildRoute(
        HyperlinkRoutes.hyperlinkScreenRoute,
        child: (_, args) {
          return HyperlinkScreen(
            employeeId: args.data['employeeId'] ?? '',
            userRoleId: args.data['userRoleId'] ?? '',
          );
        },
      ),
      ChildRoute(
        HyperlinkRoutes.hyperlinkSelectedScreenRoute,
        child: (_, args) {
          return HyperlinkSelectedScreen(
            hyperlink: args.data['hyperlink'],
          );
        },
      ),
      ChildRoute(
        HyperlinkRoutes.hyperlinkStateScreenRoute,
        child: (_, args) {
          return HyperlinkStateScreen(
            stateEnum: args.data['stateEnum'],
            onTapTryAgain: args.data['onTapTryAgain'],
          );
        },
      ),
    ];
  }
}
