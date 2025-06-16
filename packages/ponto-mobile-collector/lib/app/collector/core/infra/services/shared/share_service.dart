import 'package:share_plus_platform_interface/share_plus_platform_interface.dart';

import '../../../../../../ponto_mobile_collector.dart';



class ShareService implements IShareService {
  final SharePlatform _share;

  const ShareService({
    required SharePlatform sharePlatform,
  }) : _share = sharePlatform;

  @override
  Future<void> shareFiles({
    required List<XFile> files,
  }) {
    return _share.shareXFiles(files);
  }

  @override
  Future<void> shareString({
    required String text,
  }) {
    return _share.share(text);
  }
}
