import '../models/ethnicity_model.dart';

abstract class SearchEthnicityDatasource {
  Future<List<EthnicityModel>> call({
    required String ethnicity,
  });
}
