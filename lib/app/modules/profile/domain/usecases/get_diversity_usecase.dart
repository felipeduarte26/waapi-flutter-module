import '../repositories/get_diversity_repository.dart';
import '../types/profile_domain_types.dart';

abstract class GetDiversityUsecase {
  GetDiversityUsecaseCallback call({
    required String personId,
  });
}

class GetDiversityUsecaseImpl implements GetDiversityUsecase {
  final GetDiversityRepository _getDiversityRepository;

  const GetDiversityUsecaseImpl({
    required GetDiversityRepository getDiversityRepository,
  }) : _getDiversityRepository = getDiversityRepository;

  @override
  GetDiversityUsecaseCallback call({
    required String personId,
  }) {
    return _getDiversityRepository.call(
      personId: personId,
    );
  }
}
