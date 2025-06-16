import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/work_indicator_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/services/work_indicator_service_impl.dart';

void main() {
  late WorkIndicatorServiceImpl workIndicatorService;

  setUp(() {
    workIndicatorService = WorkIndicatorServiceImpl();
  });

  group('WorkIndicatorServiceImpl', () {
    test('should add a work indicator', () {
      const workIndicatorType = WorkIndicatorType.faceRecognitionInitialize;

      final result = workIndicatorService.addWorkIndicator(
        workIndicatorType: workIndicatorType,
      );

      expect(result, isTrue);
      expect(workIndicatorService.isWorkInProgress, isTrue);
    });

    test('should not add a duplicate work indicator', () {
      const workIndicatorType = WorkIndicatorType.faceRecognitionInitialize;

      workIndicatorService.addWorkIndicator(
        workIndicatorType: workIndicatorType,
      );

      final result = workIndicatorService.addWorkIndicator(
        workIndicatorType: workIndicatorType,
      );

      expect(result, isTrue);
      expect(workIndicatorService.isWorkInProgress, isTrue);
    });

    test('should remove a work indicator', () {
      const workIndicatorType = WorkIndicatorType.faceRecognitionInitialize;

      workIndicatorService.addWorkIndicator(
        workIndicatorType: workIndicatorType,
      );

      final result = workIndicatorService.removeWorkIndicator(
        workIndicatorType: workIndicatorType,
      );

      expect(result, isFalse);
      expect(workIndicatorService.isWorkInProgress, isFalse);
    });

    test('should not remove a non-existent work indicator', () {
      const workIndicatorType = WorkIndicatorType.faceRecognitionInitialize;

      final result = workIndicatorService.removeWorkIndicator(
        workIndicatorType: workIndicatorType,
      );

      expect(result, isFalse);
      expect(workIndicatorService.isWorkInProgress, isFalse);
      workIndicatorService.dispose();
    });

    test('should emit stream events when adding and removing work indicators',
        () async {
      const workIndicatorType = WorkIndicatorType.faceRecognitionInitialize;
      final stream = workIndicatorService.stream;

      expectLater(stream, emitsInOrder([true, false]));

      workIndicatorService.addWorkIndicator(
        workIndicatorType: workIndicatorType,
      );
      workIndicatorService.removeWorkIndicator(
        workIndicatorType: workIndicatorType,
      );
    });
  });
}
