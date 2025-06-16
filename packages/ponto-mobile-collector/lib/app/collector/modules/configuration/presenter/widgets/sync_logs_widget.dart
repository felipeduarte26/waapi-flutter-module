import 'package:flutter/material.dart';
import 'package:senior_design_system/components/senior_text/senior_text_widget.dart';
import 'package:senior_design_tokens/tokens/senior_colors.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';

class SyncLogsWidget extends StatelessWidget {
  final Function() onTap;

  final String text;
  final Widget iconWidget;

  const SyncLogsWidget({
    required this.onTap,
    required this.text,
    required this.iconWidget,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: SeniorSpacing.small,
        bottom: SeniorSpacing.small,
      ),
      child: InkWell(
        onTap: () async => await onTap(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            iconWidget,
            const SizedBox(
              width: SeniorSpacing.small,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SeniorText.body(
                    text,
                    color: SeniorColors.neutralColor800,
                    darkColor: SeniorColors.pureWhite,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
