import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/helper/date_time_helper.dart';
import '../../../../../../core/helper/locale_helper.dart';
import '../../../../../../core/widgets/document_item_widget.dart';
import '../../../../../../core/widgets/waapi_card_widget.dart';
import '../../../../domain/entities/visa_entity.dart';
import '../../../string_formatters/enum_visa_type_string_formatter.dart';
import 'title_card_widget.dart';

class VisaCardWidget extends StatelessWidget {
  final EdgeInsets _paddingDocumentItemLeft = const EdgeInsets.only(
    left: SeniorSpacing.big,
    bottom: SeniorSpacing.small,
  );

  final EdgeInsets _paddingDocumentItemRight = const EdgeInsets.only(
    right: SeniorSpacing.medium,
    bottom: SeniorSpacing.small,
  );
  final VisaEntity visaEntity;

  const VisaCardWidget({
    Key? key,
    required this.visaEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: SeniorSpacing.normal,
        left: SeniorSpacing.normal,
        right: SeniorSpacing.normal,
      ),
      child: WaapiCardWidget(
        key: const Key('profile-visa_card-senior_card'),
        showActionIcon: false,
        padding: const EdgeInsets.only(
          left: SeniorSpacing.normal,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TitleCardWidget(
              leftIcon: FontAwesomeIcons.solidIdCard,
              cardTitle: context.translate.visa,
              copyButtonText: visaEntity.number ?? '',
              copyButtonMessageSuccess: context.translate.visaCopiedSuccessfully,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                (visaEntity.number == null && visaEntity.visaType == null)
                    ? const SizedBox.shrink()
                    : Row(
                        mainAxisAlignment:
                            visaEntity.number != null ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
                        children: [
                          visaEntity.number != null
                              ? DocumentItemWidget(
                                  padding: _paddingDocumentItemLeft,
                                  title: context.translate.number,
                                  items: [
                                    visaEntity.number!,
                                  ],
                                )
                              : const SizedBox.shrink(),
                          visaEntity.visaType != null
                              ? DocumentItemWidget(
                                  padding:
                                      visaEntity.number != null ? _paddingDocumentItemRight : _paddingDocumentItemLeft,
                                  crossAxisAlignment:
                                      visaEntity.number != null ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                  title: context.translate.type,
                                  items: [
                                    EnumVisaTypeStringFormatter.getEnumVisaTypeString(
                                      appLocalizations: context.translate,
                                      visaTypeEnum: visaEntity.visaType!,
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                (visaEntity.issuedDate == null && visaEntity.expiryDate == null)
                    ? const SizedBox.shrink()
                    : Row(
                        mainAxisAlignment:
                            visaEntity.issuedDate != null ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
                        children: [
                          visaEntity.issuedDate != null
                              ? DocumentItemWidget(
                                  padding: _paddingDocumentItemLeft,
                                  title: context.translate.issuanceDate,
                                  items: [
                                    DateTimeHelper.formatWithDefaultDatePattern(
                                      dateTime: visaEntity.issuedDate!,
                                      locale: LocaleHelper.languageAndCountryCode(
                                        locale: Localizations.localeOf(context),
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                          visaEntity.expiryDate != null
                              ? DocumentItemWidget(
                                  padding: visaEntity.issuedDate != null
                                      ? _paddingDocumentItemRight
                                      : _paddingDocumentItemLeft,
                                  crossAxisAlignment:
                                      visaEntity.issuedDate != null ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                  title: context.translate.expirationDate,
                                  items: [
                                    DateTimeHelper.formatWithDefaultDatePattern(
                                      dateTime: visaEntity.expiryDate!,
                                      locale: LocaleHelper.languageAndCountryCode(
                                        locale: Localizations.localeOf(context),
                                      ),
                                    ),
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
}
