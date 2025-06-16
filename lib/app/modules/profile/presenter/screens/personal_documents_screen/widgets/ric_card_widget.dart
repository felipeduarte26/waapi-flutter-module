import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/helper/date_time_helper.dart';
import '../../../../../../core/helper/locale_helper.dart';
import '../../../../../../core/widgets/document_item_widget.dart';
import '../../../../../../core/widgets/waapi_card_widget.dart';
import '../../../../domain/entities/ric_entity.dart';
import 'title_card_widget.dart';

class RicCardWidget extends StatelessWidget {
  final EdgeInsets _paddingDocumentItemLeft = const EdgeInsets.only(
    left: SeniorSpacing.big,
    bottom: SeniorSpacing.small,
  );

  final EdgeInsets _paddingDocumentItemRight = const EdgeInsets.only(
    right: SeniorSpacing.medium,
    bottom: SeniorSpacing.small,
  );
  final RicEntity ricEntity;

  const RicCardWidget({
    Key? key,
    required this.ricEntity,
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
        key: const Key('profile-ric_card-senior_card'),
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
              cardTitle: context.translate.ric,
              copyButtonText: ricEntity.number ?? '',
              copyButtonMessageSuccess: context.translate.ricNumberCopiedSuccessfully,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                (ricEntity.number == null && ricEntity.issuer == null)
                    ? const SizedBox.shrink()
                    : Row(
                        mainAxisAlignment:
                            ricEntity.number != null ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
                        children: [
                          ricEntity.number != null
                              ? DocumentItemWidget(
                                  padding: _paddingDocumentItemLeft,
                                  title: context.translate.number,
                                  items: [
                                    ricEntity.number!,
                                  ],
                                )
                              : const SizedBox.shrink(),
                          ricEntity.issuer != null
                              ? DocumentItemWidget(
                                  padding:
                                      ricEntity.number != null ? _paddingDocumentItemRight : _paddingDocumentItemLeft,
                                  crossAxisAlignment:
                                      ricEntity.number != null ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                  title: context.translate.issuingBody,
                                  items: [
                                    ricEntity.issuer!,
                                  ],
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                (ricEntity.issuedDate != null)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DocumentItemWidget(
                            padding: _paddingDocumentItemLeft,
                            title: context.translate.issuanceDate,
                            items: [
                              DateTimeHelper.formatWithDefaultDatePattern(
                                dateTime: ricEntity.issuedDate!,
                                locale: LocaleHelper.languageAndCountryCode(
                                  locale: Localizations.localeOf(context),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
