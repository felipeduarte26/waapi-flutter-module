import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/tokens/senior_colors.dart';
import 'package:senior_design_tokens/tokens/senior_icon_size.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';

import '../../../../core/domain/services/navigator/navigator_service.dart';

enum FeedbackTypeEnum { error, alert, success }

class FeedbackScreen extends StatefulWidget {
  final FeedbackTypeEnum feedbackType;
  final String title;
  final String subtitle;
  final List<SeniorButton> buttons; // Updated to accept a list of buttons
  final NavigatorService navigatorService;
  final void Function()? onPressedClose;
  final String? buttonLabelAdditional;
  final Function()? onPressedAdditional;
  final bool canPop;

  const FeedbackScreen({
    super.key,
    required this.feedbackType,
    required this.title,
    required this.subtitle,
    required this.buttons, // Updated constructor
    required this.navigatorService,
    this.onPressedClose, 
    this.buttonLabelAdditional, 
    this.onPressedAdditional,
    this.canPop = false,
  });

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: widget.canPop,
      child: Scaffold(
        body: SeniorColorfulHeaderStructure(
          hideLeading: true,
          title: Container(),
          actions: [
            IconButton(
              onPressed: () {
                if (widget.onPressedClose != null) {
                  widget.onPressedClose!.call();
                } else {
                  widget.navigatorService.pop();
                }
              },
              icon: const Icon(
                FontAwesomeIcons.xmark,
                color: SeniorColors.pureWhite,
              ),
            ),
          ],
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  Padding(
                    padding: const EdgeInsets.only(
                      top: SeniorSpacing.medium,
                      left: SeniorSpacing.medium,
                      right: SeniorSpacing.medium,
                    ),
                    child: Column(
                      children: _buildButtons(),
                    ),
                  ),
                  if (widget.buttonLabelAdditional != null ||
                      widget.onPressedAdditional != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        top: SeniorSpacing.small,
                        left: SeniorSpacing.medium,
                        right: SeniorSpacing.medium,
                      ),
                      child: SeniorButton.primary(
                        fullWidth: true,
                        label: widget.buttonLabelAdditional!,
                        onPressed: widget.onPressedAdditional!,
                        outlined: true,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildButtons() {
    return widget.buttons
        .map((button) => Padding(
              padding: const EdgeInsets.only(
                top: SeniorSpacing.small,
                left: SeniorSpacing.medium,
                right: SeniorSpacing.medium,
              ),
              child: button,
            ),)
        .toList();
  }

  Widget _getIcon() {
    switch (widget.feedbackType) {
      case (FeedbackTypeEnum.error):
        return const Icon(
          FontAwesomeIcons.circleExclamation,
          color: SeniorColors.manchesterColorRed,
          size: SeniorIconSize.huge,
        );
      case (FeedbackTypeEnum.alert):
        return const Icon(
          FontAwesomeIcons.triangleExclamation,
          color: SeniorColors.manchesterColorOrange500,
          size: SeniorIconSize.huge,
        );
      case (FeedbackTypeEnum.success):
        return const Icon(
          FontAwesomeIcons.solidCircleCheck,
          color: SeniorColors.primaryColor500,
          size: SeniorIconSize.huge,
        );
    }
  }
}
