import 'package:flutter_modular/flutter_modular.dart';
import '../../core/domain/services/navigator/navigator_service.dart';
import '../routes/device_configuration_permission_routes.dart';
import 'device_configuration_permission_binds.dart';
import 'domain/presenter/cubit/device_configuration_permission_cubit.dart';
import 'domain/presenter/screens/device_configuration_permission_screen.dart';

class DeviceConfigurationPermissionModule extends Module {
  String homePath;

  DeviceConfigurationPermissionModule({required this.homePath});
  @override
  List<Bind> get binds => [];

  @override
  List<Module> get imports => [
        DeviceConfigurationPermissionBinds(),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/${DeviceConfigurationPermissionRoutes.home}',
          child: (context, args) => DeviceConfigurationPermissionScreen(
            cubit: Modular.get<DeviceConfigurationPermissionCubit>(),
            navigatorService: Modular.get<NavigatorService>(),
          ),
        ),
      ];
}
