import 'package:flutter_modular/flutter_modular.dart';

import '../external/datasources/get_next_15_days_birthday_employees_datasource_impl.dart';
import '../external/datasources/get_next_15_days_birthdays_company_datasource_impl.dart';
import '../external/mappers/birthday_employees_model_mapper.dart';
import '../external/mappers/employee_model_mapper.dart';
import '../external/mappers/employees_by_birthday_model_mapper.dart';
import '../external/mappers/employees_by_hire_date_model_mapper.dart';
import '../external/mappers/employees_by_year_hire_model_mapper.dart';
import '../infra/datasources/get_next_15_days_birthday_employees_datasource.dart';
import '../infra/datasources/get_next_15_days_birthdays_company_datasource.dart';

class CorporateMuralExternalBinds {
  static List<Bind<Object>> binds = [
    // Mappers
    Bind.lazySingleton(
      (i) {
        return EmployeeModelMapper();
      },
      export: true,
    ),

    Bind.lazySingleton(
      (i) {
        return EmployeesByBirthdayModelMapper(
          employeeModelMapper: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton(
      (i) {
        return BirthdayEmployeesModelMapper(
          employeesByBirthdayModelMapper: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton(
      (i) {
        return EmployeesByHireDateModelMapper(
          employeeModelMapper: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton(
      (i) {
        return EmployeesByYearHireModelMapper(
          employeesByHireDateModelMapper: i.get(),
        );
      },
      export: true,
    ),

    // Datasources
    Bind.lazySingleton<GetNext15DaysBirthdayEmployeesDatasource>(
      (i) {
        return GetNext15DaysBirthdayEmployeesDatasourceImpl(
          restService: i.get(),
          birthdayEmployeesModelMapper: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<GetNext15DaysBirthdaysCompanyDatasource>(
      (i) {
        return GetNext15DaysBirthdaysCompanyDatasourceImpl(
          restService: i.get(),
          employeesByYearHireModelMapper: i.get(),
        );
      },
      export: true,
    ),
  ];
}
