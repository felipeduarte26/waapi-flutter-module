import '../../../../core/types/either.dart';
import '../../domain/failures/social_failure.dart';
import '../../domain/repositories/read_profile_photo_url_repository.dart';
import '../../domain/types/social_domain_types.dart';
import '../datasources/read_profile_photo_url_datasource.dart';

class ReadProfilePhotoURLRepositoryImpl implements ReadProfilePhotoURLRepository {
  final ReadProfilePhotoURLDatasource _readProfilePhotoURLDatasource;

  const ReadProfilePhotoURLRepositoryImpl({
    required ReadProfilePhotoURLDatasource readProfilePhotoURLDatasource,
  }) : _readProfilePhotoURLDatasource = readProfilePhotoURLDatasource;

  @override
  ReadProfilePhotoURLUsecaseCallback call({
    required String userId,
  }) async {
    try {
      final url = await _readProfilePhotoURLDatasource.call(
        userId: userId,
      );

      return right(url);
    } catch (error) {
      return left(SocialDatasourceFailure());
    }
  }
}
