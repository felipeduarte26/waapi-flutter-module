import 'package:flutter_modular/flutter_modular.dart';

import '../presenter/blocs/birthday_employees/birthday_employees_bloc.dart';
import '../presenter/blocs/company_birthdays/company_birthdays_bloc.dart';

class CorporateMuralPresenterBinds {
  static List<Bind<Object>> binds = [
    // Blocs
    Bind.lazySingleton(
      (i) {
        return BirthdayEmployeesBloc(
          getNext15DaysBirthdayEmployeesUsecase: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton(
      (i) {
        return CompanyBirthdaysBloc(
          getNext15DaysBirthdaysCompanyUsecase: i.get(),
        );
      },
      export: true,
    ),
  ];
}
