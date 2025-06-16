import '../repositories/delete_attachment_repository.dart';
import '../types/attachment_domain_types.dart';

abstract class DeleteAttachmentUsecase {
  DeleteAttachmentUsecaseCallback call({
    required String idAttachment,
  });
}

class DeleteAttachmentUsecaseImpl implements DeleteAttachmentUsecase {
  final DeleteAttachmentRepository _deleteAttachmentRepository;

  const DeleteAttachmentUsecaseImpl({
    required DeleteAttachmentRepository deleteAttachmentRepository,
  }) : _deleteAttachmentRepository = deleteAttachmentRepository;

  @override
  DeleteAttachmentUsecaseCallback call({
    required String idAttachment,
  }) {
    return _deleteAttachmentRepository.call(
      idAttachment: idAttachment,
    );
  }
}
