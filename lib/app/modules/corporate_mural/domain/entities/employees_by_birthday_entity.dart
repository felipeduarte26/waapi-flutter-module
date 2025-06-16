import 'package:equatable/equatable.dart';

import 'employee_entity.dart';

class EmployeesByBirthdayEntity extends Equatable {
  final DateTime birthday;
  final List<EmployeeEntity> employees;

  const EmployeesByBirthdayEntity({
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
