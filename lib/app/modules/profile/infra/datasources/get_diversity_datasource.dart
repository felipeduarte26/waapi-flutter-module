import '../models/diversity_model.dart';

abstract class GetDiversityDatasource {
  Future<DiversityModel?> call({
    required String personId,
  });
}
