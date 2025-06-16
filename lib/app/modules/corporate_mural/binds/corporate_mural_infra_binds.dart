import 'package:flutter_modular/flutter_modular.dart';

import '../domain/repositories/get_next_15_days_birthday_employees_repository.dart';
import '../domain/repositories/get_next_15_days_birthdays_company_repository.dart';
import '../infra/adapters/birthday_employees_model_adapter.dart';
import '../infra/adapters/employee_model_adapter.dart';
import '../infra/adapters/employees_by_birthday_model_adapter.dart';
import '../infra/adapters/employees_by_hire_date_model_adapter.dart';
import '../infra/adapters/employees_by_year_hire_entity_adapter.dart';
import '../infra/repositories/get_next_15_days_birthday_employees_repository_impl.dart';
import '../infra/repositories/get_next_15_days_birthdays_company_repository_impl.dart';

class CorporateMuralInfraBinds {
  static List<Bind<Object>> binds = [
    // Adapters
    Bind.lazySingleton(
      (i) {
        return EmployeeModelAdapter();
      },
      export: true,
    ),

    Bind.lazySingleton(
      (i) {
        return EmployeesByBirthdayModelAdapter(
          employeeModelAdapter: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton(
      (i) {
        return BirthdayEmployeesModelAdapter(
          employeesByBirthdayModelAdapter: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton(
      (i) {
        return EmployeesByHireDateModelAdapter(
          employeeModelAdapter: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton(
      (i) {
        return EmployeesByYearHireEntityAdapter(
          employeesByHireDateModelAdapter: i.get(),
        );
      },
      export: true,
    ),

    // Repositories
    Bind.lazySingleton<GetNext15DaysBirthdayEmployeesRepository>(
      (i) {
        return GetNext15DaysBirthdayEmployeesRepositoryImpl(
          getNext15DaysBirthdayEmployeesDatasource: i.get(),
          birthdayEmployeesModelAdapter: i.get(),
          
        );
      },
      export: true,
    ),

    Bind.lazySingleton<GetNext15DaysBirthdaysCompanyRepository>(
      (i) {
        return GetNext15DaysBirthdaysCompanyRepositoryImpl(
          getNext15DaysBirthdaysCompanyDatasource: i.get(),
          employeesByYearHireEntityAdapter: i.get(),
          
        );
      },
      export: true,
    ),
  ];
}
