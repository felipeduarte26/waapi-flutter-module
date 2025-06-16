import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;

abstract class IGetClockDateTimeUsecase {
  DateTime call();
}

class GetClockDateTimeUsecase implements IGetClockDateTimeUsecase {
  final clock.IInternalClockService _internalClockService;

  const GetClockDateTimeUsecase({
    required clock.IInternalClockService internalClockService,
  }) : _internalClockService = internalClockService;

  @override
  DateTime call() {
    return _internalClockService.getClockDateTime();
  }
}
