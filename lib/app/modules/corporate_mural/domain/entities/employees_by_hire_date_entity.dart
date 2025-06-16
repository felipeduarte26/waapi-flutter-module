import 'package:equatable/equatable.dart';

import 'employee_entity.dart';

class EmployeesByHireDateEntity extends Equatable {
  final DateTime hireDate;
  final List<EmployeeEntity> employees;

  const EmployeesByHireDateEntity({
    required this.hireDate,
    required this.employees,
  });

  @override
  List<Object> get props {
    return [
      hireDate,
      employees,
    ];
  }
}
