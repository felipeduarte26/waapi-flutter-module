import 'package:flutter_modular/flutter_modular.dart';

import '../../core/domain/services/navigator/navigator_service.dart';
import '../../core/domain/usecases/get_execution_mode_usecase.dart';
import '../../core/domain/usecases/logoff_usecase.dart';
import '../../core/presenter/cubit/sync_all_individual_info/sync_all_individual_info_cubit.dart';
import '../routes/configuration_routes.dart';
import 'configuration_binds.dart';
import 'presenter/cubit/configuration/configuration_cubit.dart';
import 'presenter/screens/configuration_screen.dart';

class ConfigurationModule extends Module {
  /// User authentication screen path
  String? pathLogin;

  ConfigurationModule({this.pathLogin});

  @override
  List<Module> get imports => [
        ConfigurationBinds(),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/${ConfigurationRoutes.home}',
          child: (context, args) => ConfigurationScreen(
            pathLogin: pathLogin,
            configurationCubit: Modular.get<ConfigurationCubit>(),
            synchronizationCubit: Modular.get<SyncAllIndividualInfoCubit>(),
            iLogoffUsecase: Modular.get<ILogoffUsecase>(),
            navigatorService: Modular.get<NavigatorService>(),
            getExecutionModeUsecase: Modular.get<GetExecutionModeUsecase>(),
          ),
        ),
      ];
}
