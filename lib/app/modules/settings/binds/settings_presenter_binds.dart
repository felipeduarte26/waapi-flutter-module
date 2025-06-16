import 'package:flutter_modular/flutter_modular.dart';
import 'package:ponto_mobile_collector/app/collector/modules/configuration/presenter/cubit/configuration/configuration_cubit.dart';

import '../presenter/blocs/get_current_version/get_current_version_bloc.dart';
import '../presenter/screens/settings_screen/bloc/settings_screen_bloc.dart';

class SettingsPresenterBinds {
  static List<Bind<Object>> binds = [
    // Blocs
    Bind.singleton((i) {
      return GetCurrentVersionBloc(
        getCurrentVersionUsecase: i.get(),
      );
    }),

    Bind.singleton((i) {
      return SettingsScreenBloc(
        getCurrentVersionBloc: i.get(),
        signOutBloc: i.get(),
        onboardingBloc: i.get(),
      );
    }),

    Bind.singleton((i) {
      return ConfigurationCubit(
        getUserFaceRecognitionUsecase: i.get(),
        sharedPreferencesService: i.get(),
        syncLogsApiUsecase: i.get(),
        getLogsUsecase: i.get(),
        checkUserPermissionUsecase: i.get(),
        hasConnectivityUsecase: i.get(),
        navigatorService: i.get(),
      );
    }),
  ];
}
