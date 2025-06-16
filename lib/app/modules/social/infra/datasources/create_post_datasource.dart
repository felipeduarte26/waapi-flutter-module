import '../../domain/intput_models/social_create_post_input_model.dart';
import '../models/social_post_model.dart';

abstract class CreatePostDatasource {
  Future<SocialPostModel> call({
    required SocialCreatePostInputModel socialCreatePostIntputModel,
  });
}
