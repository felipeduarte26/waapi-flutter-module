import '../../enums/social_view_key_enum.dart';
import '../repositories/show_message_shorten_link_repository.dart';
import '../types/social_domain_types.dart';

abstract class ShowMessageShortenLinkUsecase {
  ShowMessageShortenLinkUsecaseCallback call({
    required SocialViewKeyEnum showMessageShortenLinkKey,
    required bool showMessageShortenLink,
  });
}

class ShowMessageShortenLinkUsecaseImpl implements ShowMessageShortenLinkUsecase {
  final ShowMessageShortenLinkRepository _showMessageShortenLinkRepository;

  const ShowMessageShortenLinkUsecaseImpl({
    required ShowMessageShortenLinkRepository showMessageShortenLinkRepository,
  }) : _showMessageShortenLinkRepository = showMessageShortenLinkRepository;

  @override
  ShowMessageShortenLinkUsecaseCallback call({
    required SocialViewKeyEnum showMessageShortenLinkKey,
    required bool showMessageShortenLink,
  }) {
    return _showMessageShortenLinkRepository.call(
      showMessageShortenLinkKey: showMessageShortenLinkKey,
    );
  }
}
