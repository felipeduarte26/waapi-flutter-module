import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../core/constants/assets_path.dart';
import '../../../../../core/enums/analytics/analytics_event_enum.dart';
import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/helper/enum_helper.dart';
import '../../../../../core/widgets/error_state_widget.dart';
import '../../../../../core/widgets/information_widget.dart';
import '../../../../../core/widgets/waapi_bottomsheet.dart';
import '../../../../../core/widgets/waapi_colorful_header.dart';
import '../../../../../core/widgets/waapi_loading_widget.dart';
import '../../../../../core/widgets/waapi_page_view_widget.dart';
import '../../../domain/input_models/edit_personal_diversity_input_model.dart';
import '../../../enums/social_name_answer_enum.dart';
import '../../blocs/diversity_bloc/diversity_bloc.dart';
import '../../blocs/diversity_bloc/diversity_event.dart';
import '../../blocs/diversity_bloc/diversity_state.dart';
import '../../blocs/gender_identity_bloc/gender_identity_event.dart';
import '../../blocs/gender_identity_bloc/gender_identity_state.dart';
import '../../blocs/sexual_orientation_bloc/sexual_orientation_event.dart';
import '../../blocs/sexual_orientation_bloc/sexual_orientation_state.dart';
import '../../blocs/update_personal_diversity_bloc/update_personal_diversity_bloc.dart';
import '../../blocs/update_personal_diversity_bloc/update_personal_diversity_event.dart';
import '../../blocs/update_personal_diversity_bloc/update_personal_diversity_state.dart';
import 'bloc/edit_personal_diversity_screen_bloc.dart';
import 'bloc/edit_personal_diversity_screen_state.dart';
import 'components/edit_personal_diversity_gender_screen.dart';
import 'components/edit_personal_diversity_refugee_screen.dart';

class EditPersonalDiversityScreen extends StatefulWidget {
  final String personId;

  const EditPersonalDiversityScreen({
    super.key,
    required this.personId,
  });

  @override
  State<EditPersonalDiversityScreen> createState() {
    return _EditPersonalDiversityScreenState();
  }
}

class _EditPersonalDiversityScreenState extends State<EditPersonalDiversityScreen> {
  final PageController _pageController = PageController();
  late final EditPersonalDiversityScreenBloc _editPersonalDiversityScreenBloc;
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _genderAutoDescriptionController = TextEditingController();
  final TextEditingController _affirmativeSocialNameController = TextEditingController();
  final TextEditingController _descriptionSocialNameController = TextEditingController();
  final TextEditingController _sexualOrientationController = TextEditingController();
  final TextEditingController _sexualOrientatioAutoDescriptionController = TextEditingController();
  final TextEditingController _refugeeController = TextEditingController();

  var currentStep = 1;
  bool isLoadingSubmit = false;

  @override
  void initState() {
    super.initState();
    _editPersonalDiversityScreenBloc = Modular.get<EditPersonalDiversityScreenBloc>();
    _editPersonalDiversityScreenBloc.getGenderIdentityBloc.add(GetGenderIdentityProfileEvent());
    _editPersonalDiversityScreenBloc.getSexualOrientationBloc.add(GetSexualOrientationProfileEvent());
    _editPersonalDiversityScreenBloc.getDiversityBloc.add(GetDiversityEvent(personId: widget.personId));

    _genderController.addListener(() {
      setState(() {});
    });
    _genderAutoDescriptionController.addListener(() {
      setState(() {});
    });
    _affirmativeSocialNameController.addListener(() {
      setState(() {});
    });
    _descriptionSocialNameController.addListener(() {
      setState(() {});
    });
    _sexualOrientationController.addListener(() {
      setState(() {});
    });
    _sexualOrientatioAutoDescriptionController.addListener(() {
      setState(() {});
    });
    _refugeeController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<UpdatePersonalDiversityBloc, UpdatePersonalDiversityState>(
          bloc: _editPersonalDiversityScreenBloc.updatePersonalDiversityBloc,
          listener: ((context, state) {
            isLoadingSubmit = (state is LoadingUpdatePersonalDiversityState);

            if (state is SentUpdatePersonalDiversityState) {
              Modular.to.pop(true);
              Modular.to.pop(true);

              ScaffoldMessenger.of(context).showSnackBar(
                SeniorSnackBar.success(
                  message: context.translate.selfDeclarationSuccess,
                ),
              );
            }

            if (state is ErrorUpdatePersonalDiversityState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SeniorSnackBar.error(
                  message: context.translate.alertErrorSubmit,
                  action: SeniorSnackBarAction(
                    label: context.translate.repeat,
                    onPressed: () => _sendUpdatePersonalDiversity(),
                  ),
                ),
              );
            }
          }),
        ),
        BlocListener<DiversityBloc, DiversityState>(
          bloc: _editPersonalDiversityScreenBloc.getDiversityBloc,
          listener: (context, state) {
            if (state is LoadedDiversityState) {
              _affirmativeSocialNameController.text =
                  EnumHelper().enumToString(enumToParse: state.diversityEntity?.diversity?.socialNameAnswer);
              _genderAutoDescriptionController.text = state.diversityEntity?.diversity?.genderIdentityDescription ?? '';
              _genderController.text = state.diversityEntity?.diversity?.genderIdentity?.id ?? '';
              _descriptionSocialNameController.text = state.diversityEntity?.diversity?.socialNameDescription ?? '';
              _sexualOrientationController.text = state.diversityEntity?.diversity?.sexualOrientation?.id ?? '';
              _sexualOrientatioAutoDescriptionController.text =
                  state.diversityEntity?.diversity?.sexualOrientationDescription ?? '';
              _refugeeController.text =
                  EnumHelper().enumToString(enumToParse: state.diversityEntity?.diversity?.refugee);
            }
          },
        ),
      ],
      child: BlocBuilder<EditPersonalDiversityScreenBloc, EditPersonalDiversityScreenState>(
        bloc: _editPersonalDiversityScreenBloc,
        builder: (context, state) {
          if (state.getGenderIdentityState is LoadingGenderIdentityState ||
              state.getSexualOrientationState is LoadingSexualOrientationState ||
              state.getDiversityState is LoadingDiversityState) {
            return Scaffold(
              body: WaapiColorfulHeader(
                titleLabel: context.translate.selfDeclaration,
                body: const Center(
                  child: WaapiLoadingWidget(),
                ),
              ),
            );
          }

          if (state.getGenderIdentityState is ErrorGenderIdentityState ||
              state.getSexualOrientationState is ErrorSexualOrientationState ||
              state.getDiversityState is ErrorDiversityState) {
            return Scaffold(
              body: WaapiColorfulHeader(
                titleLabel: context.translate.selfDeclaration,
                body: Center(
                  child: ErrorStateWidget(
                    title: context.translate.selfDeclarationError,
                    subTitle: context.translate.selfDeclarationErrorDescription,
                    onTapTryAgain: () {
                      if (state.getGenderIdentityState is ErrorGenderIdentityState) {
                        _editPersonalDiversityScreenBloc.getGenderIdentityBloc.add(GetGenderIdentityProfileEvent());
                      }

                      if (state.getSexualOrientationState is ErrorSexualOrientationState) {
                        _editPersonalDiversityScreenBloc.getSexualOrientationBloc
                            .add(GetSexualOrientationProfileEvent());
                      }

                      if (state.getDiversityState is ErrorDiversityState) {
                        _editPersonalDiversityScreenBloc.getDiversityBloc
                            .add(GetDiversityEvent(personId: widget.personId));
                      }
                    },
                    imagePath: AssetsPath.generalErrorState,
                  ),
                ),
              ),
            );
          }

          return WaapiPageViewWidget(
            pageController: _pageController,
            actions: [
              IconButton(
                onPressed: () {
                  WaapiBottomsheet.showDynamicBottomSheet(
                    context: context,
                    content: [
                      InformationWidget(
                        title: context.translate.selfDeclarationExplanationTitle,
                        icon: FontAwesomeIcons.solidCircleQuestion,
                        description: Column(
                          children: [
                            SeniorText.label(context.translate.selfDeclarationExplanation),
                            const SizedBox(
                              height: SeniorSpacing.small,
                            ),
                            SeniorText.label(context.translate.selfDeclarationExplanationDataSafety),
                          ],
                        ),
                        onTapThumbsUp: onTapInformation(
                          analyticsInformation: AnalyticsEventEnum.usefulSelfDeclarationInformation,
                        ),
                        onTapThumbsDown: onTapInformation(
                          analyticsInformation: AnalyticsEventEnum.nonUsefulSelfDeclarationInformation,
                        ),
                      ),
                    ],
                  );
                },
                icon: SeniorIcon(
                  icon: FontAwesomeIcons.solidCircleQuestion,
                  style: SeniorIconStyle(
                    color: themeRepository.isCustomTheme()
                        ? SeniorServiceColor.getOptimalContrastColorTheme(color: themeRepository.theme.secondaryColor!)
                        : SeniorColors.pureWhite,
                  ),
                  size: SeniorIconSize.small,
                ),
              ),
            ],
            validationExitIncompleteAction: true,
            listPagesViews: [
              EditPersonalDiversityGenderScreen(
                genderController: _genderController,
                genderAutoDescriptionController: _genderAutoDescriptionController,
                affirmativeSocialNameController: _affirmativeSocialNameController,
                descriptionSocialNameController: _descriptionSocialNameController,
                sexualOrientationAutoDescriptionController: _sexualOrientatioAutoDescriptionController,
                sexualOrientationController: _sexualOrientationController,
              ),
              EditPersonalDiversityRefugeeScreen(
                refugeeController: _refugeeController,
              ),
            ],
            loadedPages: true,
            disableTopButton: disableTopButton(),
            busyTopButton: busyButton(),
            currentStep: currentStep,
            onPressedGhostButtonDialog: () {
              Modular.to.pop();
            },
            onPressedActionButtonDialog: () {
              Modular.to.pop();
              Modular.to.pop();
            },
            onPressedTopButton: onPressedTopButton,
            labelTopButton: labelTopButton(context),
            disableBottomButton: disableBottomButton(),
            busyBottomButton: busyButton(),
            onPressedBottomButton: onPressedBottomButton,
            labelBottomButton: labelBottomButton(context),
            labelTitleDialog: context.translate.doYouWantToCancelFillingInThisForm,
            labelContentDialog: context.translate.ifYouConfirmYouWillLoseTheInformationEnteredInThisForm,
            labelActionButtonDialog: context.translate.confirm,
            labelGhostButtonDialog: context.translate.close,
            titleScreen: context.translate.selfDeclaration,
          );
        },
      ),
    );
  }

  bool goNextPage() {
    if (currentStep == 1) {
      return validateInputs();
    }

    return currentStep == 2;
  }

  bool validateInputs() {
    return true;
  }

  void onPressedBottomButton() {
    setState(() {
      _pageController.previousPage(
        duration: kTabScrollDuration,
        curve: Curves.easeIn,
      );
      currentStep--;
    });
    return;
  }

  void onPressedTopButton() {
    FocusScope.of(context).unfocus();
    if (currentStep < 2) {
      _pageController.nextPage(
        duration: kTabScrollDuration,
        curve: Curves.easeIn,
      );
      currentStep++;
      setState(() {});
      return;
    }

    _sendUpdatePersonalDiversity();
  }

  String labelTopButton(BuildContext context) {
    return currentStep == 2 ? context.translate.saveAndSubmit : context.translate.next;
  }

  String labelBottomButton(BuildContext context) {
    return currentStep > 1 ? context.translate.back : context.translate.optionCancel;
  }

  bool disableTopButton() {
    return !goNextPage() || busyButton();
  }

  bool disableBottomButton() {
    return busyButton();
  }

  bool busyButton() {
    return isLoadingSubmit;
  }

  void _sendUpdatePersonalDiversity() {
    final editPersonalDiversityInputModel = EditPersonalDiversityInputModel(
      personId: widget.personId,
      diversityId: _editPersonalDiversityScreenBloc.getDiversityBloc.state.diversityEntity?.diversity?.id,
      id: _editPersonalDiversityScreenBloc.getDiversityBloc.state.diversityEntity?.id,
      genderIdentityId: _genderController.text,
      genderIdentityDescription: _genderAutoDescriptionController.text,
      socialNameAnswer: _affirmativeSocialNameController.text,
      socialNameDescription: (_affirmativeSocialNameController.text ==
              EnumHelper<SocialNameAnswerEnum>().enumToString(enumToParse: SocialNameAnswerEnum.yes))
          ? _descriptionSocialNameController.text
          : null,
      sexualOrientationId: _sexualOrientationController.text,
      sexualOrientationDescription: _sexualOrientatioAutoDescriptionController.text,
      refugee: _refugeeController.text,
    );

    _editPersonalDiversityScreenBloc.updatePersonalDiversityBloc.add(
      SendUpdatePersonalDiversityEvent(
        editPersonalDiversityInputModel: editPersonalDiversityInputModel,
      ),
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
