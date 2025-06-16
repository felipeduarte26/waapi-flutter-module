import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/extension/media_query_extension.dart';
import '../../../../../../core/extension/translate_extension.dart';

class RestrictionsBottomSheetWidget {
  static Future<dynamic> showBottomSheet({
    required BuildContext context,
    required List<String> messages,
    required bool isReview,
    VoidCallback? primaryButtonPressed,
    VoidCallback? secondaryButtonPressed,
  }) {
    return showModalBottomSheet(
      backgroundColor: Provider.of<ThemeRepository>(
        context,
        listen: false,
      ).theme.bottomSheetTheme!.style!.backgroundColor,
      enableDrag: false,
      context: context,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(SeniorRadius.huge),
          topRight: Radius.circular(SeniorRadius.huge),
        ),
      ),
      builder: ((_) {
        return Padding(
          padding: const EdgeInsets.only(
            top: SeniorSpacing.normal,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: SeniorSpacing.normal,
                  left: SeniorSpacing.normal,
                  right: SeniorSpacing.normal,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: SeniorText.label(
                        isReview ? context.translate.formCorrectionAlert : context.translate.wrongAlert,
                        color: SeniorColors.pureBlack,
                      ),
                    ),
                    if (isReview)
                      Padding(
                        padding: const EdgeInsets.only(
                          right: SeniorSpacing.normal,
                        ),
                        child: GestureDetector(
                          child: const SeniorIcon(
                            icon: FontAwesomeIcons.xmark,
                            style: SeniorIconStyle(
                              color: Colors.black,
                            ),
                            size: SeniorSpacing.medium,
                          ),
                          onTap: () {
                            Modular.to.pop();
                          },
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: Scrollbar(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: SeniorSpacing.normal,
                          left: SeniorSpacing.normal,
                          right: SeniorSpacing.normal,
                        ),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(
                                right: SeniorSpacing.xsmall,
                              ),
                              child: SeniorIcon(
                                icon: FontAwesomeIcons.solidCircleExclamation,
                                style: SeniorIconStyle(
                                  color: SeniorColors.manchesterColorRed500,
                                ),
                                size: SeniorSpacing.medium,
                              ),
                            ),
                            Expanded(
                              child: SeniorText.body(
                                messages[index],
                                color: SeniorColors.neutralColor800,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: SeniorSpacing.normal,
                  left: SeniorSpacing.normal,
                  right: SeniorSpacing.normal,
                  bottom: (isReview) ? SeniorSpacing.normal : 0,
                ),
                child: SeniorButton(
                  label: (isReview) ? context.translate.ok : context.translate.reviewForm,
                  onPressed: () {
                    if (isReview) {
                      Modular.to.pop();
                    } else {
                      primaryButtonPressed!();
                    }
                  },
                  fullWidth: true,
                ),
              ),
              if (!isReview)
                Padding(
                  padding: EdgeInsets.only(
                    top: SeniorSpacing.normal,
                    left: SeniorSpacing.normal,
                    right: SeniorSpacing.normal,
                    bottom: SeniorSpacing.normal + context.bottomSize,
                  ),
                  child: SeniorButton.ghost(
                    label: context.translate.back,
                    onPressed: () {
                      secondaryButtonPressed!();
                    },
                    fullWidth: true,
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}
