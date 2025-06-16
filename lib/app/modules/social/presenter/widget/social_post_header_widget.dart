import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/extension/translate_extension.dart';
import '../../../../core/helper/date_time_helper.dart';
import '../../../../core/helper/locale_helper.dart';
import '../../../../core/helper/string_helper.dart';
import '../../../../routes/routes.dart';
import '../../domain/entities/social_post_entity.dart';
import '../../domain/entities/social_profile_entity.dart';
import '../bloc/social_space_feed/social_space_feed_bloc.dart';

class SocialPostHeaderWidget extends StatelessWidget {
  final SocialPostEntity socialPostEntity;

  const SocialPostHeaderWidget({
    super.key,
    required this.socialPostEntity,
  });

  void _onTapProfile({required SocialProfileEntity author}) {
    Modular.to.pushNamed(
      SocialRouters.socialProfileInitialRoute,
      arguments: {
        'permaname': author.permaname,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkColor = Provider.of<ThemeRepository>(context).isDarkTheme();
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: SeniorSpacing.small,
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              _onTapProfile(
                author: socialPostEntity.author,
              );
            },
            child: SeniorProfilePicture(
              radius: SeniorCircularElements.small,
              imageProvider: (socialPostEntity.author.avatarUrl != null && socialPostEntity.author.avatarUrl != '')
                  ? CachedNetworkImageProvider(socialPostEntity.author.avatarUrl!)
                  : null,
              name: socialPostEntity.author.name,
            ),
          ),
          const SizedBox(
            width: SeniorSpacing.small,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  children: [
                    InkWell(
                      onTap: () {
                        _onTapProfile(
                          author: socialPostEntity.author,
                        );
                      },
                      child: SeniorText.labelBold(
                        textProperties: const TextProperties(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        socialPostEntity.author.name,
                        darkColor: isDarkColor ? SeniorColors.grayscale30 : SeniorColors.grayscale90,
                      ),
                    ),
                    const SizedBox(
                      width: SeniorSpacing.xxsmall,
                    ),
                    Visibility(
                      visible: socialPostEntity.isAuthor,
                      child: SeniorText.small(
                        '(${context.translate.you})',
                        darkColor: SeniorColors.grayscale50,
                      ),
                    ),
                    const SizedBox(
                      width: SeniorSpacing.xxsmall,
                    ),
                    Visibility(
                      visible: socialPostEntity.isFixed,
                      child: SeniorIcon(
                        icon: FontAwesomeIcons.solidThumbtack,
                        style: SeniorIconStyle(
                          color: isDarkColor ? SeniorColors.grayscale5 : SeniorColors.grayscale60,
                        ),
                        size: SeniorSpacing.normal,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Visibility(
                      visible: socialPostEntity.space != null,
                      child: SeniorText.small(
                        '${context.translate.em} ',
                        color: SeniorColors.grayscale70,
                        darkColor: SeniorColors.grayscale20,
                      ),
                    ),
                    Visibility(
                      visible: socialPostEntity.space != null,
                      child: Flexible(
                        child: InkWell(
                          onTap: () {
                            Modular.to.pushNamed(
                              SocialRouters.socialSpaceInitialRoute,
                              arguments: {
                                'permaname': socialPostEntity.space!.permaname,
                                'socialSpaceFeedBloc': Modular.get<SocialSpaceFeedBloc>(),
                              },
                            );
                          },
                          child: SeniorText.smallBold(
                            socialPostEntity.space?.name ?? '',
                            color: SeniorColors.grayscale80,
                            darkColor: SeniorColors.grayscale30,
                            textProperties: const TextProperties(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: socialPostEntity.space != null,
                      child: SeniorText.small(
                        ' ${StringHelper.bulletPoint()} ',
                        color: SeniorColors.grayscale60,
                        darkColor: SeniorColors.grayscale20,
                      ),
                    ),
                    SeniorText.small(
                      DateTimeHelper.formatElapsedTime(
                        appLocalizations: context.translate,
                        compareDate: socialPostEntity.when!,
                        locale: LocaleHelper.languageAndCountryCode(
                          locale: Localizations.localeOf(context),
                        ),
                      ),
                      darkColor: SeniorColors.grayscale30,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Visibility(
            visible: false,
            child: IconButton(
              onPressed: () {},
              icon: const SeniorIcon(
                icon: FontAwesomeIcons.ellipsisVertical,
                style: SeniorIconStyle(
                  color: SeniorColors.pureBlack,
                ),
                size: SeniorSpacing.medium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
