import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

import 'webview_controller_mock.dart';
import 'webview_cookie_manager_mock.dart';
import 'webview_navigation_delegate_mock.dart';
import 'webview_widget_mock.dart';

class WebViewPlatformMock extends WebViewPlatform {
  @override
  PlatformWebViewController createPlatformWebViewController(
    PlatformWebViewControllerCreationParams params,
  ) {
    return WebViewControllerMock(params);
  }

  @override
  PlatformWebViewWidget createPlatformWebViewWidget(
    PlatformWebViewWidgetCreationParams params,
  ) {
    return WebViewWidgetMock(params);
  }

  @override
  PlatformWebViewCookieManager createPlatformCookieManager(
    PlatformWebViewCookieManagerCreationParams params,
  ) {
    return WebviewCookieManagerMock(params);
  }

  @override
  PlatformNavigationDelegate createPlatformNavigationDelegate(
    PlatformNavigationDelegateCreationParams params,
  ) {
    return WebviewNavigationDelegateMock(params);
  }
}
