import 'package:flutter_modular/flutter_modular.dart';

import 'presenter/cubit/hours_tab_cubit.dart';

class HoursBinds extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton<HoursTabCubit>(
          (i) => HoursTabCubit(),
          export: true,
          onDispose: (value) => value.close(),
        ),
      ];
}
