import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/tokens/senior_colors.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';

import '../../../../../../core/widgets/copy_button_icon_widget.dart';

class TitleCardWidget extends StatelessWidget {
  final IconData? leftIcon;
  final String cardTitle;
  final String? copyButtonText;
  final String? copyButtonMessageSuccess;
  final bool isCopyButtonVisible;
  final Widget? leftIconBuild;
  final TextStyle? seniorTypography;

  const TitleCardWidget({
    Key? key,
    this.leftIcon,
    required this.cardTitle,
    this.copyButtonText,
    this.copyButtonMessageSuccess,
    this.isCopyButtonVisible = true,
    this.leftIconBuild,
    this.seniorTypography,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        leftIcon != null
            ? SeniorIcon(
                icon: leftIcon!,
                size: SeniorSpacing.medium,
              )
            : leftIconBuild!,
        const SizedBox(
          width: SeniorSpacing.small,
        ),
        Expanded(
          child: SeniorText.body(
            cardTitle,
            color: SeniorColors.neutralColor800,
            darkColor: Provider.of<ThemeRepository>(context).theme.textTheme!.labelStyle!.color,
          ),
        ),
        isCopyButtonVisible
            ? CopyButtonIconWidget(
                stringCopy: copyButtonText == null ? '' : copyButtonText!,
                messageSuccess: copyButtonMessageSuccess!,
              )
            : const SizedBox(
                height: SeniorSpacing.huge,
              ),
      ],
    );
  }
}
