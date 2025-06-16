import '../repositories/get_gender_identity_repository.dart';
import '../types/profile_domain_types.dart';

abstract class GetGenderIdentityUsecase {
  GetGenderIdentityUsecaseCallback call();
}

class GetGenderIdentityUsecaseImpl implements GetGenderIdentityUsecase {
  final GetGenderIdentityRepository _getGenderIdentityRepository;

  const GetGenderIdentityUsecaseImpl({
    required GetGenderIdentityRepository getGenderIdentityRepository,
  }) : _getGenderIdentityRepository = getGenderIdentityRepository;

  @override
  GetGenderIdentityUsecaseCallback call() {
    return _getGenderIdentityRepository.call();
  }
}
