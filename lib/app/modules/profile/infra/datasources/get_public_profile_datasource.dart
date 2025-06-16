import '../models/public_profile_model.dart';

abstract class GetPublicProfileDatasource {
  Future<PublicProfileModel> call({
    required String userName,
  });
}
