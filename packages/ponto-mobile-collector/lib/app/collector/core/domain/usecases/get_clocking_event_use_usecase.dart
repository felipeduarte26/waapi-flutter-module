import '../enums/clocking_event_use_type.dart';
import '../repositories/database/clocking_event_use_repository.dart';

abstract class GetClockingEventUseUsecase {
  Future<ClockingEventUseType> call(String use, String employeeId);
}

class GetClockingEventUseUsecaseImpl implements GetClockingEventUseUsecase {
  final ClockingEventUseRepository _clockingEventUseRepository;

  GetClockingEventUseUsecaseImpl({
    required ClockingEventUseRepository clockingEventUseRepository,
  }) : _clockingEventUseRepository = clockingEventUseRepository;

  @override
  Future<ClockingEventUseType> call(String use, String employeeId) async {
    var findAllByEmployeeId = await _clockingEventUseRepository
        .findAllByEmployeeId(employeeId: employeeId);

    return findAllByEmployeeId
        .where((element) => int.parse(element.code) == int.parse(use))
        .first
        .clockingEventUseType;
  }
}
