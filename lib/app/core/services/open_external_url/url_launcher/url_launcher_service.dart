import 'package:url_launcher/url_launcher.dart';

import '../open_external_url_service.dart';

class UrlLauncherService implements OpenExternalUrlService {
  @override
  Future<bool> openUrl({
    required String externalUrl,
  }) async {
    if (await canLaunchUrl(Uri.parse(externalUrl))) {
      return await launchUrl(Uri.parse(externalUrl));
    }

    return Future.value(false);
  }
}
