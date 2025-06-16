import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/tokens/senior_colors.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';

import '../helper/string_helper.dart';

class WarningWidget extends StatelessWidget {
  final String message;
  final Color messageColor;
  final IconData icon;
  final Color iconColor;

  const WarningWidget({
    Key? key,
    required this.message,
    this.icon = FontAwesomeIcons.solidCircleInfo,
    this.iconColor = SeniorColors.manchesterColorBlue400,
    this.messageColor = SeniorColors.neutralColor600,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: SeniorSpacing.normal,
        right: SeniorSpacing.normal,
      ),
      child: Row(
        children: [
          SeniorIcon(
            icon: icon,
            size: SeniorSpacing.xmedium,
            style: SeniorIconStyle(
              color: iconColor,
            ),
          ),
          const SizedBox(
            width: SeniorSpacing.small,
          ),
          Expanded(
            child: SeniorText.body(
              StringHelper.parseHtml(message),
              color: messageColor,
            ),
          ),
        ],
      ),
    );
  }
}
