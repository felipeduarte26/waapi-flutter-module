import 'package:flutter/material.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';

import '../../../../domain/entities/social_space_entity.dart';
import '../../../../domain/extensions/social_search_extension.dart';
import 'social_space_item_widget.dart';

class SocialSearchSpaceListWidget extends StatelessWidget {
  final int? maxLeanSpace;
  final List<SocialSpaceEntity> spaces;
  const SocialSearchSpaceListWidget({
    required this.spaces,
    this.maxLeanSpace,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: maxLeanSpace == null ? SeniorSpacing.small : 0,
        right: maxLeanSpace == null ? SeniorSpacing.small : 0,
        bottom: maxLeanSpace == null ? SeniorSpacing.normal : 0,
      ),
      child: ListView.separated(
        padding: EdgeInsets.only(
          top: maxLeanSpace == null ? SeniorSpacing.normal : 0,
        ),
        physics: maxLeanSpace != null ? const NeverScrollableScrollPhysics() : null,
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: SeniorSpacing.normal,
          );
        },
        shrinkWrap: true,
        itemCount: spaces.length.getMaxItemCount(maxLeanSpace),
        itemBuilder: (context, index) {
          return SocialSpaceItemWidget(
            space: spaces[index],
          );
        },
      ),
    );
  }
}
