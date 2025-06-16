import 'package:flutter_modular/flutter_modular.dart';

import '../presenter/cubit/employee_search/employee_search_cubit.dart';

class FacialRecognitionPresenterBinds extends Module {
  @override
  List<Bind> get binds => [
        // Cubits
        Bind.lazySingleton<EmployeeSearchCubit>(
          (i) => EmployeeSearchCubit(
            getEmployeesToFacialRegistrationUsecase: i(),
            checkUserPermissionUsecase: i(),
            hasConnectivityUsecase: i(),
          ),
          export: true,
        ),
      ];
}
