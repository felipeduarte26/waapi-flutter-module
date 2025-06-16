import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_system/components/senior_bottom_sheet/senior_bottom_sheet_widget.dart';

import '../../../../../core/extension/media_query_extension.dart';
import '../../../domain/entities/social_space_entity.dart';
import '../../bloc/social_screen/social_screen_bloc.dart';
import '../social_create_post_widget.dart';

class SocialModal {
  static Future<void> createPostModal({
    required BuildContext context,
    required SocialScreenBloc socialScreenBloc,
    SocialSpaceEntity? spaceSelected,
  }) async {
    return SeniorBottomSheet.showBottomSheet(
      height: context.bottomSheetSize,
      padding: EdgeInsets.zero,
      enableDrag: true,
      context: context,
      content: [
        SocialCreatePostWidget(
          socialScreenBloc: socialScreenBloc,
          spaceSelected: spaceSelected,
        ),
      ],
      hasCloseButton: true,
      onTapCloseButton: () {
        Modular.to.pop();
      },
    );
  }
}
