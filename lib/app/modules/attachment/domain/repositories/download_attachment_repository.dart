import '../types/attachment_domain_types.dart';

abstract class DownloadAttachmentRepository {
  DownloadAttachmentUsecaseCallback call({
    required String urlAttachment,
  });
}
