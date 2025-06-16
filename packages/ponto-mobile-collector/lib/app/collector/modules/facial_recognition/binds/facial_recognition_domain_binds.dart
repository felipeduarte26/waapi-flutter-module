import 'package:flutter_modular/flutter_modular.dart';

import '../domain/usecases/get_employees_to_facial_registration_usecase.dart';

class FacialRecognitionDomainBinds extends Module {
  @override
  List<Bind> get binds => [
        // Usecases
        Bind.lazySingleton<GetEmployeesToFacialRegistrationUsecase>(
          (i) => GetEmployeesToFacialRegistrationUsecaseImpl(
            getEmployeesToFacialRegistrationRepository: i(),
            getAccessTokenUsecase: i(),
          ),
          export: true,
        ),
      ];
}
