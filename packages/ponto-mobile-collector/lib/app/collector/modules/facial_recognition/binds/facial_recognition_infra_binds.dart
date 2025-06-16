import 'package:flutter_modular/flutter_modular.dart';

import '../domain/repositories/get_employees_to_facial_registration_repository.dart';
import '../infra/adapters/employee_item_entity_adapter.dart';
import '../infra/repositories/get_employees_to_facial_registration_repository_impl.dart';

class FacialRecognitionInfraBinds extends Module {
  @override
  List<Bind> get binds => [
        // Repositories
        Bind.lazySingleton<GetEmployeesToFacialRegistrationRepository>(
          (i) => GetEmployeesToFacialRegistrationRepositoryImpl(
            employeeItemEntityAdapter: i(),
            getEmployeesToFacialRegistrationDatasource: i(),
          ),
          export: true,
        ),

        // Adapters
        Bind.lazySingleton<EmployeeItemEntityAdapter>(
          (i) => EmployeeItemEntityAdapter(),
          export: true,
        ),
      ];
}
