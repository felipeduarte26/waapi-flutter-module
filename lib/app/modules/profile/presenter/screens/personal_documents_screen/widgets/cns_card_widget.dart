import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/widgets/document_item_widget.dart';
import '../../../../../../core/widgets/waapi_card_widget.dart';
import 'title_card_widget.dart';

class CnsCardWidget extends StatelessWidget {
  final String nationalHealthCard;

  const CnsCardWidget({
    Key? key,
    required this.nationalHealthCard,
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
        key: const Key('profile-cns_card-senior_card'),
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
              cardTitle: context.translate.cns,
              copyButtonText: nationalHealthCard,
              copyButtonMessageSuccess: context.translate.cnsNumberCopiedSuccessfully,
            ),
            DocumentItemWidget(
              padding: const EdgeInsets.only(
                left: SeniorSpacing.big,
                bottom: SeniorSpacing.small,
              ),
              key: const Key('profile-cpf_card-personal_document_item-contact_item-cpf_number'),
              title: context.translate.number,
              items: [
                nationalHealthCard,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
