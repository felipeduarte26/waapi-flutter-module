import 'package:equatable/equatable.dart';

import 'employees_by_hire_date_model.dart';

class EmployeesByYearHireModel extends Equatable {
  final int yearsCount;
  final List<EmployeesByHireDateModel> employeesByHireDateModel;

  const EmployeesByYearHireModel({
    required this.yearsCount,
    required this.employeesByHireDateModel,
  });

  @override
  List<Object> get props {
    return [
      yearsCount,
      employeesByHireDateModel,
    ];
  }
}
