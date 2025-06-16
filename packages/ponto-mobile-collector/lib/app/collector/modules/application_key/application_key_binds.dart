import 'package:flutter_modular/flutter_modular.dart';

import 'presenter/cubit/application_key_cubit.dart';
import 'presenter/cubit/failed_authentication_key_cubit/failed_authentication_key_cubit.dart';

class ApplicationKeyBinds extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton<ApplicationKeyCubit>(
          (i) => ApplicationKeyCubit(
            getAccessTokenUsecase: i(),
            getTokenUsecase: i(),
            checkUserPermissionUsecase: i(),
            sharedPreferencesService: i(),
            utils: i(),
            getExecutionModeUsecase: i(),
            clockingEventRepository: i(),
            hasConnectivityUsecase: i(),
            removeApplicationKeyUsecase: i(),
            deauthenticateUserUsecase: i(),
          ),
          export: true,
        ),
        Bind.lazySingleton<FailedAuthenticationKeyCubit>(
          (i) => FailedAuthenticationKeyCubit(
            authenticateRegisteredKeyUsecase: i(),
            navigatorService: i(),
            hasConnectivityUsecase: i(),
          ),
          export: true,
        ),
      ];
}
