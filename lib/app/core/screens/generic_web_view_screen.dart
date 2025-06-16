import 'package:flutter/material.dart';

import '../extension/translate_extension.dart';
import '../widgets/waapi_colorful_header.dart';
import '../widgets/web_view_widget.dart';

class GenericWebViewScreen extends StatefulWidget {
  const GenericWebViewScreen({
    super.key,
    required this.label,
    required this.url,
  });

  final String label;
  final String url;

  @override
  State<GenericWebViewScreen> createState() => _GenericWebViewScreenState();
}

class _GenericWebViewScreenState extends State<GenericWebViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WaapiColorfulHeader(
        titleLabel: widget.label,
        body: WebViewWidget(
          url: widget.url,
          onLoadErrorMessage: context.translate.genericErrorAndTryAgain,
          showWebViewNavigationBar: false,
        ),
      ),
    );
  }
}
