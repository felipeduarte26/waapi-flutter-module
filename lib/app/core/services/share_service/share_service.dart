import 'package:share_plus_platform_interface/share_plus_platform_interface.dart';

abstract class ShareService {
  Future<void> shareString({
    required String text,
  });

  Future<void> shareFiles({
    required List<XFile> files,
  });
}

class ShareServiceImpl implements ShareService {
  final SharePlatform _share;

  const ShareServiceImpl({
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
