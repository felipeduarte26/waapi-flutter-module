import '../models/gender_identity_model.dart';

abstract class GetGenderIdentityDatasource {
  Future<List<GenderIdentityModel>> call();
}
