import '../models/personalization_model.dart';

abstract class GetPersonalizationDatasource {
  Future<PersonalizationModel> call();
}
