import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/enums/analytics/waapi_loading_size_enum.dart';
import '../../../../core/extension/translate_extension.dart';
import '../../../../core/widgets/waapi_loading_widget.dart';

class LoadingAttachmentCardWidget extends StatelessWidget {
  final double height;
  final double width;

  const LoadingAttachmentCardWidget({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: height / 2,
          width: width,
          color: SeniorColors.secondaryColor100,
          child: Padding(
            padding: const EdgeInsets.all(SeniorSpacing.xsmall),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: SeniorColors.pureWhite,
              ),
              child: const WaapiLoadingWidget(
                waapiLoadingSizeEnum: WaapiLoadingSizeEnum.small,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              top: SeniorSpacing.small,
              left: SeniorSpacing.normal,
              right: SeniorSpacing.normal,
              bottom: 10.0,
            ),
            child: SeniorText.body(
              '${context.translate.loading}...',
              key: const Key('attachment_card-loading-label'),
              color: SeniorColors.neutralColor900,
              textProperties: const TextProperties(
                maxLines: 1,
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(
            bottom: SeniorSpacing.normal,
            right: SeniorSpacing.normal,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SeniorIcon(
                icon: FontAwesomeIcons.solidTrash,
                style: SeniorIconStyle(
                  color: SeniorColors.secondaryColor200,
                ),
                size: 14.0,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
