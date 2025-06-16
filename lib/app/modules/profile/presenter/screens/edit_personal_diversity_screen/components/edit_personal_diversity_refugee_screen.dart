import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/enums/analytics/analytics_event_enum.dart';
import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/helper/enum_helper.dart';

import '../../../../../../core/widgets/information_widget.dart';
import '../../../../../../core/widgets/waapi_bottomsheet.dart';
import '../../../../enums/refugee_answer_enum.dart';
import '../bloc/edit_personal_diversity_screen_bloc.dart';
import '../bloc/edit_personal_diversity_screen_state.dart';

class EditPersonalDiversityRefugeeScreen extends StatefulWidget {
  final TextEditingController refugeeController;

  const EditPersonalDiversityRefugeeScreen({
    Key? key,
    required this.refugeeController,
  }) : super(key: key);

  @override
  State<EditPersonalDiversityRefugeeScreen> createState() {
    return _EditPersonalDiversityGenderScreen();
  }
}

class _EditPersonalDiversityGenderScreen extends State<EditPersonalDiversityRefugeeScreen> {
  late final EditPersonalDiversityScreenBloc _editPersonalDiversityScreenBloc;
  late final String yesRefugee;
  late final String noRefugee;
  late final String noAnswerRefugee;

  @override
  void initState() {
    super.initState();
    _editPersonalDiversityScreenBloc = Modular.get<EditPersonalDiversityScreenBloc>();
    yesRefugee = EnumHelper().enumToString(enumToParse: RefugeeAnswerEnum.yes).toUpperCase();
    noRefugee = EnumHelper().enumToString(enumToParse: RefugeeAnswerEnum.no).toUpperCase();
    noAnswerRefugee = EnumHelper().enumToString(enumToParse: RefugeeAnswerEnum.noAnswer).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);
    return BlocBuilder<EditPersonalDiversityScreenBloc, EditPersonalDiversityScreenState>(
      bloc: _editPersonalDiversityScreenBloc,
      builder: (context, state) {
        return ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: SeniorSpacing.normal,
          ),
          children: [
            SeniorText.h4(
              context.translate.refugeBrazil,
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: SeniorSpacing.normal,
              ),
              child: Row(
                children: [
                  const SeniorIcon(
                    icon: FontAwesomeIcons.solidCircleInfo,
                    style: SeniorIconStyle(
                      color: SeniorColors.manchesterColorBlue500,
                    ),
                    size: SeniorIconSize.small,
                  ),
                  const SizedBox(
                    width: SeniorSpacing.xsmall,
                  ),
                  SeniorText.body(
                    context.translate.optionalQuestions,
                    color: SeniorColors.neutralColor600,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                SeniorText.label(context.translate.youRefugeBrazil),
                const SizedBox(
                  width: SeniorSpacing.small,
                ),
                GestureDetector(
                  child: SeniorText.smallBold(
                    context.translate.learnMore,
                    color: themeRepository.isCustomTheme()
                        ? SeniorServiceColor.getContrastAdjustedColorTheme(color: themeRepository.theme.primaryColor!)
                        : SeniorColors.primaryColor500,
                    darkColor: SeniorColors.primaryColor400,
                  ),
                  onTap: () {
                    WaapiBottomsheet.showDynamicBottomSheet(
                      context: context,
                      content: [
                        InformationWidget(
                          title: context.translate.refugeBrazil,
                          icon: FontAwesomeIcons.solidCircleInfo,
                          description: Column(
                            children: [
                              SeniorText.label(context.translate.refugeeDescription),
                              const SizedBox(
                                height: SeniorSpacing.small,
                              ),
                              SeniorText.label(context.translate.refugeeInBrazil),
                            ],
                          ),
                          onTapThumbsUp: () => log(AnalyticsEventEnum.usefulRefugeeInformation.toString()),
                          onTapThumbsDown: () => log(AnalyticsEventEnum.nonUsefulRefugeeInformation.toString()),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
            SeniorRadioButton(
              groupValue: widget.refugeeController.text == yesRefugee,
              onChanged: (_) {
                setState(() {
                  if (widget.refugeeController.text != yesRefugee) {
                    widget.refugeeController.text = yesRefugee;
                  } else {
                    widget.refugeeController.text = '';
                  }
                });
              },
              title: context.translate.yesRefugee,
              value: true,
            ),
            SeniorRadioButton(
              groupValue: widget.refugeeController.text == noRefugee,
              onChanged: (_) {
                setState(() {
                  if (widget.refugeeController.text != noRefugee) {
                    widget.refugeeController.text = noRefugee;
                  } else {
                    widget.refugeeController.text = '';
                  }
                });
              },
              title: context.translate.no,
              value: true,
            ),
            SeniorRadioButton(
              groupValue: widget.refugeeController.text == noAnswerRefugee,
              onChanged: (_) {
                setState(() {
                  if (widget.refugeeController.text != noAnswerRefugee) {
                    widget.refugeeController.text = noAnswerRefugee;
                  } else {
                    widget.refugeeController.text = '';
                  }
                });
              },
              title: context.translate.notAnswer,
              value: true,
            ),
          ],
        );
      },
    );
  }

  SeniorTextFieldStyle seniorTextFieldStyle() {
    return Provider.of<ThemeRepository>(context).isLightTheme()
        ? const SeniorTextFieldStyle(
            hintTextColor: SeniorColors.neutralColor900,
            textColor: SeniorColors.neutralColor900,
          )
        : const SeniorTextFieldStyle(
            hintTextColor: SeniorColors.pureWhite,
            textColor: SeniorColors.pureWhite,
          );
  }
}
