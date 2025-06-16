import '../../domain/input_models/dependent_dto_input_model.dart';

abstract class UpdateDependentsDatasource {
  Future<void> call({
    required DependentDtoInputModel dependentDtoInputModel,
  });
}
