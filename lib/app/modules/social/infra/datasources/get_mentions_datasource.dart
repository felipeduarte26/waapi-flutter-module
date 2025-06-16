import '../models/social_profile_model.dart';

abstract class GetMentionsDatasource {
  Future<List<SocialProfileModel>> call({
    required String query,
  });
}
