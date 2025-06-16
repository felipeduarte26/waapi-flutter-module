import '../repositories/get_dependents_repository.dart';
import '../types/profile_domain_types.dart';

abstract class GetDependentsUsecase {
  GetDependentsUsecaseCallback call({
    required String employeeId,
  });
}

class GetDependentsUsecaseImpl implements GetDependentsUsecase {
  final GetDependentsRepository _getDependentsRepository;

  const GetDependentsUsecaseImpl({
    required GetDependentsRepository getDependentsRepository,
  }) : _getDependentsRepository = getDependentsRepository;

  @override
  GetDependentsUsecaseCallback call({
    required String employeeId,
  }) {
    return _getDependentsRepository.call(
      employeeId: employeeId,
    );
  }
}
