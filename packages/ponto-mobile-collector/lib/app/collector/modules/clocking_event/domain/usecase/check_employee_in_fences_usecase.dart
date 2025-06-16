

import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import '../../../../../../ponto_mobile_collector.dart';
import '../../../../core/domain/input_model/fence_dto.dart';
import '../../../../core/external/mappers/fence_mapper.dart';
import '../util/iclocking_event_utill.dart';

abstract class ICheckEmployeeInFencesUsecase {
  /// Checks whether the employee is within the defined fences
  /// When there are no fences it becomes true
  bool call({
    List<FenceDto>? fences,
    required StateLocationEntity location,
    List<FenceDto>? fencesDto,
  });
}

class CheckEmployeeInFencesUsecase implements ICheckEmployeeInFencesUsecase {
  final ISessionService _sessionService;
  final clock.ICreateClockingEventService _createClockingEventService;
  final IClockingEventUtil _clockingEventUtil;
  CheckEmployeeInFencesUsecase({
    required ISessionService sessionService,
    required clock.ICreateClockingEventService createClockingEventService,
    required IClockingEventUtil clockingEventUtil,
  })  : _sessionService = sessionService,
        _createClockingEventService = createClockingEventService,
        _clockingEventUtil = clockingEventUtil;

  @override
  bool call({
    List<FenceDto>? fences,
    required StateLocationEntity location,
    List<FenceDto>? fencesDto,
  }) {
    List<FenceDto>? fences = getFences(fencesDto);

    List<clock.FenceDto>? fencesListClock =
        FenceMapper.fromCollectorDtoToClockList(fences);

    clock.FenceStatusEnum? status =
        _createClockingEventService.verifyFencesBounds(
      fences: fencesListClock,
      geolocation: _clockingEventUtil.convertToLocationDto(location: location),
    );

    if (status == null) {
      return true;
    } else {
      return status != clock.FenceStatusEnum.out;
    }
  }

  List<FenceDto>? getFences(
    List<FenceDto>? fencesDto,
  ) {
    if (fencesDto != null) {
      return fencesDto;
    } else {
      return _sessionService.getEmployee().fences;
    }
  }
}
