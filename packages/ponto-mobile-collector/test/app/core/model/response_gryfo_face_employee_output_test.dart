import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/adapters/response_gryfo_face_employee_output.dart';

import '../../../mocks/response_gryfo_face_employee_output_mock.dart';

void main() {
  group('ResponseGryfoFaceEmployeeOutput', () {
    test('toMap and fromMap test', () async {
      Map<String, dynamic> mapDto = responseGryfoFaceEmployeeOutputMock.toMap();

      ResponseGryfoFaceEmployeeOutput responseGryfoFaceEmployeeOutput =
          ResponseGryfoFaceEmployeeOutput.fromMap(mapDto);

      expect(
        responseGryfoFaceEmployeeOutput,
        responseGryfoFaceEmployeeOutputMock,
      );
    });

    test('toJson and fromJson test', () async {
      String jsonDto = responseGryfoFaceEmployeeOutputMock.toJson();

      ResponseGryfoFaceEmployeeOutput responseGryfoFaceEmployeeOutput =
          ResponseGryfoFaceEmployeeOutput.fromJson(jsonDto);

      expect(
        responseGryfoFaceEmployeeOutput,
        responseGryfoFaceEmployeeOutputMock,
      );
    });
  });
}
