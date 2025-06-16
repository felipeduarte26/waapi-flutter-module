import '../models/profile_model.dart';

abstract class GetProfileDatasource {
  Future<ProfileModel> call({
    required String employeeId,
  });
}
