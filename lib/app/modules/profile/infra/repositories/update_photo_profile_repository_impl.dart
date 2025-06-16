import '../../../../core/types/either.dart';
import '../../domain/failures/profile_failure.dart';
import '../../domain/repositories/update_photo_profile_repository.dart';
import '../../domain/types/profile_domain_types.dart';
import '../datasources/update_photo_profile_datasource.dart';

class UpdatePhotoProfileRepositoryImpl implements UpdatePhotoProfileRepository {
  final UpdatePhotoProfileDatasource _updatePhotoProfileDatasource;

  const UpdatePhotoProfileRepositoryImpl({
    required UpdatePhotoProfileDatasource updatePhotoProfileDatasource,
  }) : _updatePhotoProfileDatasource = updatePhotoProfileDatasource;

  @override
  UpdatePhotoProfileUsecaseCallback call({
    required String userId,
    required String photoBase64,
    required String contentType,
  }) async {
    try {
      final newUrlPhotoProfile = await _updatePhotoProfileDatasource.call(
        contentType: contentType,
        photoBase64: photoBase64,
        userId: userId,
      );
      return right(newUrlPhotoProfile);
    } catch (error) {
      return left(const ProfileDatasourceFailure());
    }
  }
}
