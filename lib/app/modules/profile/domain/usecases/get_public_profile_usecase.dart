import '../repositories/get_public_profile_repository.dart';
import '../types/profile_domain_types.dart';

abstract class GetPublicProfileUsecase {
  GetPublicProfileUsecaseCallback call({
    required String userName,
  });
}

class GetPublicProfileUsecaseImpl implements GetPublicProfileUsecase {
  final GetPublicProfileRepository _getPublicProfileRepository;

  const GetPublicProfileUsecaseImpl({
    required GetPublicProfileRepository getPublicProfileRepository,
  }) : _getPublicProfileRepository = getPublicProfileRepository;

  @override
  GetPublicProfileUsecaseCallback call({
    required String userName,
  }) {
    return _getPublicProfileRepository.call(
      userName: userName,
    );
  }
}
