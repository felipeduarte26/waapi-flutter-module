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
import '../../../../domain/entities/rg_entity.dart';
import 'title_card_widget.dart';

class RgCardWidget extends StatelessWidget {
  final EdgeInsets _paddingDocumentItemLeft = const EdgeInsets.only(
    left: SeniorSpacing.big,
    bottom: SeniorSpacing.small,
  );

  final EdgeInsets _paddingDocumentItemRight = const EdgeInsets.only(
    right: SeniorSpacing.medium,
    bottom: SeniorSpacing.small,
  );
  final RgEntity rgEntity;

  const RgCardWidget({
    Key? key,
    required this.rgEntity,
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
        key: const Key('profile-rg_card-senior_card'),
        showActionIcon: false,
        padding: const EdgeInsets.only(
          left: SeniorSpacing.normal,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TitleCardWidget(
              leftIcon: FontAwesomeIcons.solidUser,
              cardTitle: context.translate.rg,
              copyButtonText: rgEntity.number ?? '',
              copyButtonMessageSuccess: context.translate.rgNumberCopiedSuccessfully,
            ),
            Column(
              children: [
                (rgEntity.number == null && rgEntity.issuedDate == null)
                    ? const SizedBox.shrink()
                    : Row(
                        mainAxisAlignment:
                            rgEntity.number != null ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
                        children: [
                          rgEntity.number != null
                              ? DocumentItemWidget(
                                  padding: _paddingDocumentItemLeft,
                                  title: context.translate.number,
                                  items: [
                                    rgEntity.number!,
                                  ],
                                )
                              : const SizedBox.shrink(),
                          rgEntity.issuedDate != null
                              ? DocumentItemWidget(
                                  padding:
                                      rgEntity.number != null ? _paddingDocumentItemRight : _paddingDocumentItemLeft,
                                  crossAxisAlignment:
                                      rgEntity.number != null ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                  title: context.translate.issuanceDate,
                                  items: [
                                    DateTimeHelper.formatWithDefaultDatePattern(
                                      dateTime: rgEntity.issuedDate!,
                                      locale: LocaleHelper.languageAndCountryCode(
                                        locale: Localizations.localeOf(context),
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                (rgEntity.issuer == null && rgEntity.issuedDate == null)
                    ? const SizedBox.shrink()
                    : Row(
                        mainAxisAlignment:
                            rgEntity.issuer != null ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
                        children: [
                          rgEntity.issuer != null
                              ? DocumentItemWidget(
                                  padding: _paddingDocumentItemLeft,
                                  title: context.translate.issuingBody,
                                  items: [
                                    rgEntity.issuer!,
                                  ],
                                )
                              : const SizedBox.shrink(),
                          rgEntity.issuingState != null
                              ? DocumentItemWidget(
                                  padding:
                                      rgEntity.issuer != null ? _paddingDocumentItemRight : _paddingDocumentItemLeft,
                                  crossAxisAlignment:
                                      rgEntity.issuer != null ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                  title: context.translate.addressState,
                                  items: [
                                    EnumHelper<BrazilianStateEnum>().enumToString(
                                      enumToParse: rgEntity.issuingState!,
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
