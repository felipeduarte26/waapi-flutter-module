import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import './senior_drawer_style.dart';
import '../../components/senior_profile_picture/senior_profile_picture.dart';
import '../../repositories/theme_repository.dart';
import '../../theme/senior_theme_data.dart';

class SeniorDrawer extends StatelessWidget {
  /// Creates an SDS Drawer component.
  ///
  /// The [items] parameter is required.
  const SeniorDrawer({
    Key? key,
    this.footerText,
    required this.items,
    this.profilePicture,
    this.profileSubtitle,
    this.profileTitle,
    this.style,
    this.svgLogoPath,
  }) : super(key: key);

  /// The text displayed in the footer of the drawer.
  final String? footerText;

  /// The list of items in the drawer. Represent the routes to which the user can be redirected.
  final List<SeniorDrawerItem> items;

  /// The profile picture of the user that appears over the list of items.
  final SeniorProfilePicture? profilePicture;

  /// A subtitle that appears next to the user's profile picture.
  final String? profileSubtitle;

  /// A title that appears next to the user's profile picture.
  final String? profileTitle;

  /// The style definitions for the component.
  /// Allows you to configure:
  /// [SeniorDrawerStyle.backgroundColor] the background color of the drawer.
  /// [SeniorDrawerStyle.backIconColor] the color of the drawer back icon.
  /// [SeniorDrawerStyle.boldItemColor] the color of bold type items.
  /// [SeniorDrawerStyle.emphasisItemColor] the color of emphasis-type items.
  /// [SeniorDrawerStyle.footerTextColor] the color of the text in the footer.
  /// [SeniorDrawerStyle.lineColor] the color of the line that separates the profile area and the items list.
  /// [SeniorDrawerStyle.neutralItemColor] the color of neutral-type items.
  /// [SeniorDrawerStyle.profileSubtitleColor] the profile subtitle color.
  /// [SeniorDrawerStyle.profileTitleColor] the profile title color.
  final SeniorDrawerStyle? style;

  /// The svg path of the logo that will be displayed at the top of the drawer.
  /// The file must have the svg extension.
  /// If this parameter is not informed, it will not be displayed immediately.
  final String? svgLogoPath;

  Widget _buildProfile(SeniorThemeData theme) {
    final line = Container(
      height: 1.0,
      width: double.infinity,
      color: style?.lineColor ??
          theme.drawerTheme?.style?.lineColor ??
          SeniorColors.grayscale20,
    );

    final titleColor = style?.profileTitleColor ??
        theme.drawerTheme?.style?.profileTitleColor ??
        SeniorColors.grayscale90;

    final subtitleColor = style?.profileSubtitleColor ??
        theme.drawerTheme?.style?.profileSubtitleColor ??
        SeniorColors.grayscale60;

    return profilePicture == null || profileTitle == null
        ? const SizedBox.shrink()
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SeniorSpacing.medium,
                  vertical: SeniorSpacing.small,
                ),
                child: Row(
                  children: [
                    profilePicture!,
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: SeniorSpacing.small),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profileTitle!,
                            style: SeniorTypography.label(color: titleColor),
                          ),
                          profileSubtitle != null
                              ? Text(
                                  profileSubtitle!,
                                  style: SeniorTypography.small(
                                      color: subtitleColor),
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              line,
            ],
          );
  }

  Widget _buildDrawerHeader(
    BuildContext context,
    SeniorThemeData theme,
  ) {
    return Container(
      padding: const EdgeInsets.only(top: SeniorSpacing.medium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: SeniorSpacing.small),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: SeniorSpacing.small),
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Padding(
                      padding: const EdgeInsets.all(SeniorSpacing.small),
                      child: Icon(
                        FontAwesomeIcons.chevronLeft,
                        color: style?.backIconColor ??
                            theme.drawerTheme?.style?.backIconColor ??
                            SeniorColors.pureBlack,
                        size: SeniorIconSize.small,
                      ),
                    ),
                  ),
                ),
                svgLogoPath != null
                    ? SvgPicture.asset(
                        svgLogoPath!,
                        height: 40.0,
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
          _buildProfile(theme),
        ],
      ),
    );
  }

  Widget _buildItem(
    SeniorDrawerItem item,
    BuildContext context,
    SeniorThemeData theme,
  ) {
    final Color itemColor;
    final Widget itemTitle;

    switch (item.type) {
      case DrawerItemType.emphasis:
        itemColor = style?.emphasisItemColor ??
            theme.drawerTheme?.style?.emphasisItemColor ??
            SeniorColors.primaryColor;
        itemTitle = Text(
          item.title,
          style: SeniorTypography.label(color: itemColor),
        );
        break;
      case DrawerItemType.bold:
        itemColor = style?.boldItemColor ??
            theme.drawerTheme?.style?.boldItemColor ??
            SeniorColors.grayscale90;
        itemTitle = Text(
          item.title,
          style: SeniorTypography.small(color: itemColor),
        );
        break;
      case DrawerItemType.neutral:
        itemColor = style?.neutralItemColor ??
            theme.drawerTheme?.style?.neutralItemColor ??
            SeniorColors.grayscale90;
        itemTitle = Text(
          item.title,
          style: SeniorTypography.label(color: itemColor),
        );
        break;
    }

    return ListTile(
      title: Row(
        children: [
          item.icon != null
              ? Padding(
                  padding: const EdgeInsets.only(right: SeniorSpacing.small),
                  child: Icon(
                    item.icon,
                    color: itemColor,
                    size: SeniorIconSize.small,
                  ),
                )
              : const SizedBox.shrink(),
          itemTitle,
        ],
      ),
      onTap: () {
        item.onTap();
        Navigator.pop(context);
      },
    );
  }

  Widget _buildDrawerFooter(SeniorThemeData theme) {
    final textColor = style?.footerTextColor ??
        theme.drawerTheme?.style?.footerTextColor ??
        SeniorColors.grayscale50;

    if (footerText == null) {
      return const SizedBox.shrink();
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: SeniorSpacing.small),
        child: Center(
          child: Text(
            footerText!,
            style: SeniorTypography.small(color: textColor),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    final list = items.map((item) => _buildItem(item, context, theme)).toList();
    return Container(
      decoration: BoxDecoration(
        color: style?.backgroundColor ??
            theme.drawerTheme?.style?.backgroundColor ??
            SeniorColors.pureWhite,
      ),
      width: MediaQuery.of(context).size.width,
      child: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: ListView(
          children: [
            _buildDrawerHeader(context, theme),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: SeniorSpacing.medium),
              child: Column(
                children: list,
              ),
            ),
            _buildDrawerFooter(theme),
          ],
        ),
      ),
    );
  }
}

class SeniorDrawerItem {
  /// The information needed to create an item from the drawer.
  ///
  /// The [onTap] and [title] parameters are required.
  const SeniorDrawerItem({
    this.icon,
    required this.onTap,
    required this.title,
    this.type = DrawerItemType.neutral,
  });

  /// An icon that will appear next to the item's title.
  final IconData? icon;

  /// Callback function that will be executed when the item is tapped.
  final VoidCallback onTap;

  /// The item's title.
  final String title;

  /// The item type. It can be [DrawerItemType.emphasis], [DrawerItemType.bold] and [DrawerItemType.neutral].
  final DrawerItemType type;
}

/// The possible types for the items in the drawer. It can be [DrawerItemType.emphasis], [DrawerItemType.bold] and
/// [DrawerItemType.neutral].
enum DrawerItemType {
  emphasis,
  bold,
  neutral,
}
