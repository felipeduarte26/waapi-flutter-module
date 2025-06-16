import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/enums/brazilian_state_enum.dart';
import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/helper/date_time_helper.dart';
import '../../../../../../core/helper/enum_helper.dart';
import '../../../../../../core/helper/locale_helper.dart';
import '../../../../../../core/widgets/document_item_widget.dart';
import '../../../../../../core/widgets/waapi_card_widget.dart';
import '../../../../domain/entities/cnh_entity.dart';
import '../../../../enums/cnh_category_enum.dart';
import 'title_card_widget.dart';

class CnhCardWidget extends StatelessWidget {
  final EdgeInsets _paddingDocumentItemLeft = const EdgeInsets.only(
    left: SeniorSpacing.big,
    bottom: SeniorSpacing.small,
  );

  final EdgeInsets _paddingDocumentItemRight = const EdgeInsets.only(
    right: SeniorSpacing.medium,
    bottom: SeniorSpacing.small,
  );
  final CnhEntity cnhEntity;

  const CnhCardWidget({
    Key? key,
    required this.cnhEntity,
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
        key: const Key('profile-cnh_card-senior_card'),
        showActionIcon: false,
        padding: const EdgeInsets.only(
          left: SeniorSpacing.normal,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TitleCardWidget(
              leftIcon: FontAwesomeIcons.solidCarRear,
              cardTitle: context.translate.cnh,
              copyButtonText: cnhEntity.number ?? '',
              copyButtonMessageSuccess: context.translate.cnhNumberCopiedSuccessfully,
            ),
            Column(
              children: [
                (cnhEntity.number == null && cnhEntity.category == null)
                    ? const SizedBox.shrink()
                    : Row(
                        mainAxisAlignment:
                            cnhEntity.number != null ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
                        children: [
                          cnhEntity.number != null
                              ? DocumentItemWidget(
                                  padding: _paddingDocumentItemLeft,
                                  title: context.translate.number,
                                  items: [
                                    cnhEntity.number!,
                                  ],
                                )
                              : const SizedBox.shrink(),
                          cnhEntity.category != null
                              ? DocumentItemWidget(
                                  padding:
                                      cnhEntity.number != null ? _paddingDocumentItemRight : _paddingDocumentItemLeft,
                                  crossAxisAlignment:
                                      cnhEntity.number != null ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                  title: context.translate.category,
                                  items: [
                                    EnumHelper<CnhCategoryEnum>().enumToString(
                                      enumToParse: cnhEntity.category!,
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                (cnhEntity.issuer == null && cnhEntity.issuedDate == null)
                    ? const SizedBox.shrink()
                    : Row(
                        mainAxisAlignment:
                            cnhEntity.issuer != null ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
                        children: [
                          cnhEntity.issuer != null
                              ? DocumentItemWidget(
                                  padding: _paddingDocumentItemLeft,
                                  title: context.translate.issuingBody,
                                  items: [
                                    cnhEntity.issuerState != null
                                        ? '${cnhEntity.issuer!}/${EnumHelper<BrazilianStateEnum>().enumToString(
                                            enumToParse: cnhEntity.issuerState!,
                                          )}'
                                        : '',
                                  ],
                                )
                              : const SizedBox.shrink(),
                          cnhEntity.issuedDate != null
                              ? DocumentItemWidget(
                                  padding:
                                      cnhEntity.issuer != null ? _paddingDocumentItemRight : _paddingDocumentItemLeft,
                                  crossAxisAlignment:
                                      cnhEntity.issuer != null ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                  title: context.translate.issuanceDate,
                                  items: [
                                    DateTimeHelper.formatWithDefaultDatePattern(
                                      dateTime: cnhEntity.issuedDate!,
                                      locale: LocaleHelper.languageAndCountryCode(
                                        locale: Localizations.localeOf(context),
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                (cnhEntity.expiryDate == null && cnhEntity.firstIssuedDate == null)
                    ? const SizedBox.shrink()
                    : Row(
                        mainAxisAlignment:
                            cnhEntity.expiryDate != null ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
                        children: [
                          cnhEntity.expiryDate != null
                              ? DocumentItemWidget(
                                  padding: _paddingDocumentItemLeft,
                                  title: context.translate.expirationDate,
                                  items: [
                                    DateTimeHelper.formatWithDefaultDatePattern(
                                      dateTime: cnhEntity.expiryDate!,
                                      locale: LocaleHelper.languageAndCountryCode(
                                        locale: Localizations.localeOf(context),
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                          cnhEntity.firstIssuedDate != null
                              ? DocumentItemWidget(
                                  padding: cnhEntity.expiryDate != null
                                      ? _paddingDocumentItemRight
                                      : _paddingDocumentItemLeft,
                                  crossAxisAlignment:
                                      cnhEntity.expiryDate != null ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                  title: context.translate.firstCNH,
                                  items: [
                                    DateTimeHelper.formatWithDefaultDatePattern(
                                      dateTime: cnhEntity.firstIssuedDate!,
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
