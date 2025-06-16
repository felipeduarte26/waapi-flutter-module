import '../../../../core/services/open_external_url/open_external_url_service.dart';
import '../../infra/drivers/open_external_url_driver.dart';

class OpenExternalUrlDriverImpl implements OpenExternalUrlDriver {
  final OpenExternalUrlService _openExternalUrlService;

  const OpenExternalUrlDriverImpl({
    required OpenExternalUrlService openExternalUrlService,
  }) : _openExternalUrlService = openExternalUrlService;

  @override
  Future<bool> call({
    required String externalUrl,
  }) async {
    return _openExternalUrlService.openUrl(
      externalUrl: externalUrl,
    );
  }
}
