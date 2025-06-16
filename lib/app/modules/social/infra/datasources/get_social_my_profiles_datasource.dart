import '../models/social_profile_model.dart';

abstract class GetSocialMyProfilesDatasource {
  Future<List<SocialProfileModel>> call();
}
