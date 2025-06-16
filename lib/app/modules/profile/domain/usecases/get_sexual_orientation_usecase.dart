import '../repositories/get_sexual_orientation_repository.dart';
import '../types/profile_domain_types.dart';

abstract class GetSexualOrientationUsecase {
  GetSexualOrientationUsecaseCallback call();
}

class GetSexualOrientationUsecaseImpl implements GetSexualOrientationUsecase {
  final GetSexualOrientationRepository _getSexualOrientationRepository;

  const GetSexualOrientationUsecaseImpl({
    required GetSexualOrientationRepository getSexualOrientationRepository,
  }) : _getSexualOrientationRepository = getSexualOrientationRepository;

  @override
  GetSexualOrientationUsecaseCallback call() {
    return _getSexualOrientationRepository.call();
  }
}
