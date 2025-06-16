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
import '../../../../../../core/widgets/waapi_loading_widget.dart';
import '../../../../domain/entities/gender_identity_entity.dart';
import '../../../../domain/entities/sexual_orientation_entity.dart';
import '../../../../enums/social_name_answer_enum.dart';
import '../../../blocs/gender_identity_bloc/gender_identity_bloc.dart';
import '../../../blocs/gender_identity_bloc/gender_identity_state.dart';
import '../../../blocs/sexual_orientation_bloc/sexual_orientation_bloc.dart';
import '../../../blocs/sexual_orientation_bloc/sexual_orientation_state.dart';
import '../bloc/edit_personal_diversity_screen_bloc.dart';
import '../bloc/edit_personal_diversity_screen_state.dart';
import '../widgets/gender_identities_description_widget.dart';
import '../widgets/sexual_orientarion_description_widget.dart';
import '../widgets/social_name_description_widget.dart';

class EditPersonalDiversityGenderScreen extends StatefulWidget {
  final TextEditingController genderController;
  final TextEditingController genderAutoDescriptionController;
  final TextEditingController affirmativeSocialNameController;
  final TextEditingController descriptionSocialNameController;
  final TextEditingController sexualOrientationController;
  final TextEditingController sexualOrientationAutoDescriptionController;

  const EditPersonalDiversityGenderScreen({
    Key? key,
    required this.genderController,
    required this.genderAutoDescriptionController,
    required this.affirmativeSocialNameController,
    required this.descriptionSocialNameController,
    required this.sexualOrientationController,
    required this.sexualOrientationAutoDescriptionController,
  }) : super(key: key);

  @override
  State<EditPersonalDiversityGenderScreen> createState() {
    return _EditPersonalDiversityGenderScreen();
  }
}

class _EditPersonalDiversityGenderScreen extends State<EditPersonalDiversityGenderScreen> {
  late final EditPersonalDiversityScreenBloc _editPersonalDiversityScreenBloc;
  late final List<GenderIdentityEntity> genderIdentities;
  late final List<SexualOrientationEntity> sexualOrientations;
  late final String yesSocialName;
  late final String noSocialName;
  late final String noAnswerSocialName;
  FocusNode genderIdentityAutoDescriptionFocus = FocusNode();
  FocusNode sexualOrientationAutoDescriptionFocus = FocusNode();
  FocusNode socialNameFocus = FocusNode();
  final genderIdentityOtherOptionId = '1fcf0377-d222-4060-a6a6-5531c3a0de51';
  final sexualOrientationOtherOptionId = '25c15235-f663-4e3e-9f31-07ce2dc82baf';

  @override
  void initState() {
    super.initState();
    yesSocialName = EnumHelper().enumToString(enumToParse: SocialNameAnswerEnum.yes).toUpperCase();
    noSocialName = EnumHelper().enumToString(enumToParse: SocialNameAnswerEnum.no).toUpperCase();
    noAnswerSocialName = EnumHelper().enumToString(enumToParse: SocialNameAnswerEnum.noAnswer).toUpperCase();
    _editPersonalDiversityScreenBloc = Modular.get<EditPersonalDiversityScreenBloc>();
    if (_editPersonalDiversityScreenBloc.getGenderIdentityBloc.state is LoadedGenderIdentityState) {
      genderIdentities = _editPersonalDiversityScreenBloc.getGenderIdentityBloc.state.genderIdentities;
      genderIdentities.sort(
        (a, b) => a.sequence.compareTo(b.sequence),
      );
    }

    if (_editPersonalDiversityScreenBloc.getSexualOrientationBloc.state is LoadedSexualOrientationState) {
      sexualOrientations = _editPersonalDiversityScreenBloc.getSexualOrientationBloc.state.sexualOrientations;
      sexualOrientations.sort(
        (a, b) => a.sequence.compareTo(b.sequence),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);
    return MultiBlocListener(
      listeners: [
        BlocListener<GenderIdentityBloc, GenderIdentityState>(
          bloc: _editPersonalDiversityScreenBloc.getGenderIdentityBloc,
          listener: (context, state) {
            if (state is LoadedGenderIdentityState) {
              genderIdentities = state.genderIdentities;
              genderIdentities.sort(
                (a, b) => a.sequence.compareTo(b.sequence),
              );
            }
          },
        ),
        BlocListener<SexualOrientationBloc, SexualOrientationState>(
          bloc: _editPersonalDiversityScreenBloc.getSexualOrientationBloc,
          listener: (context, state) {
            if (state is LoadedSexualOrientationState) {
              sexualOrientations = state.sexualOrientations;
              sexualOrientations.sort(
                (a, b) => a.sequence.compareTo(b.sequence),
              );
            }
          },
        ),
      ],
      child: BlocBuilder<EditPersonalDiversityScreenBloc, EditPersonalDiversityScreenState>(
        bloc: _editPersonalDiversityScreenBloc,
        builder: (context, state) {
          final isLoading = (state.getGenderIdentityState is! LoadedGenderIdentityState);

          if (isLoading) {
            return Center(
              child: Container(
                padding: const EdgeInsets.only(
                  top: SeniorSpacing.normal,
                ),
                alignment: Alignment.topCenter,
                child: const WaapiLoadingWidget(
                  key: Key('profile-edit_personal_diversity_gender-loading'),
                ),
              ),
            );
          }

          final notSocialName = [
            'cd7a7f1c-4cbe-4fb1-a19c-90e188445122',
            'e1e24eb6-8a42-41fd-b565-8a2bf008a6cf',
            'f6755009-49a3-438d-9bcc-0603a1c97f0b',
          ];

          return ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: SeniorSpacing.normal,
            ),
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: SeniorSpacing.normal,
                ),
                child: SeniorText.h4(
                  context.translate.genderOrientation,
                ),
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
                  Expanded(
                    child: SeniorText.label(
                      context.translate.yourGenderIdentity,
                      textProperties: const TextProperties(
                        softWrap: true,
                        overflow: TextOverflow.visible,
                        maxLines: 2,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: SeniorSpacing.small,
                  ),
                  GestureDetector(
                    child: SeniorText.smallBold(
                      context.translate.learnMore,
                      color: themeRepository.isCustomTheme()
                          ? SeniorServiceColor.getContrastAdjustedColorTheme(
                              color: themeRepository.theme.primaryColor!)
                          : SeniorColors.primaryColor,
                      darkColor: SeniorColors.primaryColor400,
                    ),
                    onTap: () {
                      WaapiBottomsheet.showDynamicBottomSheet(
                        context: context,
                        content: [
                          InformationWidget(
                            title: context.translate.genderIdentities,
                            icon: FontAwesomeIcons.solidCircleInfo,
                            description: const GenderIdentitiesDescription(),
                            onTapThumbsUp: onTapInformation(
                              analyticsInformation: AnalyticsEventEnum.usefulGenderIdentityInformation,
                            ),
                            onTapThumbsDown: onTapInformation(
                              analyticsInformation: AnalyticsEventEnum.nonUsefulGenderIdentityInformation,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: SeniorSpacing.xsmall,
              ),
              SeniorText.small(context.translate.cisgender),
              SeniorText.small(context.translate.transgender),
              ListView.builder(
                padding: const EdgeInsets.only(top: SeniorSpacing.normal),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      SeniorRadioButton<bool>(
                        groupValue: widget.genderController.text == genderIdentities[index].id,
                        onChanged: (_) {
                          if (widget.genderController.text == genderIdentities[index].id) {
                            widget.genderController.text = '';
                          } else {
                            widget.genderController.text = genderIdentities[index].id;
                          }

                          setState(() {});

                          if (widget.genderController.text == genderIdentityOtherOptionId) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              genderIdentityAutoDescriptionFocus.requestFocus();
                            });
                          } else {
                            widget.genderAutoDescriptionController.text = '';
                          }

                          if (!notSocialName.contains(widget.genderController.text)) {
                            widget.affirmativeSocialNameController.text = '';
                            widget.descriptionSocialNameController.text = '';
                          }
                        },
                        title: genderIdentities[index].name,
                        value: true,
                      ),
                      if (genderIdentities[index].id == genderIdentityOtherOptionId)
                        Padding(
                          padding: const EdgeInsets.only(left: SeniorSpacing.xmedium),
                          child: SeniorTextField(
                            disabled: widget.genderController.text != genderIdentityOtherOptionId,
                            controller: widget.genderAutoDescriptionController,
                            label: context.translate.selfDescription,
                            style: seniorTextFieldStyle(),
                            focusNode: genderIdentityAutoDescriptionFocus,
                            textInputAction: TextInputAction.done,
                          ),
                        ),
                    ],
                  );
                },
                itemCount: genderIdentities.length,
              ),
              if (widget.genderController.text.isNotEmpty && !notSocialName.contains(widget.genderController.text))
                Padding(
                  padding: const EdgeInsets.only(top: SeniorSpacing.xmedium),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(child: SeniorText.label(context.translate.adoptedSocialName)),
                          const SizedBox(
                            width: SeniorSpacing.small,
                          ),
                          GestureDetector(
                            child: SeniorText.smallBold(
                              context.translate.learnMore,
                              color: SeniorServiceColor.getContrastAdjustedColorTheme(
                                color: themeRepository.theme.primaryColor!,
                              ),
                              darkColor: SeniorColors.primaryColor400,
                            ),
                            onTap: () {
                              WaapiBottomsheet.showDynamicBottomSheet(
                                context: context,
                                content: [
                                  InformationWidget(
                                    title: context.translate.socialName,
                                    icon: FontAwesomeIcons.solidCircleInfo,
                                    description: const SocialNameDescription(),
                                    onTapThumbsUp: onTapInformation(
                                      analyticsInformation: AnalyticsEventEnum.usefulSocialNameInformation,
                                    ),
                                    onTapThumbsDown: onTapInformation(
                                      analyticsInformation: AnalyticsEventEnum.nonUsefulSocialNameInformation,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                      SeniorRadioButton(
                        groupValue: widget.affirmativeSocialNameController.text == yesSocialName,
                        onChanged: (_) {
                          setState(() {
                            if (widget.affirmativeSocialNameController.text != yesSocialName) {
                              widget.affirmativeSocialNameController.text = yesSocialName;
                            } else {
                              widget.affirmativeSocialNameController.text = '';
                              widget.descriptionSocialNameController.text = '';
                            }

                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              socialNameFocus.requestFocus();
                            });
                          });
                        },
                        title: context.translate.yes,
                        value: true,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: SeniorSpacing.xmedium),
                        child: SeniorTextField(
                          focusNode: socialNameFocus,
                          disabled: widget.affirmativeSocialNameController.text != yesSocialName,
                          controller: widget.descriptionSocialNameController,
                          label: context.translate.socialName,
                          style: seniorTextFieldStyle(),
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                      SeniorRadioButton(
                        groupValue: widget.affirmativeSocialNameController.text == noSocialName,
                        onChanged: (_) {
                          setState(() {
                            if (widget.affirmativeSocialNameController.text != noSocialName) {
                              widget.affirmativeSocialNameController.text = noSocialName;
                            } else {
                              widget.affirmativeSocialNameController.text = '';
                            }
                          });
                        },
                        title: context.translate.no,
                        value: true,
                      ),
                      SeniorRadioButton(
                        groupValue: widget.affirmativeSocialNameController.text == noAnswerSocialName,
                        onChanged: (_) {
                          setState(() {
                            if (widget.affirmativeSocialNameController.text != noAnswerSocialName) {
                              widget.affirmativeSocialNameController.text = noAnswerSocialName;
                            } else {
                              widget.affirmativeSocialNameController.text = '';
                            }
                          });
                        },
                        title: context.translate.notAnswer,
                        value: true,
                      ),
                    ],
                  ),
                ),
              const SizedBox(
                height: SeniorSpacing.normal,
              ),
              Row(
                children: [
                  Expanded(
                    child: SeniorText.label(
                      context.translate.yourSexualOrientation,
                      textProperties: const TextProperties(
                        softWrap: true,
                        overflow: TextOverflow.visible,
                        maxLines: 2,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: SeniorSpacing.small,
                  ),
                  GestureDetector(
                    child: SeniorText.smallBold(
                      context.translate.learnMore,
                      color: themeRepository.isCustomTheme()
                          ? SeniorServiceColor.getContrastAdjustedColorTheme(
                              color: themeRepository.theme.primaryColor!)
                          : SeniorColors.primaryColor,
                      darkColor: SeniorColors.primaryColor400,
                    ),
                    onTap: () {
                      WaapiBottomsheet.showDynamicBottomSheet(
                        context: context,
                        content: [
                          InformationWidget(
                            title: context.translate.sexualOrientation,
                            icon: FontAwesomeIcons.solidCircleInfo,
                            description: const SexualOrientationDescription(),
                            onTapThumbsUp: onTapInformation(
                              analyticsInformation: AnalyticsEventEnum.usefulSexualOrientationInformation,
                            ),
                            onTapThumbsDown: onTapInformation(
                              analyticsInformation: AnalyticsEventEnum.nonUsefulSexualOrientationInformation,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
              ListView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      SeniorRadioButton<bool>(
                        groupValue: widget.sexualOrientationController.text == sexualOrientations[index].id,
                        onChanged: (_) {
                          if (widget.sexualOrientationController.text == sexualOrientations[index].id) {
                            widget.sexualOrientationController.text = '';
                          } else {
                            widget.sexualOrientationController.text = sexualOrientations[index].id;
                          }

                          setState(() {});

                          if (widget.sexualOrientationController.text == sexualOrientationOtherOptionId) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              sexualOrientationAutoDescriptionFocus.requestFocus();
                            });
                          } else {
                            widget.sexualOrientationAutoDescriptionController.text = '';
                          }
                        },
                        title: sexualOrientations[index].name,
                        value: true,
                      ),
                      if (sexualOrientations[index].id == sexualOrientationOtherOptionId)
                        Padding(
                          padding: const EdgeInsets.only(left: SeniorSpacing.xmedium),
                          child: SeniorTextField(
                            disabled: widget.sexualOrientationController.text != sexualOrientationOtherOptionId,
                            controller: widget.sexualOrientationAutoDescriptionController,
                            label: context.translate.selfDescribe,
                            style: seniorTextFieldStyle(),
                            focusNode: sexualOrientationAutoDescriptionFocus,
                            textInputAction: TextInputAction.done,
                          ),
                        ),
                    ],
                  );
                },
                itemCount: sexualOrientations.length,
              ),
            ],
          );
        },
      ),
    );
  }

  SeniorTextFieldStyle seniorTextFieldStyle() {
    return Provider.of<ThemeRepository>(context).isDarkTheme()
        ? const SeniorTextFieldStyle(
            hintTextColor: SeniorColors.pureWhite,
            textColor: SeniorColors.pureWhite,
          )
        : const SeniorTextFieldStyle(
            hintTextColor: SeniorColors.neutralColor900,
            textColor: SeniorColors.neutralColor900,
          );
  }

  VoidCallback onTapInformation({required AnalyticsEventEnum analyticsInformation}) {
    return () {
      Modular.to.pop();
      WaapiBottomsheet.showDynamicBottomSheet(
        context: context,
        content: [
          const InformationWidget(
            isThank: true,
          ),
        ],
      );
    };
  }
}
