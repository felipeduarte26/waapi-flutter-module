import '../../../../core/types/either.dart';
import '../../domain/failures/social_failure.dart';
import '../../domain/repositories/show_message_shorten_link_repository.dart';
import '../../domain/types/social_domain_types.dart';
import '../../enums/social_view_key_enum.dart';
import '../drivers/show_message_shorten_link_driver.dart';

class ShowMessageShortenLinkRepositoryImpl implements ShowMessageShortenLinkRepository {
  final ShowMessageShortenLinkDriver _showMessageShortenLinkDriver;

  const ShowMessageShortenLinkRepositoryImpl({
    required ShowMessageShortenLinkDriver showMessageShortenLinkDriver,
  }) : _showMessageShortenLinkDriver = showMessageShortenLinkDriver;

  @override
  ShowMessageShortenLinkUsecaseCallback call({
    required SocialViewKeyEnum showMessageShortenLinkKey,
  }) async {
    try {
      final isShow = await _showMessageShortenLinkDriver.call(
        showMessageShortenLinkKey: showMessageShortenLinkKey,
      );

      return right(isShow);
    } catch (error) {
      return left(SocialDriverFailure());
    }
  }
}
