import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/overnight_entity.dart';

import 'employee_dto_mock.dart';

OvernightEntity overnightEntityMock = OvernightEntity(
  id: '1',
  date: DateTime.now(),
  employee: employeeDtoMock,
  locationStatus: LocationStatusEnum.location,
  type: 'type',
);
