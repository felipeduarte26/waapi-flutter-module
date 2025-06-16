import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

class ItemTextWidget extends StatelessWidget {
  final String? title;
  final String? content;

  const ItemTextWidget({super.key, this.title = '', this.content = ''});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SeniorText.small(
          color: SeniorColors.neutralColor500,
          darkColor: SeniorColors.grayscale30,
          title == null ? '' : title!,
        ),
        SeniorText.labelBold(
          color: SeniorColors.neutralColor800,
          content == null ? '' : content!,
          textProperties: const TextProperties(
            maxLines: 3,
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
