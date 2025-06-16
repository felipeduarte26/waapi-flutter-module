import 'package:flutter_modular/flutter_modular.dart';

import '../presenter/blocs/authorization_bloc/authorization_bloc.dart';

class AuthorizationPresenterBinds {
  static List<Bind<Object>> binds = [
    // Blocs
    Bind.singleton<AuthorizationBloc>(
      (i) {
        return AuthorizationBloc(
          getUserAuthorizationsUsecase: i.get(),
        );
      },
      export: true,
    ),
  ];
}
