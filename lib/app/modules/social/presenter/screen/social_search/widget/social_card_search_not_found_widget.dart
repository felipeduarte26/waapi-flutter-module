import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/extension/translate_extension.dart';
import '../../../../enums/social_search_item_enum.dart';

class SocialCardSearchNotFoundWidget extends StatelessWidget {
  final SocialSearchItemEnum searchItemEnum;
  final bool errorStatus;
  final VoidCallback? onTap;
  const SocialCardSearchNotFoundWidget({
    super.key,
    this.errorStatus = false,
    required this.searchItemEnum,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);
    final isDarkTheme = themeRepository.isDarkTheme();
    final isCustomTheme = themeRepository.isCustomTheme();
    return Padding(
      padding: const EdgeInsets.only(
        top: SeniorSpacing.normal,
      ),
      child: SeniorCard(
        style: SeniorCardStyle(
          backgroundColor: isCustomTheme
              ? SeniorColors.pureWhite
              : isDarkTheme
                  ? Provider.of<ThemeRepository>(context).theme.cardTheme!.style!.backgroundColor
                  : SeniorColors.grayscale5,
        ),
        withElevation: isCustomTheme,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SeniorIcon(
              style: SeniorIconStyle(
                color: isCustomTheme ? null : SeniorColors.primaryColor500,
              ),
              icon: FontAwesomeIcons.solidTriangleExclamation,
              size: 32,
            ),
            const SizedBox(
              width: SeniorSpacing.normal,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SeniorText.body(
                  _getNotFoundText(
                    context: context,
                  ),
                ),
                Visibility(
                  visible: errorStatus,
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: SeniorSpacing.xxsmall,
                      ),
                      child: SeniorText.smallBold(
                        context.translate.tryAgain,
                        color: SeniorColors.primaryColor600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getNotFoundText({required BuildContext context, bool errorStatus = false}) {
    if (errorStatus) return context.translate.anErrorOccurredWhileSearching;
    if (searchItemEnum == SocialSearchItemEnum.profiles) return context.translate.noPeopleFound;
    if (searchItemEnum == SocialSearchItemEnum.space) return context.translate.noPublicationsFound;
    if (searchItemEnum == SocialSearchItemEnum.tags) return context.translate.noHashtagsFound;
    if (searchItemEnum == SocialSearchItemEnum.posts) return context.translate.noMorePublicationsFound;
    return context.translate.noResultsFound;
  }
}
