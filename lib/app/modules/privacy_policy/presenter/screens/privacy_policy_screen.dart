import 'package:flutter/material.dart';

import '../../../../core/environment/environment_variables.dart';
import '../../../../core/extension/translate_extension.dart';
import '../../../../core/widgets/waapi_colorful_header.dart';
import '../../../../core/widgets/web_view_widget.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PrivacyPolicyScreen> createState() {
    return _PrivacyPolicyScreenState();
  }
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WaapiColorfulHeader(
        titleLabel: context.translate.privacyPolicy,
        body: WebViewWidget(
          url: EnvironmentVariables.privacyPolicyUrl,
          onLoadErrorMessage: context.translate.privacyPolicyErrorMessage,
        ),
      ),
    );
  }
}
