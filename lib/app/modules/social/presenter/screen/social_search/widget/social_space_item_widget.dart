import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../routes/social_routers.dart';
import '../../../../domain/entities/social_space_entity.dart';
import '../../../../enums/social_space_membership_enum.dart';
import '../../../../enums/social_space_privacy_enum.dart';
import '../../../bloc/social_space_feed/social_space_feed_bloc.dart';

class SocialSpaceItemWidget extends StatelessWidget {
  final SocialSpaceEntity space;
  const SocialSpaceItemWidget({
    required this.space,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (space.privacy == SocialSpacePrivacyEnum.public || space.isMember == SocialSpaceMembershipEnum.member) {
          Modular.to.pushNamed(
            SocialRouters.socialSpaceInitialRoute,
            arguments: {
              'permaname': space.permaname,
              'socialSpaceFeedBloc': Modular.get<SocialSpaceFeedBloc>(),
            },
          );
          return;
        }

        Modular.to.pushNamed(
          SocialRouters.socialPrivateSpaceInitialRoute,
          arguments: {
            'space': space,
          },
        );
      },
      child: Row(
        children: [
          SeniorProfilePicture(
            radius: SeniorCircularElements.small,
            name: space.name,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: SeniorSpacing.small,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SeniorText.label(
                    space.name,
                    textProperties: const TextProperties(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: [
                      if (space.privacy == SocialSpacePrivacyEnum.private)
                        const Padding(
                          padding: EdgeInsets.only(right: SeniorSpacing.xxsmall),
                          child: SeniorIcon(
                            icon: FontAwesomeIcons.solidLock,
                            size: SeniorIconSize.xsmall,
                            style: SeniorIconStyle(
                              color: SeniorColors.grayscale60,
                            ),
                          ),
                        ),
                      Expanded(
                        child: SeniorText.small(
                          '${context.translate.managedBy} @${space.owner?.name ?? ''}',
                          textProperties: const TextProperties(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SeniorIcon(
            icon: FontAwesomeIcons.chevronRight,
            size: SeniorIconSize.small,
          ),
        ],
      ),
    );
  }
}
