import 'package:equatable/equatable.dart';

import 'employee_model.dart';

class EmployeesByBirthdayModel extends Equatable {
  final DateTime birthday;
  final List<EmployeeModel> employees;

  const EmployeesByBirthdayModel({
    required this.birthday,
    required this.employees,
  });

  @override
  List<Object> get props {
    return [
      birthday,
      employees,
    ];
  }
}
