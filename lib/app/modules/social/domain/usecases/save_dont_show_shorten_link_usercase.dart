import '../../enums/social_view_key_enum.dart';
import '../repositories/save_dont_show_shorten_link_repository.dart';
import '../types/social_domain_types.dart';

abstract class SaveDontShowShortenLinkUsercase {
  SaveDontShowShortenLinkUsecaseCallback call({
    required bool showMessageShortenLink,
    required SocialViewKeyEnum messageShortenLinkKey,
  });
}

class SaveDontShowShortenLinkUsercaseImpl implements SaveDontShowShortenLinkUsercase {
  final SaveDontShowShortenLinkRepository _saveDontShowShortenLinkRepository;

  const SaveDontShowShortenLinkUsercaseImpl({
    required SaveDontShowShortenLinkRepository saveDontShowShortenLinkRepository,
  }) : _saveDontShowShortenLinkRepository = saveDontShowShortenLinkRepository;

  @override
  SaveDontShowShortenLinkUsecaseCallback call({
    required bool showMessageShortenLink,
    required SocialViewKeyEnum messageShortenLinkKey,
  }) {
    return _saveDontShowShortenLinkRepository.call(
      messageShortenLinkKey: messageShortenLinkKey,
      showMessageShortenLink: showMessageShortenLink,
    );
  }
}
