import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

class WebviewCookieManagerMock extends PlatformWebViewCookieManager {
  WebviewCookieManagerMock(super.params) : super.implementation();

  @override
  Future<bool> clearCookies() async {
    return true;
  }
}
