import '../../../../core/services/internal_storage/internal_storage_service.dart';
import '../../enums/social_view_key_enum.dart';
import '../../infra/drivers/show_message_shorten_link_driver.dart';

class ShowMessageShortenLinkDriverImpl implements ShowMessageShortenLinkDriver {
  final InternalStorageService _internalStorageService;

  const ShowMessageShortenLinkDriverImpl({
    required InternalStorageService internalStorageService,
  }) : _internalStorageService = internalStorageService;

  @override
  Future<bool> call({
    required SocialViewKeyEnum showMessageShortenLinkKey,
  }) async {
    return _internalStorageService.getBool(
          showMessageShortenLinkKey.toString(),
        ) ??
        false;
  }
}
