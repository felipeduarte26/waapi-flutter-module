import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/helper/date_time_helper.dart';
import '../../../../../../core/helper/locale_helper.dart';
import '../../../../../../core/widgets/document_item_widget.dart';
import '../../../../../../core/widgets/waapi_card_widget.dart';
import '../../../../domain/entities/rne_entity.dart';
import 'title_card_widget.dart';

class RneCardWidget extends StatelessWidget {
  final EdgeInsets _paddingDocumentItemLeft = const EdgeInsets.only(
    left: SeniorSpacing.big,
    bottom: SeniorSpacing.small,
  );

  final EdgeInsets _paddingDocumentItemRight = const EdgeInsets.only(
    right: SeniorSpacing.medium,
    bottom: SeniorSpacing.small,
  );
  final RneEntity rneEntity;

  const RneCardWidget({
    Key? key,
    required this.rneEntity,
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
        key: const Key('profile-rne_card-senior_card'),
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
              cardTitle: context.translate.rne,
              copyButtonText: rneEntity.number ?? '',
              copyButtonMessageSuccess: context.translate.rneCopiedSuccessfully,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                (rneEntity.number != null)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DocumentItemWidget(
                            padding: _paddingDocumentItemLeft,
                            title: context.translate.number,
                            items: [
                              rneEntity.number!,
                            ],
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
                (rneEntity.issuer == null && rneEntity.issuedDate == null)
                    ? const SizedBox.shrink()
                    : Row(
                        mainAxisAlignment:
                            rneEntity.issuer != null ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
                        children: [
                          rneEntity.issuer != null
                              ? DocumentItemWidget(
                                  padding: _paddingDocumentItemLeft,
                                  title: context.translate.issuingBody,
                                  items: [
                                    rneEntity.issuer!,
                                  ],
                                )
                              : const SizedBox.shrink(),
                          rneEntity.issuedDate != null
                              ? DocumentItemWidget(
                                  padding:
                                      rneEntity.issuer != null ? _paddingDocumentItemRight : _paddingDocumentItemLeft,
                                  crossAxisAlignment:
                                      rneEntity.issuer != null ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                  title: context.translate.issuanceDate,
                                  items: [
                                    DateTimeHelper.formatWithDefaultDatePattern(
                                      dateTime: rneEntity.issuedDate!,
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
