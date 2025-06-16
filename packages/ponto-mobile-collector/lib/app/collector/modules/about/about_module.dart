import 'package:flutter_modular/flutter_modular.dart';
import '../../core/domain/services/navigator/navigator_service.dart';
import '../routes/about_routes.dart';
import 'about_binds.dart';
import 'domain/presenter/cubit/about_cubit.dart';
import 'domain/presenter/screens/about_screen.dart';

class AboutModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<Module> get imports => [
        AboutBinds(),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/${AboutRoutes.home}',
          child: (context, args) => AboutScreen(
            cubit: Modular.get<AboutCubit>(),
            navigatorService: Modular.get<NavigatorService>(),
          ),
        ),
      ];
}
