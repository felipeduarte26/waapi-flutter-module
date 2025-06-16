import '../repositories/get_profile_repository.dart';
import '../types/profile_domain_types.dart';

abstract class GetProfileUsecase {
  GetProfileUsecaseCallback call({
    required String employeeId,
    required String personId,
  });
}

class GetProfileUsecaseImpl implements GetProfileUsecase {
  final GetProfileRepository _getProfileRepository;

  const GetProfileUsecaseImpl({
    required GetProfileRepository getProfileRepository,
  }) : _getProfileRepository = getProfileRepository;

  @override
  GetProfileUsecaseCallback call({
    required String employeeId,
    required String personId,
  }) {
    return _getProfileRepository.call(
      employeeId: employeeId,
      personId: personId,
    );
  }
}
