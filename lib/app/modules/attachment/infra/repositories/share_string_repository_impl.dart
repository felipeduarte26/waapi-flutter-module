import '../../../../core/types/either.dart';
import '../../domain/failures/attachment_failure.dart';
import '../../domain/repositories/share_string_repository.dart';
import '../../domain/types/attachment_domain_types.dart';
import '../drivers/share_string_driver.dart';

class ShareStringRepositoryImpl implements ShareStringRepository {
  final ShareStringDriver _shareStringDatasource;

  const ShareStringRepositoryImpl({
    required ShareStringDriver shareStringDatasource,
  }) : _shareStringDatasource = shareStringDatasource;

  @override
  ShareStringUsecaseCallback call({
    required String stringToShare,
  }) async {
    try {
      await _shareStringDatasource.call(
        stringToShare: stringToShare,
      );

      return right(unit);
    } catch (error) {
      return left(const AttachmentDatasourceFailure());
    }
  }
}
