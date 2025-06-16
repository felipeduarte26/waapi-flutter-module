import '../models/disability_model.dart';

abstract class GetDisabilityDatasource {
  Future<List<DisabilityModel>> call();
}
