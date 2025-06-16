import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/facial_recognition_message.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/facial_recognition_data_enum.dart';

void main() {
  const FacialRecognitionMessage tMessageSuccess = FacialRecognitionMessage(
    code: 100,
    status: 'status',
    message: 'message',
    detectionIssues: 'detectionIssues',
    auditId: 'auditId',
    method: 'authenticate',
  );

  const FacialRecognitionMessage tMessageDownloaded = FacialRecognitionMessage(
    code: 100,
    status: 'status',
    message: 'message',
    detectionIssues: 'detectionIssues',
    auditId: 'auditId',
    method: 'downloadWeights',
  );

  group('FacialRecognitionCodesEnum', () {
    test('call hasMatch successfully test', () {
      expect(
        FacialRecognitionCodesEnum.successfullyAuthenticated
            .hasMatch(tMessageSuccess),
        true,
      );
      expect(
        FacialRecognitionCodesEnum.successfullyDownloadedAiFiles
            .hasMatch(tMessageDownloaded),
        true,
      );
    });
  });
}
