import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/helper/icons_helper.dart';
import '../../domain/entities/hyperlink_entity.dart';
import '../../enums/hyperlink_type_enum.dart';
import 'hyperlink_list_item_widget.dart';

class HyperlinkItemCardWidget extends StatelessWidget {
  final HyperlinkEntity hyperlink;
  final Function()? onTap;
  final bool enabled = true;

  const HyperlinkItemCardWidget({
    super.key,
    required this.hyperlink,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);

    return Column(
      children: [
        HyperlinkListItemWidget(
          prefixIcon: getIcon(themeRepository: themeRepository),
          rightPadding: SeniorSpacing.normal,
          leftPadding: SeniorSpacing.normal,
          key: const Key(
            'hyperlink-hyperlink_item_card_widget-item_index',
          ),
          title: (hyperlink.label != null && hyperlink.label!.isEmpty) ||
                  hyperlink.label == null
              ? hyperlink.url
              : hyperlink.label!,
          onTap: onTap,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: SeniorSpacing.normal),
          child: Divider(
            height: 1,
            color: getDividerColor(isDark: themeRepository.isDarkTheme()),
          ),
        ),
      ],
    );
  }

  Widget? getIcon({required ThemeRepository themeRepository}) {
    if ((hyperlink.label != null && hyperlink.label!.isEmpty) ||
        hyperlink.label == null) {
      return const SeniorIcon(
        icon: FontAwesomeIcons.solidLink,
        size: SeniorIconSize.medium,
      );
    }

    if (hyperlink.iconUrl != null &&
        hyperlink.iconUrl!.isNotEmpty &&
        hyperlink.type == HyperlinkTypeEnum.report) {
      final proficiencyIconName = IconsHelper.parseProficiencyIconName(
          proficiencyIconName: hyperlink.iconUrl!);
      return proficiencyIconName != null
          ? CircleAvatar(
              backgroundColor:
                  getBackgoundColor(themeRepository: themeRepository),
              radius: SeniorSpacing.xmedium,
              child: SeniorIcon(
                icon: proficiencyIconName,
                size: SeniorIconSize.medium,
                style: SeniorIconStyle(
                  color: getIconColor(themeRepository: themeRepository),
                ),
              ),
            )
          : null;
    }

    if (hyperlink.iconUrl != null &&
        hyperlink.iconUrl!.isNotEmpty &&
        hyperlink.type == HyperlinkTypeEnum.otherLinks) {
      return SeniorProfilePicture(
        imageProvider: NetworkImage(hyperlink.iconUrl!),
        name: hyperlink.label ?? '',
        radius: SeniorSpacing.xmedium,
        style: SeniorProfilePictureStyle(
          backgroundColor: getBackgoundColor(themeRepository: themeRepository),
          textColor: getIconColor(themeRepository: themeRepository),
        ),
      );
    }

    if (hyperlink.attachment?.link != null || hyperlink.label != null) {
      return SeniorProfilePicture(
        imageProvider: hyperlink.attachment?.link != null
            ? CachedNetworkImageProvider(
                hyperlink.attachment!.link,
              )
            : null,
        name: hyperlink.label ?? '',
        radius: SeniorSpacing.xmedium,
        style: SeniorProfilePictureStyle(
          backgroundColor: getBackgoundColor(themeRepository: themeRepository),
          textColor: getIconColor(themeRepository: themeRepository),
        ),
      );
    }

    return null;
  }

  Color? getIconColor({required ThemeRepository themeRepository}) {
    return themeRepository.isDarkTheme()
        ? SeniorColors.primaryColor200
        : themeRepository.theme.primaryColor;
  }

  Color? getBackgoundColor({required ThemeRepository themeRepository}) {
    return themeRepository.isDarkTheme()
        ? SeniorColors.primaryColor800
        : themeRepository.isCustomTheme()
            ? SeniorColors.pureWhite
            : SeniorColors.primaryColor100;
  }

  Color? getDividerColor({required bool isDark}) {
    return isDark ? SeniorColors.grayscale60 : SeniorColors.grayscale30;
  }
}
