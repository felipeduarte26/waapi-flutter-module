import '../../../../core/types/either.dart';
import '../../domain/failures/attachment_failure.dart';
import '../../domain/repositories/delete_attachment_repository.dart';
import '../../domain/types/attachment_domain_types.dart';
import '../datasources/delete_attachment_datasource.dart';

class DeleteAttachmentRepositoryImpl implements DeleteAttachmentRepository {
  final DeleteAttachmentDatasource _deleteAttachmentDatasource;

  const DeleteAttachmentRepositoryImpl({
    required DeleteAttachmentDatasource deleteAttachmentDatasource,
  }) : _deleteAttachmentDatasource = deleteAttachmentDatasource;

  @override
  DeleteAttachmentUsecaseCallback call({
    required String idAttachment,
  }) async {
    try {
      await _deleteAttachmentDatasource.call(
        idAttachment: idAttachment,
      );

      return right(unit);
    } catch (error) {
      return left(const AttachmentDeleteFailure());
    }
  }
}
