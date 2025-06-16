import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../presenter/blocs/authentication_analytics_bloc/authentication_analytics_bloc.dart';
import '../presenter/blocs/sign_out/sign_out_bloc.dart';

class AuthenticationPresenterBinds {
  static List<Bind<Object>> binds = [
    // Blocs
    Bind.lazySingleton(
      (i) {
        return AuthenticationAnalyticsBloc(
          getStoredUserUsecase: GetStoredUserUsecase(),
        );
      },
      export: true,
    ),

    Bind.singleton<SignOutBloc>(
      (i) {
        return SignOutBloc(
          authenticationBloc: i.get(),
        );
      },
      export: true,
    ),
  ];
}
