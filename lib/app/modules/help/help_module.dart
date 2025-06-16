import 'package:flutter_modular/flutter_modular.dart';

import '../../routes/routes.dart';
import 'presenter/screens/help_screen.dart';

class HelpModule extends Module {
  @override
  List<Bind<Object>> get binds {
    return [];
  }

  @override
  List<ModularRoute> get routes {
    return [
      ChildRoute(
        HelpRoutes.helpScreenRoute,
        child: (_, __) {
          return const HelpScreen();
        },
      ),
    ];
  }
}
