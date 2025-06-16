import '../repositories/get_current_version_repository.dart';
import '../types/settings_domain_types.dart';

abstract class GetCurrentVersionUsecase {
  GetCurrentVersionUsecaseCallback call();
}

class GetCurrentVersionUsecaseImpl implements GetCurrentVersionUsecase {
  final GetCurrentVersionRepository _getCurrentVersionRepository;

  const GetCurrentVersionUsecaseImpl({
    required GetCurrentVersionRepository getCurrentVersionRepository,
  }) : _getCurrentVersionRepository = getCurrentVersionRepository;

  @override
  GetCurrentVersionUsecaseCallback call() {
    return _getCurrentVersionRepository.call();
  }
}
