import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/response_gryfo_face_employee_dto.dart';

import '../../../mocks/response_gryfo_face_employee_dto_mock.dart';

void main() {
  group('ResponseGryfoFaceEmployeeDto', () {
    test('toMap and fromMap test', () async {
      Map<String, dynamic> mapDto = responseGryfoFaceEmployeeDtoMock.toMap();

      ResponseGryfoFaceEmployeeDto responseGryfoFaceEmployeeDto =
          ResponseGryfoFaceEmployeeDto.fromMap(mapDto);

      expect(responseGryfoFaceEmployeeDto, responseGryfoFaceEmployeeDtoMock);
    });

    test('toJson and fromJson test', () async {
      String jsonDto = responseGryfoFaceEmployeeDtoMock.toJson();

      ResponseGryfoFaceEmployeeDto responseGryfoFaceEmployeeDto =
          ResponseGryfoFaceEmployeeDto.fromJson(jsonDto);

      expect(responseGryfoFaceEmployeeDto, responseGryfoFaceEmployeeDtoMock);
    });
  });
}
