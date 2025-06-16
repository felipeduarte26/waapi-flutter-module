import '../repositories/get_education_degree_repository.dart';
import '../types/profile_domain_types.dart';

abstract class GetEducationDegreeUsecase {
  GetEducationDegreeUsecaseCallback call();
}

class GetEducationDegreeUsecaseImpl implements GetEducationDegreeUsecase {
  final GetEducationDegreeRepository _getEducationDegreeRepository;

  const GetEducationDegreeUsecaseImpl({
    required GetEducationDegreeRepository getEducationDegreeRepository,
  }) : _getEducationDegreeRepository = getEducationDegreeRepository;

  @override
  GetEducationDegreeUsecaseCallback call() {
    return _getEducationDegreeRepository.call();
  }
}
