import 'package:equatable/equatable.dart';

import 'employee_model.dart';

class EmployeesByHireDateModel extends Equatable {
  final DateTime hireDate;
  final List<EmployeeModel> employees;

  const EmployeesByHireDateModel({
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
