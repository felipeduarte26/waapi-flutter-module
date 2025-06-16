import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../generated/l10n/collector_localizations.dart';
import 'empty_state_widget.dart';

class ErrorStateWidget extends StatefulWidget {
  final String title;
  final String? subTitle;
  final VoidCallback onTapTryAgain;
  final String? titleButton;
  final String imagePath;
  final bool isTest;

  const ErrorStateWidget({
    super.key,
    required this.title,
    required this.onTapTryAgain,
    required this.imagePath,
    this.subTitle,
    this.titleButton,
    this.isTest = false,
  });

  @override
  ErrorStateWidgetState createState() {
    return ErrorStateWidgetState();
  }
}

class ErrorStateWidgetState extends State<ErrorStateWidget> {
  @override
  Widget build(BuildContext context) {
    return EmptyStateWidget(
      title: widget.title,
      subTitle: widget.subTitle,
      imagePath: widget.imagePath,
      isTest: widget.isTest,
      actions: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: SeniorSpacing.normal,
            left: SeniorSpacing.normal,
            right: SeniorSpacing.normal,
          ),
          child: SeniorButton(
            key: const Key('feedback-feedback_screen-bottom_sheet-button-try_again'),
            fullWidth: true,
            label: widget.titleButton ?? CollectorLocalizations.of(context).facialTryAgain,
            onPressed: widget.onTapTryAgain,
          ),
        ),
      ],
    );
  }
}
