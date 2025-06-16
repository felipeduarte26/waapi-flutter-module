import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../../../core/constants/assets_path.dart';
import '../../../../../core/enums/analytics/analytics_event_enum.dart';
import '../../../../../core/extension/media_query_extension.dart';
import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/widgets/waapi_colorful_header.dart';
import '../../../../../core/widgets/waapi_loading_widget.dart';
import '../../../../../routes/authentication_routes.dart';
import '../../../domain/enums/onboarding_view_key_enum.dart';
import '../../blocs/onboarding_bloc/onboarding_bloc.dart';
import '../../blocs/onboarding_bloc/onboarding_event.dart';
import '../../blocs/onboarding_bloc/onboarding_state.dart';
import '../../widgets/content_view_page_widget.dart';
import '../../widgets/onboarding_scaffold_widget.dart';

class OnboardingScreen extends StatefulWidget {
  final OnboardingBloc onboardingBloc;

  const OnboardingScreen({
    Key? key,
    required this.onboardingBloc,
  }) : super(key: key);

  @override
  State<OnboardingScreen> createState() {
    return _OnboardingScreenState();
  }
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int pagePresented = -1;
  int _nextStep = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _getAlreadyViewedOnboardingEvent();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;
    return BlocConsumer<OnboardingBloc, OnboardingState>(
      bloc: widget.onboardingBloc,
      listener: (context, state) {
        if (state is GoToNextPageState) {
          pagePresented++;
          _nextStep++;

          if (pagePresented > 0) {
            _pageController.animateToPage(
              pagePresented < 0 ? 0 : pagePresented,
              duration: const Duration(
                milliseconds: 500,
              ),
              curve: Curves.easeIn,
            );
          }
        }

        if (state is SkipStepOnboardingState) {
          _saveAlreadyViewedOnboardingEvent();
        }

        if (state is VisualizedOnboardingState) {
          Modular.to.pushReplacementNamed(AuthenticationRoutes.authenticationModuleRoute);
        }

        if (state is NotVisualizedOnboardingState) {
          ClearStoredDataUsecase();
          _nextPageOnboardingEvent();
        }
      },
      builder: (context, state) {
        if (state is InitialOnboardingState || state is VisualizedOnboardingState) {
          return WaapiColorfulHeader(
            titleLabel: context.translate.appTitle,
            hideLeading: true,
            body: Padding(
              padding: const EdgeInsets.only(
                top: SeniorSpacing.xsmall,
              ),
              child: SizedBox(
                width: context.widthSize,
                child: const WaapiLoadingWidget(),
              ),
            ),
          );
        }

        return SafeArea(
          child: OnboardingScaffoldWidget(
            contentViewPageWidgets: [
              ContentViewPageWidget(
                key: const Key('onboarding-onboarding_screen-step_one'),
                onJump: () => _setOnboardingJumpEvent(
                  step: 1,
                ),
                imagePath: AssetsPath.onboardingStepOne,
                textContent: Row(
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: context.translate.onboardingMainTextFirstPresentation,
                          style: SeniorTypography.label(
                            color: SeniorColors.neutralColor500,
                          ).copyWith(
                            overflow: TextOverflow.ellipsis,
                            height: 1.5,
                          ),
                          children: [
                            TextSpan(
                              text: context.translate.onboardingUseSenior,
                              style: SeniorTypography.label(
                                color: SeniorColors.primaryColor500,
                              ),
                            ),
                            TextSpan(
                              text: context.translate.onboardingTo,
                            ),
                            TextSpan(
                              text: context.translate.onboardingConnect,
                              style: SeniorTypography.label(
                                color: SeniorColors.primaryColor500,
                              ),
                            ),
                            TextSpan(
                              text: context.translate.onboardingWithYourCollaborators,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ContentViewPageWidget(
                key: const Key('onboarding-onboarding_screen-step_two'),
                onJump: () => _setOnboardingJumpEvent(
                  step: 2,
                ),
                imagePath: AssetsPath.onboardingStepTwo,
                textContent: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: context.translate.onboardingMainTextSecondPresentation,
                        style: SeniorTypography.label(
                          color: SeniorColors.neutralColor500,
                        ).copyWith(
                          overflow: TextOverflow.ellipsis,
                          height: 1.5,
                        ),
                        children: [
                          TextSpan(
                            text: context.translate.appTitle,
                            style: SeniorTypography.label(
                              color:
                                  theme == SENIOR_DARK_THEME ? SeniorColors.pureWhite : SeniorColors.secondaryColor900,
                            ),
                          ),
                          TextSpan(
                            text: context.translate.onboardingMainTextSecondAdditional,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: SeniorSpacing.xsmall,
                    ),
                    SeniorText.label(
                      context.translate.onboardingQuestionCompany,
                      color: SeniorColors.secondaryColor900,
                      darkColor: theme.textTheme!.labelStyle!.color,
                    ),
                    const SizedBox(
                      height: SeniorSpacing.xsmall,
                    ),
                    Platform.isIOS
                        ? Padding(
                            padding: const EdgeInsets.only(
                              right: SeniorSpacing.xsmall,
                            ),
                            child: RichText(
                              text: TextSpan(
                                text: context.translate.onboardingSecondMeetIos,
                                style: SeniorTypography.label(
                                  color: SeniorColors.neutralColor500,
                                ).copyWith(
                                  overflow: TextOverflow.ellipsis,
                                  height: 1.5,
                                ),
                                children: [
                                  TextSpan(
                                    text: context.translate.seniorSistemas,
                                    style: SeniorTypography.label(
                                      color: SeniorColors.primaryColor500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Row(
                            children: [
                              SeniorText.label(
                                context.translate.onboardingSecondMeet,
                                style: TextStyle(
                                  color: theme == SENIOR_DARK_THEME
                                      ? SeniorColors.pureWhite
                                      : SeniorColors.secondaryColor900,
                                ).copyWith(
                                  overflow: TextOverflow.ellipsis,
                                  height: 1.5,
                                ),
                                darkColor: theme.textTheme!.labelStyle!.color,
                              ),
                              GestureDetector(
                                onTap: () => _openExternalUrlEvent(
                                  externalUrl: 'https://www.senior.com.br/',
                                ),
                                child: SeniorText.label(
                                  context.translate.seniorSistemas,
                                  style: const TextStyle(
                                    color: SeniorColors.primaryColor500,
                                  ).copyWith(
                                    decoration: TextDecoration.underline,
                                  ),
                                  darkColor: theme.textTheme!.labelStyle!.color,
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
              ContentViewPageWidget(
                showJump: false,
                key: const Key('onboarding-onboarding_screen-step_three'),
                onJump: () => _setOnboardingJumpEvent(
                  step: 3,
                ),
                imagePath: AssetsPath.onboardingStepThree,
                textContent: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: context.translate.onboardingMainTextThirdPresentation,
                        style: SeniorTypography.label(
                          color: SeniorColors.neutralColor500,
                        ).copyWith(
                          overflow: TextOverflow.ellipsis,
                          height: 1.5,
                        ),
                        children: [
                          TextSpan(
                            text: context.translate.onboardingSeniorX,
                            style: SeniorTypography.label(
                              color:
                                  theme == SENIOR_DARK_THEME ? SeniorColors.pureWhite : SeniorColors.secondaryColor900,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: SeniorSpacing.xxsmall,
                    ),
                    Platform.isIOS
                        ? const SizedBox.shrink()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SeniorText.label(
                                context.translate.onboardingGetAccess,
                                color: SeniorColors.secondaryColor900,
                                darkColor: theme.textTheme!.labelStyle!.color,
                              ),
                              const SizedBox(
                                height: SeniorSpacing.xsmall,
                              ),
                              GestureDetector(
                                onTap: () => _openExternalUrlEvent(
                                  externalUrl: 'www.senior.com.br/senior-x',
                                ),
                                child: SeniorText.label(
                                  context.translate.onboardingLinkSeniorX,
                                  style: const TextStyle(
                                    color: SeniorColors.primaryColor500,
                                  ).copyWith(
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ],
            pageController: _pageController,
            nextPageOnboardingEvent: _nextPageOnboardingEvent,
          ),
        );
      },
    );
  }

  void _nextPageOnboardingEvent() {
    widget.onboardingBloc.add(
      NextPageOnboardingEvent(
        analyticsEventEnum: AnalyticsEventEnum.onboardingView,
        step: _nextStep,
        maxSteps: 3,
      ),
    );
  }

  void _saveAlreadyViewedOnboardingEvent() {
    widget.onboardingBloc.add(
      const SaveAlreadyViewedOnboardingEvent(
        onboardingViewKeyEnum: OnboardingViewKeyEnum.onboarding,
        visualized: true,
      ),
    );
  }

  void _getAlreadyViewedOnboardingEvent() {
    widget.onboardingBloc.add(
      const GetAlreadyViewedOnboardingEvent(
        onboardingViewKeyEnum: OnboardingViewKeyEnum.onboarding,
        isReview: false,
      ),
    );
  }

  void _setOnboardingJumpEvent({
    required int step,
  }) {
    widget.onboardingBloc.add(
      SetOnboardingJumpEvent(
        step: step,
        onboardingViewKeyEnum: OnboardingViewKeyEnum.onboarding,
        analyticsEventEnum: AnalyticsEventEnum.onboardingSkip,
      ),
    );
  }

  void _openExternalUrlEvent({
    required String externalUrl,
  }) {
    widget.onboardingBloc.add(
      OpenExternalUrlEvent(
        externalUrl: externalUrl,
      ),
    );
  }
}
