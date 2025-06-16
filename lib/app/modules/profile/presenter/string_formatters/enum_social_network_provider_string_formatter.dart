import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../enums/social_network_provider_enum.dart';

abstract class EnumSocialNetworkProviderStringFormatter {
  static String getStringSocialNetwork({
    required SocialNetworkProviderEnum socialNetworkProviderEnum,
    required AppLocalizations appLocalizations,
  }) {
    switch (socialNetworkProviderEnum) {
      case SocialNetworkProviderEnum.googleplus:
        return 'Google+';
      case SocialNetworkProviderEnum.facebook:
        return 'Facebook';
      case SocialNetworkProviderEnum.twitter:
        return 'Twitter';
      case SocialNetworkProviderEnum.linkedin:
        return 'LinkedIn';
      case SocialNetworkProviderEnum.instagram:
        return 'Instagram';
      case SocialNetworkProviderEnum.flickr:
        return 'Flickr';
      case SocialNetworkProviderEnum.lastfm:
        return 'Last.FM';
      case SocialNetworkProviderEnum.soundcloud:
        return 'SoundCloud';
      case SocialNetworkProviderEnum.deviantart:
        return 'DevianArt';
      case SocialNetworkProviderEnum.youtube:
        return 'YouTube';
      case SocialNetworkProviderEnum.github:
        return 'Github';
      case SocialNetworkProviderEnum.skype:
        return 'Skype';
      case SocialNetworkProviderEnum.bitbucket:
        return 'Bitbucket';
      case SocialNetworkProviderEnum.whatsapp:
        return 'WhatsApp';
      case SocialNetworkProviderEnum.deezer:
        return 'Deezer';
      case SocialNetworkProviderEnum.spotify:
        return 'Spotify';
      case SocialNetworkProviderEnum.rdio:
        return 'Rdio';
      case SocialNetworkProviderEnum.tumblr:
        return 'Tumblr';
      case SocialNetworkProviderEnum.other:
        return appLocalizations.other;
    }
  }
}
