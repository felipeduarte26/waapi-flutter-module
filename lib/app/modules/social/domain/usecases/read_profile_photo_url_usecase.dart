import '../repositories/read_profile_photo_url_repository.dart';
import '../types/social_domain_types.dart';

abstract class ReadProfilePhotoURLUsecase {
  ReadProfilePhotoURLUsecaseCallback call({required String userId});
}

class ReadProfilePhotoURLUsecaseImpl implements ReadProfilePhotoURLUsecase {
  final ReadProfilePhotoURLRepository _readProfilePhotoURLRepository;

  ReadProfilePhotoURLUsecaseImpl({
    required ReadProfilePhotoURLRepository readProfilePhotoURLRepository,
  }) : _readProfilePhotoURLRepository = readProfilePhotoURLRepository;

  @override
  ReadProfilePhotoURLUsecaseCallback call({required String userId}) {
    return _readProfilePhotoURLRepository.call(
      userId: userId,
    );
  }
}
