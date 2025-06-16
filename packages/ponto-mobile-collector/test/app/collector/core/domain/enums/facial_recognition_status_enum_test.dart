import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/facial_recognition_status_enum.dart';

void main() {
  group('FacialRecognitionStatusEnum', () {
    test('should return correct enum for NOT_SYNCED', () {
      const id = 'NOT_SYNCED';
      final result = FacialRecognitionStatusEnum.build(id);

      expect(result, FacialRecognitionStatusEnum.notSynced);
      expect(result.id, 'NOT_SYNCED');
      expect(result.value, 'Not synced');
    });

    test('should return internalException for unknown id', () {
      const id = 'UNKNOWN_ID';
      final result = FacialRecognitionStatusEnum.build(id);

      expect(result, FacialRecognitionStatusEnum.internalException);
      expect(result.id, 'INTERNAL_EXCEPTION');
      expect(result.value, 'Internal exception');
    });
  });
}