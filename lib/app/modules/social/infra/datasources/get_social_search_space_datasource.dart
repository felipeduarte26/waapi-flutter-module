import '../models/social_space_model.dart';

abstract class GetSocialSearchSpaceDatasource {
  Future<List<SocialSpaceModel>> call({
    required String query,
  });
}
