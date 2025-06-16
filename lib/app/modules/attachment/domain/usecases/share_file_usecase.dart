import '../repositories/share_file_repository.dart';
import '../types/attachment_domain_types.dart';

abstract class ShareFileUsecase {
  ShareFileUsecaseCallback call({
    required String fileToShare,
  });
}

class ShareFileUsecaseImpl implements ShareFileUsecase {
  final ShareFileRepository _shareFileRepository;

  const ShareFileUsecaseImpl({
    required ShareFileRepository shareFileRepository,
  }) : _shareFileRepository = shareFileRepository;

  @override
  ShareFileUsecaseCallback call({
    required String fileToShare,
  }) {
    return _shareFileRepository.call(
      fileToShare: fileToShare,
    );
  }
}
