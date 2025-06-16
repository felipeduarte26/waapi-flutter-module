import '../types/profile_domain_types.dart';

abstract class UpdatePhotoProfileRepository {
  UpdatePhotoProfileUsecaseCallback call({
    required String userId,
    required String photoBase64,
    required String contentType,
  });
}
