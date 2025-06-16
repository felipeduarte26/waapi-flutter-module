import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/widgets/document_item_widget.dart';
import '../../../../../../core/widgets/waapi_card_widget.dart';
import '../../../../domain/entities/voter_registration_entity.dart';
import 'title_card_widget.dart';

class VoterRegistrationCardWidget extends StatelessWidget {
  final EdgeInsets _paddingDocumentItemLeft = const EdgeInsets.only(
    left: SeniorSpacing.big,
    bottom: SeniorSpacing.small,
  );

  final EdgeInsets _paddingDocumentItemRight = const EdgeInsets.only(
    right: SeniorSpacing.medium,
    bottom: SeniorSpacing.small,
  );
  final VoterRegistrationEntity voterRegistrationEntity;

  const VoterRegistrationCardWidget({
    Key? key,
    required this.voterRegistrationEntity,
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
        key: const Key('profile-voter_registration_card-senior_card'),
        showActionIcon: false,
        padding: const EdgeInsets.only(
          left: SeniorSpacing.normal,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TitleCardWidget(
              leftIcon: FontAwesomeIcons.solidCheckToSlot,
              cardTitle: context.translate.voterRegistrationCard,
              copyButtonText: voterRegistrationEntity.number ?? '',
              copyButtonMessageSuccess: context.translate.voterRegistrationNumberCopiedSuccessfully,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                (voterRegistrationEntity.number != null)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DocumentItemWidget(
                            padding: _paddingDocumentItemLeft,
                            title: context.translate.number,
                            items: [
                              voterRegistrationEntity.number!,
                            ],
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
                (voterRegistrationEntity.section == null && voterRegistrationEntity.zone == null)
                    ? const SizedBox.shrink()
                    : Row(
                        mainAxisAlignment: voterRegistrationEntity.section != null
                            ? MainAxisAlignment.spaceBetween
                            : MainAxisAlignment.start,
                        children: [
                          voterRegistrationEntity.section != null
                              ? DocumentItemWidget(
                                  padding: _paddingDocumentItemLeft,
                                  title: context.translate.section,
                                  items: [
                                    voterRegistrationEntity.section!.toString(),
                                  ],
                                )
                              : const SizedBox.shrink(),
                          voterRegistrationEntity.zone != null
                              ? DocumentItemWidget(
                                  padding: voterRegistrationEntity.section != null
                                      ? _paddingDocumentItemRight
                                      : _paddingDocumentItemLeft,
                                  crossAxisAlignment: voterRegistrationEntity.section != null
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                                  title: context.translate.zone,
                                  items: [
                                    voterRegistrationEntity.zone!.toString(),
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
