import '../input_models/dependent_dto_input_model.dart';
import '../repositories/update_dependents_repository.dart';
import '../types/profile_domain_types.dart';

abstract class UpdateDependentsUsecase {
  UpdateDependentsUsecaseCallback call({
    required DependentDtoInputModel sendDependentDtoInputModel,
  });
}

class UpdateDependentsUsecaseImpl implements UpdateDependentsUsecase {
  final UpdateDependentsRepository _dependentsRepository;

  const UpdateDependentsUsecaseImpl({
    required UpdateDependentsRepository updateDependentsRepository,
  }) : _dependentsRepository = updateDependentsRepository;

  @override
  UpdateDependentsUsecaseCallback call({
    required DependentDtoInputModel sendDependentDtoInputModel,
  }) {
    return _dependentsRepository.call(
      dependentDtoInputModel: sendDependentDtoInputModel,
    );
  }
}
