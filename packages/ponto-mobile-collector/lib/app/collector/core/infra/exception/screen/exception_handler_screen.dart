import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/components/components.dart';
import 'package:senior_design_tokens/tokens/senior_colors.dart';
import 'package:senior_design_tokens/tokens/senior_icon_size.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';

enum ExceptionTypeEnum { error, alert }

class ExceptionHandlerScreen extends StatefulWidget {
  final ExceptionTypeEnum feedbackType;
  final String title;
  final String subtitle;
  final String actionButtonLabel;
  final String retryButtonLabel;
  final Function() onAction;
  final Function() onRetry;
  final bool showRetryButton;

  const ExceptionHandlerScreen({
    super.key,
    required this.feedbackType,
    required this.title,
    required this.subtitle,
    required this.retryButtonLabel,
    required this.actionButtonLabel,
    required this.onAction,
    required this.onRetry,
    this.showRetryButton = true,
  });

  @override
  State<ExceptionHandlerScreen> createState() => _ExceptionHandlerScreenState();
}

class _ExceptionHandlerScreenState extends State<ExceptionHandlerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SeniorColorfulHeaderStructure(
        hideLeading: true,
        title: Container(),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _getIcon(),
              Padding(
                padding: const EdgeInsets.only(
                  top: SeniorSpacing.medium,
                  left: SeniorSpacing.xmedium,
                  right: SeniorSpacing.xmedium,
                ),
                child: SeniorText.h4(
                  widget.title,
                  textProperties: const TextProperties(
                    textAlign: TextAlign.center,
                  ),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: SeniorSpacing.xsmall,
                  left: SeniorSpacing.xmedium,
                  right: SeniorSpacing.xmedium,
                ),
                child: SeniorText.label(
                  widget.subtitle,
                  textProperties: const TextProperties(
                    textAlign: TextAlign.center,
                  ),
                  style: const TextStyle(
                    height: 1.5,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Visibility(
                visible: widget.showRetryButton,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: SeniorSpacing.medium,
                    left: SeniorSpacing.medium,
                    right: SeniorSpacing.medium,
                  ),
                  child: SeniorButton(
                    fullWidth: true,
                    label: widget.retryButtonLabel,
                    onPressed: widget.onRetry,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: SeniorSpacing.medium,
                  left: SeniorSpacing.medium,
                  right: SeniorSpacing.medium,
                ),
                child: SeniorButton(
                  fullWidth: true,
                  outlined: true,
                  label: widget.actionButtonLabel,
                  onPressed: widget.onAction,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getIcon() {
    switch (widget.feedbackType) {
      case (ExceptionTypeEnum.error):
        return const Icon(
          FontAwesomeIcons.circleExclamation,
          color: SeniorColors.manchesterColorRed,
          size: SeniorIconSize.huge,
        );
      case (ExceptionTypeEnum.alert):
        return const Icon(
          FontAwesomeIcons.triangleExclamation,
          color: SeniorColors.manchesterColorOrange500,
          size: SeniorIconSize.huge,
        );
    }
  }
}
