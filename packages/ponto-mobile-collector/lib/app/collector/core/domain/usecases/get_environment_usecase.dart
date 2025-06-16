import '../../../../../ponto_mobile_collector.dart';

abstract class GetEnvironmentUsecase {
  Future<EnvironmentEnum> call();
}

class GetEnvironmentUsecaseImpl implements GetEnvironmentUsecase {
  final IEnvironmentService _environmentService;

  const GetEnvironmentUsecaseImpl({
    required IEnvironmentService environmentService,
  }) : _environmentService = environmentService;

  @override
  Future<EnvironmentEnum> call() async {
    return _environmentService.environment();
  }
}
