import '../models/social_profile_model.dart';

abstract class GetSocialCurrentProfileDatasource {
  Future<SocialProfileModel> call();
}
