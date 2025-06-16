import 'dart:convert';

import '../../infra/models/employees_by_year_hire_model.dart';
import 'employees_by_hire_date_model_mapper.dart';

class EmployeesByYearHireModelMapper {
  final EmployeesByHireDateModelMapper _employeesByHireDateModelMapper;

  const EmployeesByYearHireModelMapper({
    required EmployeesByHireDateModelMapper employeesByHireDateModelMapper,
  }) : _employeesByHireDateModelMapper = employeesByHireDateModelMapper;

  EmployeesByYearHireModel fromMap({
    required Map<String, dynamic> employeesByYearHireMap,
  }) {
    return EmployeesByYearHireModel(
      yearsCount: employeesByYearHireMap['yearsCount'] ?? 0,
      employeesByHireDateModel: (employeesByYearHireMap['employeesByHireDate'] as List).map((employeesByHireDate) {
        return _employeesByHireDateModelMapper.fromMap(
          employeesByHireDateMap: employeesByHireDate,
        );
      }).toList(),
    );
  }

  List<EmployeesByYearHireModel> fromJson({
    required String? employeesByYearHireJson,
  }) {
    if (employeesByYearHireJson == null || employeesByYearHireJson.isEmpty) {
      return [];
    }

    final employeesByYearHireModelMap = jsonDecode(employeesByYearHireJson);
    final employeesByYearHireModelMapData = (employeesByYearHireModelMap['list'] ?? []) as List;

    return employeesByYearHireModelMapData.map((employeesByYearHireModelMap) {
      return fromMap(
        employeesByYearHireMap: employeesByYearHireModelMap,
      );
    }).toList();
  }
}
