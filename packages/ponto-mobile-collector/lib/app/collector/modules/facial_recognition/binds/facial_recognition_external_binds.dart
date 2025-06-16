import 'package:flutter_modular/flutter_modular.dart';

import '../external/datasources/get_employees_to_facial_registration_datasource_impl.dart';
import '../infra/datasources/get_employees_to_facial_registration_datasource.dart';

class FacialRecognitionExternalBinds extends Module {
  @override
  List<Bind> get binds => [
        // Datasources
        Bind.lazySingleton<GetEmployeesToFacialRegistrationDatasource>(
          (i) => GetEmployeesToFacialRegistrationDatasourceImpl(
            httpClient: i(),
            environmentService: i(),
          ),
          export: true,
        ),
      ];
}
