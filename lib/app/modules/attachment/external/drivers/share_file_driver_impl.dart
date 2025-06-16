import 'package:cross_file/cross_file.dart';

import '../../../../core/services/share_service/share_service.dart';
import '../../infra/drivers/share_file_driver.dart';

class ShareFileDriverImpl implements ShareFileDriver {
  final ShareService _shareService;

  const ShareFileDriverImpl({
    required ShareService shareService,
  }) : _shareService = shareService;

  @override
  Future<void> call({
    required String fileToShare,
  }) async {
    await _shareService.shareFiles(
      files: [
        XFile(fileToShare),
      ],
    );
  }
}
