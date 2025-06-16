import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_system/senior_design_system.dart';

import '../../../../core/extension/media_query_extension.dart';
import 'social_post_likes_bottom_sheet_content_widget.dart';

class SocialPostLikesBottomSheetViewWidget {
  static void showLikes({
    required BuildContext context,
    required String title,
    required String postId,
  }) {
    SeniorBottomSheet.showBottomSheet(
      title: title,
      height: context.bottomSheetSize * 0.8,
      context: context,
      content: [
        Expanded(
          child: SocialPostLikesBottomSheetContentWidget(
            postId: postId,
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
