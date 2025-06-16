import '../../../../core/services/share_service/share_service.dart';
import '../../infra/drivers/share_string_driver.dart';

class ShareStringDriverImpl implements ShareStringDriver {
  final ShareService _shareService;

  const ShareStringDriverImpl({
    required ShareService shareService,
  }) : _shareService = shareService;

  @override
  Future<void> call({
    required String stringToShare,
  }) async {
    await _shareService.shareString(
      text: stringToShare,
    );
  }
}
