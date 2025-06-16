import 'dart:developer';

import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;

import '../../../../../../ponto_mobile_collector.dart';
import '../../../../core/domain/input_model/clocking_event_dto.dart';
import '../../../../core/external/mappers/clocking_event_mapper.dart';
abstract class IRegisterClockingEventUsecase {
  Future<ClockingEventDto> call({
    required ClockingEventRegisterEntity clockingEventRegisterEntity,
  });
}

class RegisterClockingEventUsecase implements IRegisterClockingEventUsecase {
  final IRegisterClockingEventService _registerClockingEventService;

  const RegisterClockingEventUsecase({
    required IRegisterClockingEventService registerClockingEventService,
  }) : _registerClockingEventService = registerClockingEventService;

  @override
  Future<ClockingEventDto> call({
    required ClockingEventRegisterEntity clockingEventRegisterEntity,
  }) async {
    DateTime initDateTime = DateTime.now();

    clock.ImportClockingEventDto import =
        await _registerClockingEventService.register(
      clockingEventRegisterEntity: clockingEventRegisterEntity,
    );

    ClockingEventDto clockingEventDto = ClockingEventMapper.fromClockToCollectorDto(import);

    Duration totalDuration = DateTime.now().difference(initDateTime);
    log('RegisterClockingEventUsecase: #ProcessingTime: ${totalDuration.toString()}');
    return clockingEventDto;
  }
}
