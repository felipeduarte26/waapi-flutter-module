import 'package:flutter_modular/flutter_modular.dart';

import '../domain/usecases/get_next_15_days_birthday_employees_usecase.dart';
import '../domain/usecases/get_next_15_days_birthdays_company_usecase.dart';

class CorporateMuralDomainBinds {
  static List<Bind<Object>> binds = [
    // Usecases
    Bind.lazySingleton<GetNext15DaysBirthdayEmployeesUsecase>(
      (i) {
        return GetNext15DaysBirthdayEmployeesUsecaseImpl(
          getNext15DaysBirthdayEmployeesRepository: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<GetNext15DaysBirthdaysCompanyUsecase>(
      (i) {
        return GetNext15DaysBirthdaysCompanyUsecaseImpl(
          getNext15DaysBirthdaysCompanyRepository: i.get(),
        );
      },
      export: true,
    ),
  ];
}
