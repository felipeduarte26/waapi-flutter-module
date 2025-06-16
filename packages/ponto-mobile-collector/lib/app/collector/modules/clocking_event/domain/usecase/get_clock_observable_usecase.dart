import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;

abstract class IGetClockObservableUsecase {
  clock.Observable call();
}

class GetClockObservableUsecase implements IGetClockObservableUsecase {
  final clock.IInternalClockService _internalClockService;

  const GetClockObservableUsecase({
    required clock.IInternalClockService internalClockService,
  }) : _internalClockService = internalClockService;

  @override
  clock.Observable call() {
    return _internalClockService.getObservable();
  }
}
