import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/domain/enums/face_recognition_status_enum.dart';

void main() {
  group('FaceRecognitionStatusEnum', () {
    test('isSuccess returns true for success status', () {
      expect(FaceRecognitionStatusEnum.success.isSuccess, isTrue);
    });

    test('isSuccess returns false for non-success status', () {
      expect(FaceRecognitionStatusEnum.iaError.isSuccess, isFalse);
      expect(FaceRecognitionStatusEnum.notRecognized.isSuccess, isFalse);
      expect(FaceRecognitionStatusEnum.noPersonsRegistered.isSuccess, isFalse);
      expect(FaceRecognitionStatusEnum.notAuthenticated.isSuccess, isFalse);
      expect(FaceRecognitionStatusEnum.unknown.isSuccess, isFalse);
      expect(FaceRecognitionStatusEnum.fraudEvidence.isSuccess, isFalse);
    });

    test('build returns correct enum for given statusCode', () {
      expect(
        FaceRecognitionStatusEnum.build(statusCode: 90),
        FaceRecognitionStatusEnum.success,
      );
      expect(
        FaceRecognitionStatusEnum.build(statusCode: 91),
        FaceRecognitionStatusEnum.iaError,
      );
      expect(
        FaceRecognitionStatusEnum.build(statusCode: 93),
        FaceRecognitionStatusEnum.notRecognized,
      );
      expect(
        FaceRecognitionStatusEnum.build(statusCode: 95),
        FaceRecognitionStatusEnum.noPersonsRegistered,
      );
      expect(
        FaceRecognitionStatusEnum.build(statusCode: 96),
        FaceRecognitionStatusEnum.notAuthenticated,
      );
      expect(
        FaceRecognitionStatusEnum.build(statusCode: 97),
        FaceRecognitionStatusEnum.fraudEvidence,
      );
    });

    test('build returns unknown for unknown statusCode', () {
      expect(
        FaceRecognitionStatusEnum.build(statusCode: 999),
        FaceRecognitionStatusEnum.unknown,
      );
    });
  });
}
