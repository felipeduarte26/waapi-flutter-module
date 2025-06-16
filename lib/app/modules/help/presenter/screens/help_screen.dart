import 'package:flutter/material.dart';
import '../../../../core/environment/environment_variables.dart';
import '../../../../core/extension/translate_extension.dart';
import '../../../../core/widgets/waapi_colorful_header.dart';
import '../../../../core/widgets/web_view_widget.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HelpScreen> createState() {
    return _HelpScreenState();
  }
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WaapiColorfulHeader(
        titleLabel: context.translate.help,
        body: WebViewWidget(
          url: EnvironmentVariables.helpUrl,
          onLoadErrorMessage: context.translate.helpErrorMessage,
        ),
      ),
    );
  }
}
