import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';

import '../../../../core/constants/assets_path.dart';
import '../../../../core/extension/translate_extension.dart';
import '../../../../core/widgets/empty_state_widget.dart';

class SocialFeedEmptyStateWidget extends StatelessWidget {
  final bool showPublish;
  final Function()? onPublish;
  const SocialFeedEmptyStateWidget({this.showPublish = true, this.onPublish, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Provider.of<ThemeRepository>(context).theme.colorfulHeaderStructureTheme!.style!.bodyColor,
      body: EmptyStateWidget(
        actions: showPublish
            ? [
                Padding(
                  padding: const EdgeInsets.all(SeniorSpacing.normal),
                  child: SizedBox(
                    width: double.infinity,
                    child: SeniorButton(
                      label: context.translate.publish,
                      onPressed: onPublish ?? () {},
                      icon: FontAwesomeIcons.solidPenToSquare,
                    ),
                  ),
                ),
              ]
            : null,
        title: context.translate.socialPostEmptyTitle,
        imagePath: AssetsPath.speechBalloons,
        subTitle:
            showPublish ? context.translate.socialPostEmptyMessage : context.translate.socialProfilePostsEmptyMessage,
      ),
    );
  }
}
