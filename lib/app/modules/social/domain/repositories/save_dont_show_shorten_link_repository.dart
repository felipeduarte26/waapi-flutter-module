import '../../enums/social_view_key_enum.dart';
import '../types/social_domain_types.dart';

abstract class SaveDontShowShortenLinkRepository {
  SaveDontShowShortenLinkUsecaseCallback call({
    required SocialViewKeyEnum messageShortenLinkKey,
    required bool showMessageShortenLink,
  });
}
