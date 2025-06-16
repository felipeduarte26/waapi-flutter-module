import '../repositories/download_attachment_repository.dart';
import '../types/attachment_domain_types.dart';

abstract class DownloadAttachmentUsecase {
  DownloadAttachmentUsecaseCallback call({
    required String urlAttachment,
  });
}

class DownloadAttachmentUsecaseImpl implements DownloadAttachmentUsecase {
  final DownloadAttachmentRepository _downloadAttachmentRepository;

  const DownloadAttachmentUsecaseImpl({
    required DownloadAttachmentRepository downloadAttachmentRepository,
  }) : _downloadAttachmentRepository = downloadAttachmentRepository;

  @override
  DownloadAttachmentUsecaseCallback call({
    required String urlAttachment,
  }) {
    return _downloadAttachmentRepository.call(
      urlAttachment: urlAttachment,
    );
  }
}
