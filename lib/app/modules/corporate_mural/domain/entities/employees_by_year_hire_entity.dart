import 'package:equatable/equatable.dart';

import 'employees_by_hire_date_entity.dart';

class EmployeesByYearHireEntity extends Equatable {
  final int yearsCount;
  final List<EmployeesByHireDateEntity> employeesByHireDateEntity;

  const EmployeesByYearHireEntity({
    required this.yearsCount,
    required this.employeesByHireDateEntity,
  });

  @override
  List<Object> get props {
    return [
      yearsCount,
      employeesByHireDateEntity,
    ];
  }
}
