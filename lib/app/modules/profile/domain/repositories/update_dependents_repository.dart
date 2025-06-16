import '../input_models/dependent_dto_input_model.dart';
import '../types/profile_domain_types.dart';

abstract class UpdateDependentsRepository {
  UpdateDependentsUsecaseCallback call({
    required DependentDtoInputModel dependentDtoInputModel,
  });
}
