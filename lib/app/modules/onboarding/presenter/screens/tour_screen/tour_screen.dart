import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/configuration/icollector_module_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/app_identifier_enum.dart';

import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../core/constants/assets_path.dart';
import '../../../../../core/constants/supported_locales.dart';
import '../../../../../core/enums/analytics/analytics_event_enum.dart';
import '../../../../../core/environment/environment_variables.dart';
import '../../../../../core/extension/media_query_extension.dart';
import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/helper/locale_helper.dart';
import '../../../../../core/widgets/waapi_colorful_header.dart';
import '../../../../../core/widgets/waapi_loading_widget.dart';
import '../../../../../routes/authentication_routes.dart';
import '../../../../../routes/home_routes.dart';
import '../../../domain/enums/onboarding_view_key_enum.dart';
import '../../blocs/onboarding_bloc/onboarding_bloc.dart';
import '../../blocs/onboarding_bloc/onboarding_event.dart';
import '../../blocs/onboarding_bloc/onboarding_state.dart';
import '../../widgets/content_view_page_widget.dart';
import '../../widgets/onboarding_scaffold_widget.dart';

class TourScreen extends StatefulWidget {
  final OnboardingBloc onboardingBloc;
  final bool isReview;

  const TourScreen({
    super.key,
    required this.onboardingBloc,
    required this.isReview,
  });

  @override
  State<TourScreen> createState() {
    return _TourScreenState();
  }
}

class _TourScreenState extends State<TourScreen> {
  late PageController _pageController;
  late Future<void> dataClockingFutureToBuild;
  int pagePresented = -1;
  int _nextStep = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    dataClockingFutureToBuild = initClockModule();

    _getAlreadyViewedOnboardingEvent();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> initClockModule() async {
    await Modular.get<ICollectorModuleService>().initialize(
      homePath: HomeRoutes.homeScreenInitialRoute,
      environment: EnvironmentVariables.environmentClockModuleEnum,
      appIdentifier: AppIdentfierEnum.waapi,
      hideBackButton: false,
      showNotificationButton: false,
      loginPath: AuthenticationRoutes.authenticationModuleRoute,
    );
  }

  @override
  Widget build(BuildContext context) {
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
          Modular.to.pushReplacementNamed(
            HomeRoutes.homeScreenInitialRoute,
            arguments: {
              'dataClockingFuture': dataClockingFutureToBuild,
            },
          );
        }

        if (state is NotVisualizedOnboardingState) {
          _nextPageOnboardingEvent();
        }
      },
      builder: (context, state) {
        if (state is InitialOnboardingState || state is LoadingOnboardingState) {
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
            title: context.translate.tour,
            contentViewPageWidgets: [
              ContentViewPageWidget(
                key: const Key('onboarding-tour_screen-step_one'),
                onJump: () => _setOnboardingJumpEvent(
                  step: 1,
                ),
                imagePath: AssetsPath.tourWelcome,
                textContent: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SeniorText.labelBold(
                        context.translate.home,
                        darkColor: Provider.of<ThemeRepository>(context).theme.textTheme!.labelBoldStyle!.color,
                      ),
                      const SizedBox(
                        height: SeniorSpacing.normal,
                      ),
                      SeniorText.label(
                        context.translate.tourHomeDescription,
                        color: SeniorColors.neutralColor500,
                        darkColor: Provider.of<ThemeRepository>(context).theme.textTheme!.labelStyle!.color,
                      ),
                    ],
                  ),
                ),
              ),
              ContentViewPageWidget(
                isPng: true,
                key: const Key('onboarding-tour_screen-step_two'),
                onJump: () => _setOnboardingJumpEvent(
                  step: 2,
                ),
                imagePath: _getFeedbackImage(
                  isDarkMode: Provider.of<ThemeRepository>(context).isDarkTheme(),
                ),
                textContent: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SeniorText.labelBold(
                        context.translate.feedbackTitle,
                        darkColor: Provider.of<ThemeRepository>(context).theme.textTheme!.labelBoldStyle!.color,
                      ),
                      const SizedBox(
                        height: SeniorSpacing.normal,
                      ),
                      SeniorText.label(
                        context.translate.tourFeedbackDescription,
                        color: SeniorColors.neutralColor500,
                        darkColor: Provider.of<ThemeRepository>(context).theme.textTheme!.labelStyle!.color,
                      ),
                    ],
                  ),
                ),
              ),
              ContentViewPageWidget(
                isPng: Provider.of<ThemeRepository>(context).isDarkTheme(),
                key: const Key('onboarding-tour_screen-step_three'),
                onJump: () => _setOnboardingJumpEvent(
                  step: 3,
                ),
                imagePath: _getBirthdaysImage(
                  isDarkMode: Provider.of<ThemeRepository>(context).isDarkTheme(),
                ),
                textContent: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SeniorText.labelBold(
                        context.translate.anniversaries,
                        darkColor: Provider.of<ThemeRepository>(context).theme.textTheme!.labelBoldStyle!.color,
                      ),
                      const SizedBox(
                        height: SeniorSpacing.normal,
                      ),
                      SeniorText.label(
                        context.translate.tourAnniversariesDescription,
                        color: SeniorColors.neutralColor500,
                        darkColor: Provider.of<ThemeRepository>(context).theme.textTheme!.labelStyle!.color,
                      ),
                    ],
                  ),
                ),
              ),
              ContentViewPageWidget(
                key: const Key('onboarding-tour_screen-step_four'),
                onJump: () => _setOnboardingJumpEvent(
                  step: 4,
                ),
                imagePath: _getHappinessIndexImage(
                  isDarkMode: Provider.of<ThemeRepository>(context).isDarkTheme(),
                ),
                textContent: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SeniorText.labelBold(
                        context.translate.moodDiary,
                        darkColor: Provider.of<ThemeRepository>(context).theme.textTheme!.labelBoldStyle!.color,
                      ),
                      const SizedBox(
                        height: SeniorSpacing.normal,
                      ),
                      SeniorText.label(
                        context.translate.tourHappinessIndexDescription,
                        color: SeniorColors.neutralColor500,
                        darkColor: Provider.of<ThemeRepository>(context).theme.textTheme!.labelStyle!.color,
                      ),
                    ],
                  ),
                ),
              ),
              ContentViewPageWidget(
                showJump: false,
                key: const Key('onboarding-tour_screen-step_five'),
                onJump: () => _setOnboardingJumpEvent(
                  step: 5,
                ),
                imagePath: _getVacationsImage(),
                textContent: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SeniorText.labelBold(
                        context.translate.tourVacationsTitle,
                        darkColor: Provider.of<ThemeRepository>(context).theme.textTheme!.labelBoldStyle!.color,
                      ),
                      const SizedBox(
                        height: SeniorSpacing.normal,
                      ),
                      SeniorText.label(
                        context.translate.tourVacationsDescription,
                        color: SeniorColors.neutralColor500,
                        darkColor: Provider.of<ThemeRepository>(context).theme.textTheme!.labelStyle!.color,
                      ),
                    ],
                  ),
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
        analyticsEventEnum: AnalyticsEventEnum.tourView,
        step: _nextStep,
        maxSteps: 5,
        additionalParameters: {
          'first_time': (!widget.isReview).toString(),
          'feature': _getFeatureName(
            page: pagePresented + 1,
          ),
        },
      ),
    );
  }

  String _getFeatureName({
    required int page,
  }) {
    switch (page) {
      case 0:
        return 'home';
      case 1:
        return 'feedback';
      case 2:
        return 'birthdays';
      case 3:
        return 'happiness_index';
      default:
        return 'vacation';
    }
  }

  void _saveAlreadyViewedOnboardingEvent() {
    widget.onboardingBloc.add(
      const SaveAlreadyViewedOnboardingEvent(
        onboardingViewKeyEnum: OnboardingViewKeyEnum.tour,
        visualized: true,
      ),
    );
  }

  void _getAlreadyViewedOnboardingEvent() {
    widget.onboardingBloc.add(
      GetAlreadyViewedOnboardingEvent(
        onboardingViewKeyEnum: OnboardingViewKeyEnum.tour,
        isReview: widget.isReview,
      ),
    );
  }

  void _setOnboardingJumpEvent({
    required int step,
  }) {
    widget.onboardingBloc.add(
      SetOnboardingJumpEvent(
        step: step,
        onboardingViewKeyEnum: OnboardingViewKeyEnum.tour,
        analyticsEventEnum: AnalyticsEventEnum.tourSkip,
        additionalParameters: {
          'first_time': (!widget.isReview).toString(),
          'feature': _getFeatureName(
            page: pagePresented,
          ),
        },
      ),
    );
  }

  String _getFeedbackImage({required bool isDarkMode}) {
    switch (LocaleHelper.languageAndCountryCode(locale: Localizations.localeOf(context))) {
      case SupportedLocales.americanEnglish:
        return isDarkMode ? AssetsPath.tourFeedbacksDarkEnPng : AssetsPath.tourFeedbacksEnPng;
      case SupportedLocales.brazilianPortuguese:
        return isDarkMode ? AssetsPath.tourFeedbacksDarkPtPng : AssetsPath.tourFeedbacksPtPng;
      case SupportedLocales.spainSpanish:
      case SupportedLocales.colombianSpanish:
        return isDarkMode ? AssetsPath.tourFeedbacksDarkEsPng : AssetsPath.tourFeedbacksEsPng;
      default:
        return isDarkMode ? AssetsPath.tourFeedbacksDarkPtPng : AssetsPath.tourFeedbacksPtPng;
    }
  }

  String _getBirthdaysImage({required bool isDarkMode}) {
    switch (LocaleHelper.languageAndCountryCode(locale: Localizations.localeOf(context))) {
      case SupportedLocales.americanEnglish:
        return isDarkMode ? AssetsPath.tourBirthdaysDarkEnPng : AssetsPath.tourBirthdaysEn;
      case SupportedLocales.brazilianPortuguese:
        return isDarkMode ? AssetsPath.tourBirthdaysDarkPtPng : AssetsPath.tourBirthdaysPt;
      case SupportedLocales.spainSpanish:
      case SupportedLocales.colombianSpanish:
        return isDarkMode ? AssetsPath.tourBirthdaysDarkEsPng : AssetsPath.tourBirthdaysEs;
      default:
        return isDarkMode ? AssetsPath.tourBirthdaysDarkPtPng : AssetsPath.tourBirthdaysPt;
    }
  }

  String _getHappinessIndexImage({required bool isDarkMode}) {
    switch (LocaleHelper.languageAndCountryCode(locale: Localizations.localeOf(context))) {
      case SupportedLocales.americanEnglish:
        return isDarkMode ? AssetsPath.tourHappinessIndexDarkEn : AssetsPath.tourHappinessIndexEn;
      case SupportedLocales.brazilianPortuguese:
        return isDarkMode ? AssetsPath.tourHappinessIndexDarkPt : AssetsPath.tourHappinessIndexPt;
      case SupportedLocales.spainSpanish:
      case SupportedLocales.colombianSpanish:
        return isDarkMode ? AssetsPath.tourHappinessIndexDarkEs : AssetsPath.tourHappinessIndexEs;
      default:
        return isDarkMode ? AssetsPath.tourHappinessIndexDarkPt : AssetsPath.tourHappinessIndexPt;
    }
  }

  String _getVacationsImage() {
    switch (LocaleHelper.languageAndCountryCode(locale: Localizations.localeOf(context))) {
      case SupportedLocales.americanEnglish:
        return AssetsPath.tourVacationEn;
      case SupportedLocales.brazilianPortuguese:
        return AssetsPath.tourVacationPt;
      case SupportedLocales.spainSpanish:
        return AssetsPath.tourVacationEs;
      case SupportedLocales.colombianSpanish:
        return AssetsPath.tourVacationEs;
      default:
        return AssetsPath.tourVacationPt;
    }
  }
}
