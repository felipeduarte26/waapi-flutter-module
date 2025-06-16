import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_system/senior_design_system.dart';

import '../../../../core/extension/media_query_extension.dart';
import '../../domain/entities/social_profile_entity.dart';
import 'social_comment_likes_bottom_sheet_content_widget.dart';

class SocialCommentLikesBottomSheetViewWidget {
  static void showLikes({
    required BuildContext context,
    required String title,
    required List<SocialProfileEntity> profilesThatLiked,
  }) {
    SeniorBottomSheet.showBottomSheet(
      title: title,
      height: context.bottomSheetSize * 0.6,
      context: context,
      content: [
        Expanded(
          child: SocialCommentLikesBottomSheetContentWidget(
            profilesThatLiked: profilesThatLiked,
          ),
        ),
      ],
      hasCloseButton: true,
      onTapCloseButton: () {
        Modular.to.pop();
      },
    );
  }
}
