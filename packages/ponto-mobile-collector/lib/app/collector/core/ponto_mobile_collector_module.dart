import 'package:flutter_modular/flutter_modular.dart';

import '../../../../ponto_mobile_collector.dart';
import '../modules/configuration/configuration_module.dart';
import '../modules/device_configuration_permission/device_configuration_permission_module.dart';
import '../modules/privacy_policy/privacy_policy_module.dart';
import '../modules/routes/configuration_routes.dart';
import '../modules/routes/device_configuration_permission_routes.dart';
import '../modules/routes/privacy_policy_routes.dart';

/// Main module
class PontoMobileCollectorModule extends Module {
  /// User authentication screen path
  String? pathLogin;

  PontoMobileCollectorModule({this.pathLogin});

  @override
  List<Module> get imports => [
        PontoMobileCollectorBinds(),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(
          ClockingEventRoutes.module,
          module: ClockingEventModule(),
        ),
        ModuleRoute(
          '/${TimeAdjustmentRoutes.module}',
          module: TimeAdjustmentModule(),
        ),
        ModuleRoute(
          '/${ConfigurationRoutes.module}',
          module: ConfigurationModule(pathLogin: pathLogin),
        ),
        ModuleRoute(
          '/${FacialRecognitionRoutes.module}',
          module: FacialRecognitionModule(
            homePath: Modular.get<CollectorModuleService>().getHomePath(),
          ),
        ),
        ModuleRoute(
          '/${DeviceConfigurationPermissionRoutes.module}',
          module: DeviceConfigurationPermissionModule(
            homePath: Modular.get<CollectorModuleService>().getHomePath(),
          ),
        ),
        ModuleRoute(
          '/${PrivacyPolicyRoutes.module}',
          module: PrivacyPolicyModule(
            homePath: Modular.get<CollectorModuleService>().getHomePath(),
          ),
        ),
        ModuleRoute(
          '/${HoursRoutes.module}',
          module: HoursModule(),
        ),
        ChildRoute(
          '/hub_clocking',
          child: (context, args) => HubClockingPage(
            hubMenuCubit: Modular.get(),
            context: context,
          ),
        ),
        ModuleRoute(
          '/${ApplicationKeyRoutes.module}',
          module: ApplicationKeyModule(
            homePath: Modular.get<CollectorModuleService>().getHomePath(),
          ),
        ),
        ModuleRoute(
          '/${AboutRoutes.module}',
          module: AboutModule(),
        ),
        ModuleRoute(
          DriversJourneyRoutes.module,
          module: DriversJourneyModule(),
        ),
        ModuleRoute(
          NotificationCollectorRoutes.module,
          module: NotificationCollectorModule(),
        ),
      ];
}
