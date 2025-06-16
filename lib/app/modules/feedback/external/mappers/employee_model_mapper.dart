import 'dart:convert';

import '../../infra/models/employee_model.dart';

class EmployeeModelMapper {
  EmployeeModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return EmployeeModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      username: map['username'] ?? '',
      nickname: map['nickname'] ?? '',
      photoUrl: map['photoLink'] ?? '',
    );
  }

  EmployeeModel fromJson({
    required String employeeJson,
  }) {
    if (employeeJson.isEmpty) {
      return fromMap(
        map: {},
      );
    }

    return fromMap(
      map: json.decode(employeeJson),
    );
  }

  List<EmployeeModel> fromJsonList({
    required String employeesSearchJson,
  }) {
    if (employeesSearchJson.isEmpty) {
      return [];
    }

    final employeesSearchDecoded = json.decode(
      employeesSearchJson,
    );

    return (employeesSearchDecoded as List).map(
      (employeeMap) {
        return fromMap(
          map: employeeMap,
        );
      },
    ).toList();
  }
}
