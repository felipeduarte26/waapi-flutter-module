import 'package:package_info_plus/package_info_plus.dart';

import '../../infra/drivers/get_current_version_driver.dart';

class GetCurrentVersionDriverImpl implements GetCurrentVersionDriver {
  @override
  Future<String> call() async {
    final packageInfo = await PackageInfo.fromPlatform();

    final projectVersion = packageInfo.version;
    final projectCode = packageInfo.buildNumber;

    return '$projectVersion ($projectCode)';
  }
}
