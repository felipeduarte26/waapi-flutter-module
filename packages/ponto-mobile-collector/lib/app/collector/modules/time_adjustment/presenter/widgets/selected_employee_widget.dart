import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:senior_design_system/components/components.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../generated/l10n/collector_localizations.dart';

class SelectedEmployeeWidget extends StatelessWidget {
  final String name;
  final Function? onTap;
  final bool disabled;
  final bool canChange;

  const SelectedEmployeeWidget({
    super.key,
    required this.name,
    this.onTap,
    this.disabled = false,
    this.canChange = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: SeniorSpacing.small,
        vertical: SeniorSpacing.xsmall,
      ),
      child: SeniorCard(
        outlined: false,
        disabled: disabled,
        onTap: () {
          if (canChange) {
            onTap?.call();
          }
        },
        withElevation: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SeniorProfilePicture(
                  name: name,
                  radius: SeniorSpacing.xmedium,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: SeniorSpacing.small,
                    ),
                    child: SeniorText.small(
                      name,
                      textProperties: const TextProperties(
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: canChange,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: SeniorSpacing.xsmall,
                    ),
                    child: SeniorText.small(
                      CollectorLocalizations
                          .of(context)
                          .change,
                      color: SeniorColors.primaryColor500,
                      darkColor: SeniorColors.primaryColor500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
