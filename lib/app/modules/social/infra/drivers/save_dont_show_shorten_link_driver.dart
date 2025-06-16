import '../../enums/social_view_key_enum.dart';

abstract class SaveDontShowShortenLinkDriver {
  Future<bool> call({
    required bool showMessageShortenLink,
    required SocialViewKeyEnum messageShortenLinkKey,
  });
}
