import 'package:flutter/material.dart';

import '../../../../../core/environment/environment_variables.dart';
import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/widgets/waapi_colorful_header.dart';
import '../../../../../core/widgets/web_view_widget.dart';

class DocumentationWaapiLiteScreen extends StatelessWidget {
  const DocumentationWaapiLiteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WaapiColorfulHeader(
        titleLabel: context.translate.waapiLiteDocumentation,
        body: WebViewWidget(
          url: EnvironmentVariables.documentationWaapiLite,
          onLoadErrorMessage: context.translate.helpErrorMessage,
        ),
      ),
    );
  }
}
