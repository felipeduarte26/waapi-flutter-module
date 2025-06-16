import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';

import '../../../../../../core/extension/translate_extension.dart';
import '../../../../domain/entities/social_space_entity.dart';
import 'social_search_space_list_widget.dart';

class SocialSearchSpaceWidget extends StatelessWidget {
  final List<SocialSpaceEntity> spaces;
  final int? maxLeanSpace;
  const SocialSearchSpaceWidget({
    required this.spaces,
    this.maxLeanSpace,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: SeniorSpacing.normal,
        left: SeniorSpacing.normal,
        right: SeniorSpacing.normal,
        bottom: SeniorSpacing.normal,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SeniorText.body(
            context.translate.groups,
            textProperties: const TextProperties(
              textAlign: TextAlign.left,
            ),
          ),
          Expanded(
            child: SocialSearchSpaceListWidget(
              maxLeanSpace: maxLeanSpace,
              spaces: spaces,
            ),
          ),
        ],
      ),
    );
  }
}
