import 'package:flutter_modular/flutter_modular.dart';

import '../../routes/routes.dart';
import 'authentication_screen.dart';
import 'binds/authentication_presenter_binds.dart';

class AuthenticationModule extends Module {
  @override
  List<Bind<Object>> get binds {
    return [
      ...AuthenticationPresenterBinds.binds,
    ];
  }

  @override
  List<ModularRoute> get routes {
    return [
      ChildRoute(
        AuthenticationRoutes.authenticationScreenRoute,
        child: (_, __) {
          return const AuthenticationScreen();
        },
      ),
    ];
  }
}
