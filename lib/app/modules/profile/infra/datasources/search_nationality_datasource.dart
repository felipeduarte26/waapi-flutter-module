import '../models/nationality_model.dart';

abstract class SearchNationalityDatasource {
  Future<List<NationalityModel>> call({
    required String nationality,
  });
}
