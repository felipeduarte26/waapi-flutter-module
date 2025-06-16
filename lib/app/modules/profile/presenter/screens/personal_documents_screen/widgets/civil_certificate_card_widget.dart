import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/helper/date_time_helper.dart';
import '../../../../../../core/helper/locale_helper.dart';
import '../../../../../../core/widgets/document_item_widget.dart';
import '../../../../../../core/widgets/waapi_card_widget.dart';
import '../../../../domain/entities/civil_certificate_entity.dart';
import '../../../../enums/civil_certificate_type_enum.dart';
import '../../../string_formatters/enum_civil_certificate_type_string_formatter.dart';
import 'title_card_widget.dart';

class CivilCertificateCardWidget extends StatelessWidget {
  final EdgeInsets _paddingDocumentItemLeft = const EdgeInsets.only(
    left: SeniorSpacing.big,
    bottom: SeniorSpacing.small,
  );

  final EdgeInsets _paddingDocumentItemRight = const EdgeInsets.only(
    right: SeniorSpacing.medium,
    bottom: SeniorSpacing.small,
  );
  final CivilCertificateEntity civilCertificateEntity;

  const CivilCertificateCardWidget({
    Key? key,
    required this.civilCertificateEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final civilCertificateType = EnumCivilCertificateTypeStringFormatter.getEnumCivilCertificateTypeString(
      civilCertificateTypeEnum: civilCertificateEntity.certificateType != null
          ? civilCertificateEntity.certificateType!
          : CivilCertificateTypeEnum.others,
      appLocalizations: context.translate,
    );
    return Padding(
      padding: const EdgeInsets.only(
        left: SeniorSpacing.normal,
        right: SeniorSpacing.normal,
      ),
      child: WaapiCardWidget(
        key: Key('profile-civil_certificate_card-senior_card_${civilCertificateEntity.id}'),
        showActionIcon: false,
        padding: const EdgeInsets.only(
          left: SeniorSpacing.normal,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TitleCardWidget(
              leftIcon: civilCertificateIcon(civilCertificateEntity),
              cardTitle: context.translate.certificateOf(civilCertificateType),
              isCopyButtonVisible: false,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                (civilCertificateEntity.bookNumber == null && civilCertificateEntity.paperNumber == null)
                    ? const SizedBox.shrink()
                    : Row(
                        mainAxisAlignment: civilCertificateEntity.bookNumber != null
                            ? MainAxisAlignment.spaceBetween
                            : MainAxisAlignment.start,
                        children: [
                          civilCertificateEntity.bookNumber != null
                              ? DocumentItemWidget(
                                  padding: _paddingDocumentItemLeft,
                                  title: context.translate.bookNumber,
                                  items: [
                                    civilCertificateEntity.bookNumber!,
                                  ],
                                )
                              : const SizedBox.shrink(),
                          civilCertificateEntity.paperNumber != null
                              ? DocumentItemWidget(
                                  padding: civilCertificateEntity.bookNumber != null
                                      ? _paddingDocumentItemRight
                                      : _paddingDocumentItemLeft,
                                  crossAxisAlignment: civilCertificateEntity.bookNumber != null
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                                  title: context.translate.sheetNumber,
                                  items: [
                                    civilCertificateEntity.paperNumber!,
                                  ],
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                (civilCertificateEntity.enrollment == null && civilCertificateEntity.registryName == null)
                    ? const SizedBox.shrink()
                    : Row(
                        mainAxisAlignment: civilCertificateEntity.enrollment != null
                            ? MainAxisAlignment.spaceBetween
                            : MainAxisAlignment.start,
                        children: [
                          civilCertificateEntity.enrollment != null
                              ? Expanded(
                                  child: DocumentItemWidget(
                                    padding: _paddingDocumentItemLeft,
                                    title: context.translate.registrationNumber,
                                    items: [
                                      civilCertificateEntity.enrollment!,
                                    ],
                                  ),
                                )
                              : const SizedBox.shrink(),
                          civilCertificateEntity.registryName != null
                              ? Expanded(
                                  child: DocumentItemWidget(
                                    padding: civilCertificateEntity.enrollment != null
                                        ? _paddingDocumentItemRight
                                        : _paddingDocumentItemLeft,
                                    crossAxisAlignment: civilCertificateEntity.enrollment != null
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                    title: context.translate.notaryOfficeName,
                                    items: [
                                      civilCertificateEntity.registryName!,
                                    ],
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                (civilCertificateEntity.termNumber == null && civilCertificateEntity.issuedDate == null)
                    ? const SizedBox.shrink()
                    : Row(
                        mainAxisAlignment: civilCertificateEntity.termNumber != null
                            ? MainAxisAlignment.spaceBetween
                            : MainAxisAlignment.start,
                        children: [
                          civilCertificateEntity.termNumber != null
                              ? DocumentItemWidget(
                                  padding: _paddingDocumentItemLeft,
                                  title: context.translate.termNumber,
                                  items: [
                                    civilCertificateEntity.termNumber!,
                                  ],
                                )
                              : const SizedBox.shrink(),
                          civilCertificateEntity.issuedDate != null
                              ? DocumentItemWidget(
                                  padding: civilCertificateEntity.termNumber != null
                                      ? _paddingDocumentItemRight
                                      : _paddingDocumentItemLeft,
                                  crossAxisAlignment: civilCertificateEntity.termNumber != null
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                                  title: context.translate.issuanceDate,
                                  items: [
                                    DateTimeHelper.formatWithDefaultDatePattern(
                                      dateTime: civilCertificateEntity.issuedDate!,
                                      locale: LocaleHelper.languageAndCountryCode(
                                        locale: Localizations.localeOf(context),
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                (civilCertificateEntity.city?.name == null && civilCertificateEntity.issuedDate == null)
                    ? const SizedBox.shrink()
                    : Row(
                        mainAxisAlignment: civilCertificateEntity.city?.name != null
                            ? MainAxisAlignment.spaceBetween
                            : MainAxisAlignment.start,
                        children: [
                          civilCertificateEntity.city?.name != null
                              ? DocumentItemWidget(
                                  padding: _paddingDocumentItemLeft,
                                  title: context.translate.addressCity,
                                  items: [
                                    civilCertificateEntity.city!.name!,
                                  ],
                                )
                              : const SizedBox.shrink(),
                          civilCertificateEntity.city?.state?.name != null
                              ? DocumentItemWidget(
                                  padding: civilCertificateEntity.city?.name != null
                                      ? _paddingDocumentItemRight
                                      : _paddingDocumentItemLeft,
                                  crossAxisAlignment: civilCertificateEntity.city?.name != null
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                                  title: context.translate.addressState,
                                  items: [
                                    civilCertificateEntity.city!.state!.name!,
                                  ],
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData civilCertificateIcon(CivilCertificateEntity certificateEntity) {
    switch (certificateEntity.certificateType) {
      case CivilCertificateTypeEnum.birth:
        return FontAwesomeIcons.solidCakeCandles;
      case CivilCertificateTypeEnum.marriage:
      case CivilCertificateTypeEnum.religiousMarriage:
        return FontAwesomeIcons.solidUserGroup;
      default:
        return FontAwesomeIcons.solidFileLines;
    }
  }
}
