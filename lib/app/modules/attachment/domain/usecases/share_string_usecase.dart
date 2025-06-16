import '../repositories/share_string_repository.dart';
import '../types/attachment_domain_types.dart';

abstract class ShareStringUsecase {
  ShareStringUsecaseCallback call({
    required String stringToShare,
  });
}

class ShareStringUsecaseImpl implements ShareStringUsecase {
  final ShareStringRepository _shareStringRepository;

  const ShareStringUsecaseImpl({
    required ShareStringRepository shareStringRepository,
  }) : _shareStringRepository = shareStringRepository;

  @override
  ShareStringUsecaseCallback call({
    required String stringToShare,
  }) {
    return _shareStringRepository.call(
      stringToShare: stringToShare,
    );
  }
}
