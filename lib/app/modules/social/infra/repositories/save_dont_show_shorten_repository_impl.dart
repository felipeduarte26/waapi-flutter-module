import '../../../../core/types/either.dart';
import '../../domain/failures/social_failure.dart';
import '../../domain/repositories/save_dont_show_shorten_link_repository.dart';
import '../../domain/types/social_domain_types.dart';
import '../../enums/social_view_key_enum.dart';
import '../drivers/save_dont_show_shorten_link_driver.dart';

class SaveDontShowShortenRepositoryImpl implements SaveDontShowShortenLinkRepository {
  final SaveDontShowShortenLinkDriver _saveDontShowShortenLinkDriver;

  const SaveDontShowShortenRepositoryImpl({
    required SaveDontShowShortenLinkDriver saveDontShowShortenLinkDriver,
  }) : _saveDontShowShortenLinkDriver = saveDontShowShortenLinkDriver;

  @override
  SaveDontShowShortenLinkUsecaseCallback call({
    required SocialViewKeyEnum messageShortenLinkKey,
    required bool showMessageShortenLink,
  }) async {
    try {
      final isSaved = await _saveDontShowShortenLinkDriver.call(
        messageShortenLinkKey: messageShortenLinkKey,
        showMessageShortenLink: showMessageShortenLink,
      );

      if (!isSaved) {
        return left(SocialDriverFailure());
      }

      return right(unit);
    } catch (error) {
      return left(SocialDriverFailure());
    }
  }
}
