import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:senior_design_system/components/senior_text/models/text_properties.dart';
import 'package:senior_design_system/components/senior_text/senior_text_widget.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../core/constants/assets_path.dart';
import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/widgets/waapi_colorful_header.dart';
import '../../../domain/entities/social_space_entity.dart';
import '../../widget/social_list_header_widget.dart';

class SocialPrivateSpaceScreen extends StatelessWidget {
  final SocialSpaceEntity space;
  const SocialPrivateSpaceScreen({required this.space, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WaapiColorfulHeader(
        title: SeniorText.label(
          context.translate.group,
          color: SeniorColors.pureWhite,
          darkColor: SeniorColors.grayscale5,
        ),
        body: Column(
          children: [
            SocialListHeaderWidget(
              name: space.name,
              memberCount: space.memberCount,
              administratedBy: space.owner?.name,
              spacePrivacy: space.privacy,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: SeniorSpacing.normal),
              child: Divider(
                color: SeniorColors.grayscale10,
                thickness: SeniorSpacing.xsmall,
                height: 0,
              ),
            ),
            const _PrivateSpaceStateWidget(),
          ],
        ),
      ),
    );
  }
}

class _PrivateSpaceStateWidget extends StatelessWidget {
  const _PrivateSpaceStateWidget();
  final imageHeight = 160.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: SeniorSpacing.big),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AssetsPath.privateSpaceState,
            height: imageHeight,
          ),
          const SizedBox(
            height: SeniorSpacing.small,
          ),
          SeniorText.h4(
            context.translate.privateGroupInfoTitle,
            textProperties: const TextProperties(
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: SeniorSpacing.xsmall,
            ),
            child: SeniorText.label(
              context.translate.privateGroupInfoDescription,
              color: SeniorColors.neutralColor500,
              textProperties: const TextProperties(
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
