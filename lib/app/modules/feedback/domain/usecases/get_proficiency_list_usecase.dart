import '../repositories/get_proficiency_list_repository.dart';
import '../types/feedback_domain_types.dart';

abstract class GetProficiencyListUsecase {
  GetProficiencyListUsecaseCallback call();
}

class GetProficiencyListUsecaseImpl implements GetProficiencyListUsecase {
  final GetProficiencyListRepository _getProficiencyListRepository;

  const GetProficiencyListUsecaseImpl({
    required GetProficiencyListRepository getProficiencyListRepository,
  }) : _getProficiencyListRepository = getProficiencyListRepository;

  @override
  GetProficiencyListUsecaseCallback call() {
    return _getProficiencyListRepository.call();
  }
}
