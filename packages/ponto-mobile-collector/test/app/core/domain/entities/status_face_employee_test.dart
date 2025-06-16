import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/status_face_employee.dart';

import '../../../../mocks/status_face_employee_mock.dart';

void main() {
  test('toMap and fromMap test', () async {
    Map<String, dynamic> mapDto = statusFaceEmployeeMock.toMap();

    StatusFaceEmployee statusFaceEmployee = StatusFaceEmployee.fromMap(mapDto);

    expect(statusFaceEmployee, statusFaceEmployeeMock);
  });

  test('toJson and fromJson test', () async {
    String jsonDto = statusFaceEmployeeMock.toJson();

    StatusFaceEmployee statusFaceEmployee =
        StatusFaceEmployee.fromJson(jsonDto);

    expect(statusFaceEmployee, statusFaceEmployeeMock);
  });
}
