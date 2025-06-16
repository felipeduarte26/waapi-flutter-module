import 'package:mobile_authentication/mobile_authentication_service.dart'
    as auth;
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/clocking_event_use_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/clocking_event_use_dto.dart';

auth.ClockingEventUseDTO clockingEventUseDTOMock = auth.ClockingEventUseDTO(
  code: '1',
  description: 'Teste',
  employeeId: '1',
  clockingEventUseType: auth.ClockingEventUseType.clockingEvent,
);


ClockingEventUseDto clockingEventUseMockDto = ClockingEventUseDto(
  code: '1',
  description: 'Teste',
  employeeId: '1',
  clockingEventUseType: ClockingEventUseType.clockingEvent,
);
