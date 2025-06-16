import 'package:flutter/material.dart';

import '../../../../../core/environment/environment_variables.dart';
import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/widgets/waapi_colorful_header.dart';
import '../../../../../core/widgets/web_view_widget.dart';

class DocumentationMoodDiaryScreen extends StatefulWidget {
  const DocumentationMoodDiaryScreen({super.key});

  @override
  State<DocumentationMoodDiaryScreen> createState() => _DocumentationMoodDiaryScreenState();
}

class _DocumentationMoodDiaryScreenState extends State<DocumentationMoodDiaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WaapiColorfulHeader(
        titleLabel: context.translate.moodDiaryDocumentation,
        body: WebViewWidget(
          url: EnvironmentVariables.documentationMoodDiary,
          onLoadErrorMessage: context.translate.helpErrorMessage,
        ),
      ),
    );
  }
}
