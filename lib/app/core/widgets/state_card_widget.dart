import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../extension/translate_extension.dart';
import 'waapi_card_widget.dart';

class StateCardWidget extends StatelessWidget {
  final String message;
  final String? descriptionMessage;
  final bool showButton;
  final String? textButton;
  final VoidCallback? onTap;
  final EdgeInsets? margin;
  final IconData iconData;
  final bool disabled;

  const StateCardWidget({
    Key? key,
    required this.message,
    this.descriptionMessage,
    this.showButton = false,
    this.onTap,
    this.textButton,
    this.margin = const EdgeInsets.only(
      bottom: SeniorSpacing.normal,
      left: SeniorSpacing.small,
      right: SeniorSpacing.small,
    ),
    required this.iconData,
    required this.disabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WaapiCardWidget(
      disabled: disabled,
      margin: margin,
      showActionIcon: false,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SeniorGradientIcon(
            icon: iconData,
            sizeIcon: SeniorSpacing.big,
            boxSize: SeniorSpacing.xbig,
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SeniorText.label(
                  message,
                  color: SeniorColors.pureBlack,
                ),
                if (descriptionMessage != null)
                  const SizedBox(
                    height: SeniorSpacing.small,
                  ),
                if (descriptionMessage != null)
                  SeniorText.small(
                    descriptionMessage!,
                    color: SeniorColors.secondaryColor700,
                  ),
                if (descriptionMessage != null)
                  const SizedBox(
                    height: SeniorSpacing.small,
                  ),
                Visibility(
                  visible: onTap != null && showButton,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: descriptionMessage != null ? 0 : SeniorSpacing.small,
                    ),
                    child: InkWell(
                      onTap: onTap,
                      child: SeniorText.smallBold(
                        textButton ?? context.translate.tryAgain,
                        textProperties: const TextProperties(
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
