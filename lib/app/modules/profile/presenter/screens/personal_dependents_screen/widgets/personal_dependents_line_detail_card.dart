import 'package:flutter/material.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/widgets/document_item_widget.dart';

class PersonalDependentsLineDetailCard extends StatelessWidget {
  final String? leftTitle;
  final String? rightTitle;
  final String? leftDetail;
  final String? rightDetail;
  const PersonalDependentsLineDetailCard({
    Key? key,
    this.leftTitle,
    this.rightTitle,
    this.leftDetail,
    this.rightDetail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        (leftDetail != null && leftDetail!.isNotEmpty)
            ? Expanded(
                child: DocumentItemWidget(
                  padding: const EdgeInsets.only(
                    bottom: SeniorSpacing.xsmall,
                  ),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  title: leftTitle,
                  items: [
                    leftDetail!,
                  ],
                ),
              )
            : const SizedBox.shrink(),
        (rightDetail != null && rightDetail!.isNotEmpty)
            ? DocumentItemWidget(
                padding: const EdgeInsets.only(
                  bottom: SeniorSpacing.xsmall,
                ),
                crossAxisAlignment: leftDetail != null ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                title: rightTitle,
                items: [
                  rightDetail!,
                ],
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
