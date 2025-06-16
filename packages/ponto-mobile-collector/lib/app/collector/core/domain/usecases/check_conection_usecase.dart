import '../../../../../ponto_mobile_collector.dart';

abstract class IHasConnectivityUsecase {
  Future<bool> call();
}

class HasConnectivityUsecase implements IHasConnectivityUsecase {
  final IPlatformService _platformService;

  const HasConnectivityUsecase({
    required IPlatformService platformService,
  }) : _platformService = platformService;

  @override
  Future<bool> call() async {
    return await _platformService.hasConnectivity();
  }
}
