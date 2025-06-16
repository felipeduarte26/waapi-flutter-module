import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/generate_journey_id_usecase.dart';
import 'package:uuid/uuid.dart';

class MockGenerateJourneyIdUsecase extends Mock
    implements GenerateJourneyIdUsecase {}

void main() {
  group('GenerateJourneyIdUsecase', () {
    test('should return a valid UUID', () {
      final usecase = GenerateJourneyIdUsecase();

      final result = usecase.call();

      expect(result, isNotNull);
      expect(result, isA<String>());
      expect(Uuid.isValidUUID(fromString: result), isTrue);
    });
  });
}
