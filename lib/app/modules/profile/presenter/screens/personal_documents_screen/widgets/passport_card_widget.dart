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
import '../../../../domain/entities/passport_entity.dart';
import 'title_card_widget.dart';

class PassportCardWidget extends StatelessWidget {
  final EdgeInsets _paddingDocumentItemLeft = const EdgeInsets.only(
    left: SeniorSpacing.big,
    bottom: SeniorSpacing.small,
  );

  final EdgeInsets _paddingDocumentItemRight = const EdgeInsets.only(
    right: SeniorSpacing.medium,
    bottom: SeniorSpacing.small,
  );
  final PassportEntity passportEntity;

  const PassportCardWidget({
    Key? key,
    required this.passportEntity,
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
        key: const Key('profile-passport_card-senior_card'),
        showActionIcon: false,
        padding: const EdgeInsets.only(
          left: SeniorSpacing.normal,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TitleCardWidget(
              leftIcon: FontAwesomeIcons.solidPassport,
              cardTitle: context.translate.passport,
              copyButtonText: passportEntity.number ?? '',
              copyButtonMessageSuccess: context.translate.passportNumberCopiedSuccessfully,
            ),
            Column(
              children: [
                (passportEntity.number == null && passportEntity.issuingCountryName == null)
                    ? const SizedBox.shrink()
                    : Row(
                        mainAxisAlignment:
                            passportEntity.number != null ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
                        children: [
                          passportEntity.number != null
                              ? DocumentItemWidget(
                                  padding: _paddingDocumentItemLeft,
                                  title: context.translate.number,
                                  items: [
                                    passportEntity.number!,
                                  ],
                                )
                              : const SizedBox.shrink(),
                          passportEntity.issuingCountryName != null
                              ? DocumentItemWidget(
                                  padding: passportEntity.number != null
                                      ? _paddingDocumentItemRight
                                      : _paddingDocumentItemLeft,
                                  crossAxisAlignment:
                                      passportEntity.number != null ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                  title: context.translate.issuingCountry,
                                  items: [
                                    passportEntity.issuingCountryName!,
                                  ],
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                (passportEntity.issuer == null && passportEntity.issuingState == null)
                    ? const SizedBox.shrink()
                    : Row(
                        mainAxisAlignment:
                            passportEntity.issuer != null ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
                        children: [
                          passportEntity.issuer != null
                              ? DocumentItemWidget(
                                  padding: _paddingDocumentItemLeft,
                                  title: context.translate.issuingBody,
                                  items: [
                                    passportEntity.issuer!,
                                  ],
                                )
                              : const SizedBox.shrink(),
                          passportEntity.issuingState != null
                              ? DocumentItemWidget(
                                  padding: passportEntity.issuer != null
                                      ? _paddingDocumentItemRight
                                      : _paddingDocumentItemLeft,
                                  crossAxisAlignment:
                                      passportEntity.issuer != null ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                  title: context.translate.issuanceBodyFedUnit,
                                  items: [
                                    EnumHelper<BrazilianStateEnum>().enumToString(
                                      enumToParse: passportEntity.issuingState!,
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                (passportEntity.issuedDate == null && passportEntity.issuingState == null)
                    ? const SizedBox.shrink()
                    : Row(
                        mainAxisAlignment: passportEntity.issuedDate != null
                            ? MainAxisAlignment.spaceBetween
                            : MainAxisAlignment.start,
                        children: [
                          passportEntity.issuedDate != null
                              ? DocumentItemWidget(
                                  padding: _paddingDocumentItemLeft,
                                  title: context.translate.issuanceDate,
                                  items: [
                                    DateTimeHelper.formatWithDefaultDatePattern(
                                      dateTime: passportEntity.issuedDate!,
                                      locale: LocaleHelper.languageAndCountryCode(
                                        locale: Localizations.localeOf(context),
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                          passportEntity.expiryDate != null
                              ? DocumentItemWidget(
                                  padding: passportEntity.issuedDate != null
                                      ? _paddingDocumentItemRight
                                      : _paddingDocumentItemLeft,
                                  crossAxisAlignment: passportEntity.issuedDate != null
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                                  title: context.translate.expirationDate,
                                  items: [
                                    DateTimeHelper.formatWithDefaultDatePattern(
                                      dateTime: passportEntity.expiryDate!,
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
