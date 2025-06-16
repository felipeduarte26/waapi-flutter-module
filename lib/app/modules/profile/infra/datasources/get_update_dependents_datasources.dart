import '../models/dependent_model.dart';

abstract class GetUpdateDependentsDatasource {
  Future<DependentModel> call({
    required String requestUpdateId,
  });
}
