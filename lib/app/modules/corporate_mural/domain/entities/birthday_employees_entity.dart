import 'package:equatable/equatable.dart';

import 'employees_by_birthday_entity.dart';

class BirthdayEmployeesEntity extends Equatable {
  final List<EmployeesByBirthdayEntity> employeesByBirthday;

  const BirthdayEmployeesEntity({
    required this.employeesByBirthday,
  });

  @override
  List<Object> get props {
    return [
      employeesByBirthday,
    ];
  }
}
