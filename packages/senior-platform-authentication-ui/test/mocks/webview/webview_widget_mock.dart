import 'package:flutter/material.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

class WebViewWidgetMock extends PlatformWebViewWidget {
  WebViewWidgetMock(super.params) : super.implementation();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
