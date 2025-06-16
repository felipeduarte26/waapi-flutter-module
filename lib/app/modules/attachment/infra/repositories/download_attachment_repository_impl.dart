import '../../../../core/types/either.dart';
import '../../domain/failures/attachment_failure.dart';
import '../../domain/repositories/download_attachment_repository.dart';
import '../../domain/types/attachment_domain_types.dart';
import '../datasources/download_attachment_datasource.dart';

class DownloadAttachmentRepositoryImpl implements DownloadAttachmentRepository {
  final DownloadAttachmentDatasource _downloadAttachmentDatasource;

  const DownloadAttachmentRepositoryImpl({
    required DownloadAttachmentDatasource downloadAttachmentDatasource,
  }) : _downloadAttachmentDatasource = downloadAttachmentDatasource;

  @override
  DownloadAttachmentUsecaseCallback call({
    required String urlAttachment,
  }) async {
    try {
      final listBytesImage = await _downloadAttachmentDatasource.call(
        urlAttachment: urlAttachment,
      );

      return right(listBytesImage);
    } catch (error) {
      return left(const AttachmentDatasourceFailure());
    }
  }
}
