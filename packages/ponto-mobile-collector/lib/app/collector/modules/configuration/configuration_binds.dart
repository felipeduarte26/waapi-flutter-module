import 'package:flutter_modular/flutter_modular.dart';

import 'presenter/cubit/configuration/configuration_cubit.dart';

class ConfigurationBinds extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton<ConfigurationCubit>(
          (i) => ConfigurationCubit(
            getUserFaceRecognitionUsecase: i(),
            sharedPreferencesService: i(),
            syncLogsApiUsecase: i(),
            getLogsUsecase: i(),
            checkUserPermissionUsecase: i(),
            hasConnectivityUsecase: i(),
            navigatorService: i(),
          ),
          export: true,
          onDispose: (value) => value.close(),
        ),
      ];
}
