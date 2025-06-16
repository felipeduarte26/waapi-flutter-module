import '../models/social_search_content_model.dart';

abstract class GetSocialSearchContentDatasource {
  Future<SocialSearchContentModel> call({
    required String query,
    required int from,
  });
}
