import '../models/happiness_index_group_model.dart';

abstract class RetrieveAllReasonsHappinessIndexDatasource {
  Future<List<HappinessIndexGroupModel>> call({
    required String language,
  });
}
