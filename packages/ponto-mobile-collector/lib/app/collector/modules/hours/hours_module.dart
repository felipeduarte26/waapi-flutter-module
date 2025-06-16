import 'package:flutter_modular/flutter_modular.dart';

import '../routes/hours_routes.dart';
import 'hours_binds.dart';
import 'presenter/cubit/hours_tab_cubit.dart';
import 'presenter/screens/hours_screen.dart';

class HoursModule extends Module {
  @override
  List<Module> get imports => [
        HoursBinds(),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          HoursRoutes.home,
          child: (context, args) =>
              HoursScreen(hoursTabCubit: Modular.get<HoursTabCubit>()),
        ),
      ];
}
