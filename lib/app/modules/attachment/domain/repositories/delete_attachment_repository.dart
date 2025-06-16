import '../types/attachment_domain_types.dart';

abstract class DeleteAttachmentRepository {
  DeleteAttachmentUsecaseCallback call({
    required String idAttachment,
  });
}
