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
import '../../../../domain/entities/ctps_entity.dart';
import 'title_card_widget.dart';

class CtpsCardWidget extends StatelessWidget {
  final EdgeInsets _paddingDocumentItemLeft = const EdgeInsets.only(
    left: SeniorSpacing.big,
    bottom: SeniorSpacing.small,
  );

  final EdgeInsets _paddingDocumentItemRight = const EdgeInsets.only(
    right: SeniorSpacing.medium,
    bottom: SeniorSpacing.small,
  );
  final CtpsEntity ctpsEntity;

  const CtpsCardWidget({
    Key? key,
    required this.ctpsEntity,
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
        padding: const EdgeInsets.only(
          left: SeniorSpacing.normal,
        ),
        key: const Key('profile-ctps_card-senior_card'),
        showActionIcon: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: SeniorSpacing.small,
              ),
              child: TitleCardWidget(
                leftIcon: FontAwesomeIcons.solidSuitcase,
                cardTitle: context.translate.ctps,
                copyButtonText: ctpsEntity.number ?? '',
                copyButtonMessageSuccess: context.translate.ctpsNumberCopiedSuccessfully,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                (ctpsEntity.number != null)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DocumentItemWidget(
                            padding: _paddingDocumentItemLeft,
                            title: context.translate.number,
                            items: [
                              ctpsEntity.number!,
                            ],
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
                (ctpsEntity.serie == null && ctpsEntity.serieDigit == null)
                    ? const SizedBox.shrink()
                    : Row(
                        mainAxisAlignment:
                            ctpsEntity.serie != null ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
                        children: [
                          ctpsEntity.serie != null
                              ? DocumentItemWidget(
                                  padding: _paddingDocumentItemLeft,
                                  title: context.translate.series,
                                  items: [
                                    ctpsEntity.serie!,
                                  ],
                                )
                              : const SizedBox.shrink(),
                          ctpsEntity.serieDigit != null
                              ? DocumentItemWidget(
                                  padding:
                                      ctpsEntity.serie != null ? _paddingDocumentItemRight : _paddingDocumentItemLeft,
                                  crossAxisAlignment:
                                      ctpsEntity.serie != null ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                  title: context.translate.digit,
                                  items: [
                                    ctpsEntity.serieDigit!,
                                  ],
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                (ctpsEntity.issuedDate == null && ctpsEntity.state == null)
                    ? const SizedBox.shrink()
                    : Row(
                        mainAxisAlignment:
                            ctpsEntity.issuedDate != null ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
                        children: [
                          ctpsEntity.issuedDate != null
                              ? DocumentItemWidget(
                                  padding: _paddingDocumentItemLeft,
                                  title: context.translate.issuanceDate,
                                  items: [
                                    DateTimeHelper.formatWithDefaultDatePattern(
                                      dateTime: ctpsEntity.issuedDate!,
                                      locale: LocaleHelper.languageAndCountryCode(
                                        locale: Localizations.localeOf(context),
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                          ctpsEntity.state != null
                              ? DocumentItemWidget(
                                  padding: ctpsEntity.issuedDate != null
                                      ? _paddingDocumentItemRight
                                      : _paddingDocumentItemLeft,
                                  crossAxisAlignment:
                                      ctpsEntity.issuedDate != null ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                  title: context.translate.addressState,
                                  items: [
                                    EnumHelper<BrazilianStateEnum>().enumToString(
                                      enumToParse: ctpsEntity.state!,
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
