import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/facial_recognition_message.dart';

import '../../../../mocks/facial_recognition_message_mock.dart';

void main() {
  group('FacialRecognitionMessage', () {
    test('toMap and fromMap test', () async {
      Map<dynamic, dynamic> mapDto = facialRecognitionMessageMock.toMap();
      facialRecognitionMessageMock.hashCode;
      FacialRecognitionMessage facialRecognitionMessage =
          FacialRecognitionMessage.fromMap(mapDto);

      expect(facialRecognitionMessage, facialRecognitionMessageMock);
    });

    test('call toString test', () async {
      expect(
        facialRecognitionMessageMock.toString(),
        'Code: 95, Status: status, Message: message, detectionIssues: {message: message}, AuditId: auditId, Camera: null',
      );
    });
  });
}
