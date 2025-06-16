import '../types/social_domain_types.dart';

abstract class ReadProfilePhotoURLRepository {
  ReadProfilePhotoURLUsecaseCallback call({
    required String userId,
  });
}
