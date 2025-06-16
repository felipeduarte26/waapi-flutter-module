import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/widgets/document_item_widget.dart';
import '../../../../../../core/widgets/waapi_card_widget.dart';
import 'title_card_widget.dart';

class CpfCardWidget extends StatelessWidget {
  final String cpfNumber;

  const CpfCardWidget({
    Key? key,
    required this.cpfNumber,
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
        key: const Key('profile-cpf_card-senior_card'),
        showActionIcon: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TitleCardWidget(
              leftIcon: FontAwesomeIcons.solidUser,
              cardTitle: context.translate.cpf,
              copyButtonText: cpfNumber,
              copyButtonMessageSuccess: context.translate.cpfNumberCopiedSuccessfully,
            ),
            DocumentItemWidget(
              padding: const EdgeInsets.only(
                left: SeniorSpacing.big,
                bottom: SeniorSpacing.small,
              ),
              key: const Key('profile-cpf_card-personal_document_item-contact_item-cpf_number'),
              title: context.translate.number,
              items: [
                cpfNumber,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
