import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/clocking_event_use_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/database/clocking_event_use_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_clocking_event_use_usecase.dart';

import '../../../../../mocks/clocking_event_use_entity_mock.dart';

class MockClockingEventUseRepository extends Mock
    implements ClockingEventUseRepository {}

void main() {
  late MockClockingEventUseRepository mockClockingEventUseRepository;
  late GetClockingEventUseUsecase getClockingEventUseUsecase;
  setUp(() {
    mockClockingEventUseRepository = MockClockingEventUseRepository();
    getClockingEventUseUsecase = GetClockingEventUseUsecaseImpl(
      clockingEventUseRepository: mockClockingEventUseRepository,
    );
  });
  group('GetClockingEventUseUsecaseImpl', () {
    test('should return ClockingEventUseType when a matching use is found',
        () async {
      const employeeId = 'employee123';
      const use = '1';
      const clockingEventUseType = ClockingEventUseType.clockingEvent;
      when(
        () => mockClockingEventUseRepository.findAllByEmployeeId(
          employeeId: employeeId,
        ),
      ).thenAnswer((_) async => [clockingEventUseEntityMock]);

      final result = await getClockingEventUseUsecase.call(use, employeeId);

      expect(result, clockingEventUseType);
      verify(
        () => mockClockingEventUseRepository.findAllByEmployeeId(
          employeeId: employeeId,
        ),
      );
    });

    test('should throw an exception when no matching use is found', () async {
      const employeeId = 'employee123';
      const use = '2';
      when(
        () => mockClockingEventUseRepository.findAllByEmployeeId(
          employeeId: employeeId,
        ),
      ).thenAnswer((_) async => []);

      expect(
        () => getClockingEventUseUsecase.call(use, employeeId),
        throwsStateError,
      );
    });
  });
}
