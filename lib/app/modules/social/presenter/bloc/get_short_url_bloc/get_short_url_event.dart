import 'package:equatable/equatable.dart';

import '../../../enums/social_view_key_enum.dart';

abstract class GetShortUrlEvent extends Equatable {}

class GetShortUrl extends GetShortUrlEvent {
  final List<String> listUrl;

  GetShortUrl({
    required this.listUrl,
  });

  @override
  List<Object> get props => [
        listUrl,
      ];
}

class SaveDontShowMessageShortenLinkEvent extends GetShortUrlEvent {
  final SocialViewKeyEnum socialViewKeyEnum;
  final bool showMessageShortenLink;

  SaveDontShowMessageShortenLinkEvent({
    required this.socialViewKeyEnum,
    required this.showMessageShortenLink,
  });

  @override
  List<Object> get props {
    return [
      showMessageShortenLink,
    ];
  }
}

class ShowMessageShortenLinksEvent extends GetShortUrlEvent {
  final SocialViewKeyEnum socialViewKeyEnum;
  final bool showMessageShortenLink;

  ShowMessageShortenLinksEvent({
    required this.socialViewKeyEnum,
    required this.showMessageShortenLink,
  });

  @override
  List<Object> get props {
    return [
      socialViewKeyEnum,
    ];
  }
}
