import 'package:equatable/equatable.dart';

import 'employees_by_birthday_model.dart';

class BirthdayEmployeesModel extends Equatable {
  final List<EmployeesByBirthdayModel> employeesByBirthday;

  const BirthdayEmployeesModel({
    required this.employeesByBirthday,
  });

  @override
  List<Object> get props {
    return [
      employeesByBirthday,
    ];
  }
}
