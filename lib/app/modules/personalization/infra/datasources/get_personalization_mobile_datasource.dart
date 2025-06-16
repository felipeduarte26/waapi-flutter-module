import '../models/personalization_mobile_model.dart';

abstract class GetPersonalizationMobileDatasource {
  Future<PersonalizationMobileModel> call();
}
