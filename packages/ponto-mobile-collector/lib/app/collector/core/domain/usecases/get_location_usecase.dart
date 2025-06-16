import '../../../../../ponto_mobile_collector.dart';

abstract class GetLocationUsecase {
  Future<StateLocationEntity?> call();
}

class GetLocationUsecaseImpl implements GetLocationUsecase {
  final IPlatformService _platformService;

  const GetLocationUsecaseImpl({
    required IPlatformService platformService,
  })  : _platformService = platformService;

  @override
  Future<StateLocationEntity?> call() async {
    return await _platformService.getLocation();
  }
}
