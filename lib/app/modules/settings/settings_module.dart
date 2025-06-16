import 'package:flutter_modular/flutter_modular.dart';
import 'package:ponto_mobile_collector/app/collector/modules/configuration/presenter/cubit/configuration/configuration_cubit.dart';

import '../../routes/routes.dart';
import 'binds/settings_domain_binds.dart';
import 'binds/settings_external_binds.dart';
import 'binds/settings_infra_binds.dart';
import 'binds/settings_presenter_binds.dart';
import 'presenter/screens/settings_screen/bloc/settings_screen_bloc.dart';
import 'presenter/screens/settings_screen/settings_screen.dart';

class SettingsModule extends Module {
  @override
  List<Bind<Object>> get binds {
    return [
      ...SettingsPresenterBinds.binds,
      ...SettingsDomainBinds.binds,
      ...SettingsInfraBinds.binds,
      ...SettingsExternalBinds.binds,
    ];
  }

  @override
  List<ModularRoute> get routes {
    return [
      ChildRoute(
        SettingsRoutes.settingsScreenRoute,
        child: (_, args) {
          return SettingsScreen(
            settingsScreenBloc: Modular.get<SettingsScreenBloc>(),
            disabled: args.data['disabled'],
            isWaapiLite: args.data['isWaapiLite'],
            configurationCubit: Modular.get<ConfigurationCubit>(),
          );
        },
      ),
    ];
  }
}
