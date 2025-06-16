import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/extension/translate_extension.dart';
import '../../../../core/helper/date_time_helper.dart';
import '../../../../core/helper/locale_helper.dart';
import '../../../../core/widgets/waapi_card_widget.dart';

class BirthdayEmployeeCardWidget extends StatelessWidget {
  final bool disabled;
  final String employeeName;
  final DateTime birthday;
  final String employeePhotoLink;
  final int yearsCount;
  final VoidCallback onTap;

  const BirthdayEmployeeCardWidget({
    Key? key,
    required this.employeeName,
    required this.birthday,
    required this.employeePhotoLink,
    required this.onTap,
    required this.disabled,
    this.yearsCount = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WaapiCardWidget(
      disabled: disabled,
      onTap: onTap,
      width: 106,
      showActionIcon: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SeniorProfilePicture(
            radius: SeniorCircularElements.small,
            imageProvider: CachedNetworkImageProvider(employeePhotoLink),
            name: employeeName,
          ),
          const SizedBox(
            height: SeniorSpacing.xxsmall,
          ),
          SeniorText.smallBold(
            employeeName,
            textProperties: const TextProperties(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (yearsCount > 0)
            Column(
              children: [
                const SizedBox(
                  height: SeniorSpacing.xxsmall,
                ),
                SeniorText.small(
                  context.translate.yearCountDescription(
                    yearsCount.toString(),
                    yearsCount == 1 ? context.translate.year : context.translate.years,
                  ),
                  color: SeniorColors.neutralColor600,
                  textProperties: const TextProperties(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          const SizedBox(
            height: SeniorSpacing.xxsmall,
          ),
          SeniorText.small(
            DateTimeHelper.formatToMMMdPattern(
              dateTime: birthday,
              locale: LocaleHelper.languageAndCountryCode(
                locale: Localizations.localeOf(context),
              ),
            ),
            color: SeniorColors.neutralColor600,
            textProperties: const TextProperties(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
