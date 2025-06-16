import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/extension/translate_extension.dart';
import '../../enums/social_space_privacy_enum.dart';

class SocialListHeaderWidget extends StatelessWidget {
  final String? avatarUrl;
  final String name;
  final SocialSpacePrivacyEnum? spacePrivacy;
  final int? memberCount;
  final String? administratedBy;
  final bool isCorporateProfile;

  const SocialListHeaderWidget({
    required this.name,
    super.key,
    this.avatarUrl,
    this.spacePrivacy,
    this.memberCount,
    this.administratedBy,
    this.isCorporateProfile = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: SeniorSpacing.normal,
            bottom: SeniorSpacing.normal,
          ),
          child: SeniorProfilePicture(
            name: name,
            imageProvider: (avatarUrl != null && avatarUrl != '') ? CachedNetworkImageProvider(avatarUrl!) : null,
            radius: 35,
          ),
        ),
        SeniorText.labelBold(name),
        if (isCorporateProfile) SeniorText.body(context.translate.corporateProfile),
        if (spacePrivacy != null) _SpacePrivacyHeader(spacePrivacy: spacePrivacy!),
        if (memberCount != null) SeniorText.body('$memberCount ${context.translate.participants}'),
        if (administratedBy != null) SeniorText.body('${context.translate.managedBy} @$administratedBy'),
      ],
    );
  }
}

class _SpacePrivacyHeader extends StatelessWidget {
  final SocialSpacePrivacyEnum spacePrivacy;

  const _SpacePrivacyHeader({
    required this.spacePrivacy,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: SeniorSpacing.xxsmall),
          child: SeniorIcon(
            icon: spacePrivacy == SocialSpacePrivacyEnum.public
                ? FontAwesomeIcons.solidUsers
                : FontAwesomeIcons.solidLock,
            size: SeniorIconSize.xsmall,
            style: const SeniorIconStyle(
              color: SeniorColors.grayscale60,
            ),
          ),
        ),
        SeniorText.body(
          spacePrivacy == SocialSpacePrivacyEnum.public
              ? context.translate.publicGroup
              : context.translate.privateGroup,
        ),
      ],
    );
  }
}
