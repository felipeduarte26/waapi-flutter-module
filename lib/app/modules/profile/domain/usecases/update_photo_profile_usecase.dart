import '../repositories/update_photo_profile_repository.dart';
import '../types/profile_domain_types.dart';

abstract class UpdatePhotoProfileUsecase {
  UpdatePhotoProfileUsecaseCallback call({
    required String userId,
    required String photoBase64,
    required String contentType,
  });
}

class UpdatePhotoProfileUsecaseImpl implements UpdatePhotoProfileUsecase {
  final UpdatePhotoProfileRepository _updatePhotoProfileRepository;

  const UpdatePhotoProfileUsecaseImpl({
    required UpdatePhotoProfileRepository updatePhotoProfileRepository,
  }) : _updatePhotoProfileRepository = updatePhotoProfileRepository;

  @override
  UpdatePhotoProfileUsecaseCallback call({
    required String userId,
    required String photoBase64,
    required String contentType,
  }) {
    return _updatePhotoProfileRepository.call(
      userId: userId,
      photoBase64: photoBase64,
      contentType: contentType,
    );
  }
}
