import '../models/social_profile_model.dart';

abstract class GetSocialProfileDatasource {
  Future<SocialProfileModel> call({
    required String permaname,
  });
}
