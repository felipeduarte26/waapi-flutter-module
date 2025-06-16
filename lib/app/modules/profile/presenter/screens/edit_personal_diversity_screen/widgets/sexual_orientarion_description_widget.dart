import 'package:flutter/widgets.dart';

import '../../../../../../core/extension/translate_extension.dart';
import 'information_description_item_widget.dart';

class SexualOrientationDescription extends StatelessWidget {
  const SexualOrientationDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        InformationDescriptionItem(
          title: '',
          description: context.translate.sexualOrientationDescription,
        ),
        InformationDescriptionItem(
          title: '${context.translate.asexualTitle}: ',
          description: context.translate.asexualDescription,
        ),
        InformationDescriptionItem(
          title: '${context.translate.bisexualTitle}: ',
          description: context.translate.bisexualDescription,
        ),
        InformationDescriptionItem(
          title: '${context.translate.heterosexualTitle}: ',
          description: context.translate.heterosexualDescription,
        ),
        InformationDescriptionItem(
          title: '${context.translate.pansexualTitle}: ',
          description: context.translate.pansexualDescription,
        ),
      ],
    );
  }
}
