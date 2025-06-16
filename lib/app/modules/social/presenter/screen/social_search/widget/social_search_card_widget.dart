import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

class SocialSearchCardWidget extends StatelessWidget {
  final String title;
  final String buttonText;
  final bool showButton;
  final Function() onButtonPressed;
  final Widget child;

  const SocialSearchCardWidget({
    Key? key,
    required this.title,
    required this.buttonText,
    required this.onButtonPressed,
    required this.child,
    this.showButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: SeniorText.bodyBold(
            title,
            textProperties: const TextProperties(
              textAlign: TextAlign.left,
            ),
          ),
        ),
        child,
        Visibility(
          visible: showButton,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: SeniorSpacing.normal,
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SeniorButton.ghost(
                    label: buttonText,
                    onPressed: onButtonPressed,
                    icon: FontAwesomeIcons.solidPlus,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
