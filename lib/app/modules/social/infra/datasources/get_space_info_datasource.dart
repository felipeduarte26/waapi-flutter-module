import '../models/social_space_model.dart';

abstract class GetSpaceInfoDatasource {
  Future<SocialSpaceModel> call({
    required String permaname,
  });
}
