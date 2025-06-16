import 'package:ponto_mobile_collector/app/collector/core/domain/entities/journey_entity.dart';

JourneyEntity journeyMock = JourneyEntity(
  id: '1',
  journeyNumber: 123123,
  overnightId: '134567',
  endDate: DateTime.now().add(const Duration(days: 1)),
  employeeId: '123',
  startDate: DateTime.now(),
);


JourneyEntity journeyMockss = JourneyEntity(
  id: '1',
  journeyNumber: 123123,
  overnightId: '134567',
  endDate: DateTime(2025, 2, 5 , 10, 00, 00),
  employeeId: '123',
  startDate:  DateTime(2025, 2, 4 , 10, 10, 10),
);
