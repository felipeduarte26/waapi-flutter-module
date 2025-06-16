
import '../../../../../ponto_mobile_collector.dart';
import '../../domain/repositories/get_environment_repository.dart';

class GetEnvironmentRepositoryImpl implements GetEnvironmentRepository {
  final IEnvironmentService environmentService;

  const GetEnvironmentRepositoryImpl({
    required this.environmentService,
  });

  @override
  Future<EnvironmentEnum> call() async {
    return environmentService.environment();
  }
}
