import '../../enums/social_view_key_enum.dart';

abstract class ShowMessageShortenLinkDriver {
  Future<bool> call({
    required SocialViewKeyEnum showMessageShortenLinkKey,
  });
}
