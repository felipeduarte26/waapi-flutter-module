import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/tokens/senior_colors.dart';

import '../extension/translate_extension.dart';
import '../helper/clipboard_helper.dart';

class CopyButtonIconWidget extends StatelessWidget {
  final String stringCopy;
  final String messageSuccess;
  const CopyButtonIconWidget({
    Key? key,
    required this.stringCopy,
    required this.messageSuccess,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SeniorIconButton(
      disabled: false,
      icon: FontAwesomeIcons.solidCopy,
      onTap: () async {
        if (stringCopy.isNotEmpty) {
          ClipboardHelper.copy(
            value: stringCopy,
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SeniorSnackBar.success(
              message: messageSuccess,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SeniorSnackBar.error(
              message: context.translate.couldNotCopyTheText,
            ),
          );
        }
      },
      size: SeniorIconButtonSize.big,
      type: SeniorIconButtonType.ghost,
      outlined: false,
      style: SeniorIconButtonStyle(
        buttonColor: Colors.transparent,
        borderColor: Colors.transparent,
        iconColor: Provider.of<ThemeRepository>(context).isDarkTheme()
            ? SeniorColors.pureWhite
            : SeniorColors.secondaryColor600,
        disabledBorderColor: Colors.transparent,
        disabledIconColor: SeniorColors.neutralColor300,
      ),
    );
  }
}
