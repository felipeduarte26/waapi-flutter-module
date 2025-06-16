import '../../../../core/services/internal_storage/internal_storage_service.dart';
import '../../enums/social_view_key_enum.dart';
import '../../infra/drivers/save_dont_show_shorten_link_driver.dart';

class SaveDontShowShortenLinkDriverImpl implements SaveDontShowShortenLinkDriver {
  final InternalStorageService _internalStorageService;

  const SaveDontShowShortenLinkDriverImpl({
    required InternalStorageService internalStorageService,
  }) : _internalStorageService = internalStorageService;

  @override
  Future<bool> call({
    required bool showMessageShortenLink,
    required SocialViewKeyEnum messageShortenLinkKey,
  }) {
    return _internalStorageService.setBool(
      messageShortenLinkKey.name,
      value: showMessageShortenLink,
    );
  }
}
