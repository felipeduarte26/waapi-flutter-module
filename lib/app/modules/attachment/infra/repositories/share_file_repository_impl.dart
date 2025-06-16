import '../../../../core/types/either.dart';
import '../../domain/failures/attachment_failure.dart';
import '../../domain/repositories/share_file_repository.dart';
import '../../domain/types/attachment_domain_types.dart';
import '../drivers/share_file_driver.dart';

class ShareFileRepositoryImpl implements ShareFileRepository {
  final ShareFileDriver _shareFileDatasource;

  const ShareFileRepositoryImpl({
    required ShareFileDriver shareFileDatasource,
  }) : _shareFileDatasource = shareFileDatasource;

  @override
  ShareFileUsecaseCallback call({
    required String fileToShare,
  }) async {
    try {
      await _shareFileDatasource.call(
        fileToShare: fileToShare,
      );

      return right(unit);
    } catch (error) {
      return left(const AttachmentDatasourceFailure());
    }
  }
}
