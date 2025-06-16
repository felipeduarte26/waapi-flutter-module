import 'package:flutter/material.dart';

import '../../../../../../core/extension/translate_extension.dart';
import 'information_description_item_widget.dart';

class GenderIdentitiesDescription extends StatelessWidget {
  const GenderIdentitiesDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        InformationDescriptionItem(
          title: '${context.translate.cisgenderFemaleTitle}: ',
          description: context.translate.cisgenderFemaleDescription,
        ),
        InformationDescriptionItem(
          title: '${context.translate.cisgenderMaleTitle}: ',
          description: context.translate.cisgenderMaleDescription,
        ),
        InformationDescriptionItem(
          title: '${context.translate.transgenderFemaleTitle}: ',
          description: context.translate.transgenderFemaleDescription,
        ),
        InformationDescriptionItem(
          title: '${context.translate.transgenderMaleTitle}: ',
          description: context.translate.transgenderMaleDescription,
        ),
        InformationDescriptionItem(
          title: '${context.translate.nonBinaryTitle}: ',
          description: context.translate.nonBinaryDescription,
        ),
        InformationDescriptionItem(
          title: '${context.translate.other}: ',
          description: context.translate.otherDescription,
        ),
      ],
    );
  }
}
