import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart' as rive;
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../../../core/constants/assets_path.dart';
import '../../../../../core/extension/media_query_extension.dart';
import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/theme/custom_theme/waapi_custom_theme.dart';
import '../../../../../core/widgets/error_state_widget.dart';
import '../../../../../core/widgets/waapi_colorful_header.dart';
import '../../../../../core/widgets/waapi_loading_widget.dart';

import '../../../../../routes/onboarding_routes.dart';
import '../../../../personalization/presenter/bloc/personalization_mobile_bloc/personalization_mobile_bloc.dart';
import '../../../../personalization/presenter/bloc/personalization_mobile_bloc/personalization_mobile_event.dart';
import '../../../../personalization/presenter/bloc/personalization_mobile_bloc/personalization_mobile_state.dart';
import '../../../domain/enums/onboarding_view_key_enum.dart';
import '../../blocs/onboarding_bloc/onboarding_bloc.dart';
import '../../blocs/onboarding_bloc/onboarding_event.dart';
import '../../blocs/onboarding_bloc/onboarding_state.dart';
import 'bloc/splash_bloc.dart';
import 'bloc/splash_event.dart';
import 'bloc/splash_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
    required this.onboardingBloc,
  }) : super(key: key);

  final OnboardingBloc onboardingBloc;

  @override
  State<SplashScreen> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  late SplashBloc _splashBloc;
  late AuthenticationBloc _authenticationBloc;
  late PersonalizationMobileBloc _personalizationMobileBloc;

  @override
  void initState() {
    _splashBloc = Modular.get<SplashBloc>();
    _authenticationBloc = Modular.get<AuthenticationBloc>();
    _personalizationMobileBloc = Modular.get<PersonalizationMobileBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<PersonalizationMobileBloc, PersonalizationMobileState>(
          bloc: _personalizationMobileBloc,
          listener: (context, state) {
            if (state is LoadedPersonalizationMobileState) {
              final personalizationMobile = state.personalizationMobileEntity;
              if (personalizationMobile.usePersonalizationMobile == true &&
                  personalizationMobile.primaryColor != null) {
                themeRepository.theme = createCustomSeniorTheme(
                  usePersenalization: true,
                  primaryColor: SeniorServiceColor.parseColor(personalizationMobile.primaryColor!),
                  secondaryColor: SeniorServiceColor.parseColor(
                    personalizationMobile.secondaryColor ?? personalizationMobile.primaryColor!,
                  ),
                );
              }
              Modular.to.navigate(OnboardingRoutes.onboardingScreenInitialRoute);
            }
            if (state is ErrorPersonalizationMobileState) {
              final personalizationMobileDriver = state.personalizationMobileEntity;
              if (personalizationMobileDriver?.usePersonalizationMobile == true) {
                themeRepository.theme = createCustomSeniorTheme(
                  usePersenalization: true,
                  primaryColor: SeniorServiceColor.parseColor(personalizationMobileDriver!.primaryColor!),
                  secondaryColor: SeniorServiceColor.parseColor(
                    personalizationMobileDriver.secondaryColor ?? personalizationMobileDriver.primaryColor!,
                  ),
                );
              }
              Modular.to.navigate(OnboardingRoutes.onboardingScreenInitialRoute);
            }
          },
          child: Container(),
        ),
        BlocListener<AuthenticationBloc, AuthenticationState>(
          bloc: _authenticationBloc,
          listener: (context, state) {
            if (_authenticationBloc.state.status == AuthenticationStatus.authenticated) {
              if (_splashBloc.state is FinishSplashState) {
                _personalizationMobileBloc.add(
                  GetPersonalizationMobileEvent(),
                );
              }
            } else if (_authenticationBloc.state.status == AuthenticationStatus.unauthenticated) {
              Modular.to.navigate(OnboardingRoutes.onboardingScreenInitialRoute);
            }
          },
          child: Container(),
        ),
        BlocListener<SplashBloc, SplashState>(
          bloc: _splashBloc,
          listener: (context, state) {
            if (state is FinishSplashState) {
              if (_authenticationBloc.state.status == AuthenticationStatus.authenticated ||
                  _authenticationBloc.state.status == AuthenticationStatus.unauthenticated) {
                Modular.to.navigate(OnboardingRoutes.onboardingScreenInitialRoute);
              } else {
                _splashBloc.add(
                  ChangeSplashStatusEvent(),
                );
              }
            } else {
              _splashBloc.add(
                ChangeSplashStatusEvent(),
              );
            }
          },
        ),
      ],
      child: Scaffold(
        body: Container(
          width: context.widthSize,
          decoration: themeRepository.isLightTheme()
              ? const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: SeniorColors.primaryGradientColors,
                  ),
                )
              : null,
          color: themeRepository.isLightTheme() ? null : SeniorColors.pureBlack,
          child: FutureBuilder<bool>(
            future: androidRootChecker(),
            builder: (context, snapshotRootDetector) {
              if (snapshotRootDetector.hasData) {
                if (snapshotRootDetector.data!) {
                  return WaapiColorfulHeader(
                    titleLabel: context.translate.appTitle,
                    hideLeading: true,
                    body: Padding(
                      padding: const EdgeInsets.only(
                        top: SeniorSpacing.xsmall,
                      ),
                      child: SizedBox(
                        width: context.widthSize,
                        height: context.heightSize,
                        child: ErrorStateWidget(
                          onTapTryAgain: () {
                            exit(0);
                          },
                          titleButton: context.translate.exitApp,
                          title: context.translate.errorRootTitle,
                          subTitle: context.translate.errorRootSubTitle,
                          imagePath: AssetsPath.generalErrorState,
                        ),
                      ),
                    ),
                  );
                } else {
                  _getAlreadyViewedOnboardingEvent();
                }
              }

              return BlocConsumer<OnboardingBloc, OnboardingState>(
                bloc: widget.onboardingBloc,
                listener: (context, state) {
                  if (state is VisualizedOnboardingState) {
                    _splashBloc.add(
                      ChangeSplashStatusEvent(),
                    );
                    return;
                  }
                  if (state is NotVisualizedOnboardingState) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _bottomSheetCrossFadeState = CrossFadeState.showSecond;
                      if (!animationStarted) {
                        initAnimation();
                      }
                    });
                  }
                },
                builder: (context, state) {
                  if (state is InitialOnboardingState ||
                      state is VisualizedOnboardingState ||
                      !snapshotRootDetector.hasData) {
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
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AnimatedCrossFade(
                        crossFadeState: _bottomSheetCrossFadeState,
                        duration: const Duration(
                          milliseconds: 300,
                        ),
                        firstChild: SizedBox(
                          width: context.widthSize,
                          height: 0,
                        ),
                        secondChild: Container(
                          height: context.bottomSheetSize,
                          decoration: BoxDecoration(
                            color: themeRepository.isLightTheme()
                                ? SeniorColors.pureWhite
                                : Provider.of<ThemeRepository>(context).theme.cardTheme!.style!.backgroundColor,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(SeniorRadius.huge),
                            ),
                          ),
                          child: Center(
                            child: Stack(
                              children: [
                                rive.RiveAnimation.asset(
                                  alignment: Alignment.center,
                                  themeRepository.isLightTheme()
                                      ? AssetsPath.splashAnimation
                                      : AssetsPath.splashAnimationdark,
                                ),
                                Positioned(
                                  bottom: context.heightSize * 0.1,
                                  left: context.widthSize * 0.1,
                                  child: RichText(
                                    text: TextSpan(
                                      text: '${_getTopText()}\n',
                                      style: SeniorTypography.h2(
                                        color: themeRepository.isLightTheme()
                                            ? SeniorColors.neutralColor800
                                            : SeniorColors.pureWhite,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: _getBottomText(),
                                          style: SeniorTypography.h2(
                                            color: themeRepository.isLightTheme()
                                                ? SeniorColors.neutralColor500
                                                : SeniorColors.pureWhite,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void initAnimation() async {
    await Future.delayed(
      const Duration(
        milliseconds: 1200,
      ),
    );
    setState(() {
      animationStarted = true;
      _textAnimationStage = 1;
    });
    await Future.delayed(
      const Duration(
        milliseconds: 1080,
      ),
    );
    setState(() {
      _textAnimationStage = 2;
    });
    await Future.delayed(
      const Duration(
        seconds: 1,
      ),
    );
    setState(() {
      _textAnimationStage = 3;
    });
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );
    _splashBloc.add(
      ChangeSplashStatusEvent(),
    );
  }

  static final List<String> rootFiles = [
    '/sbin/su',
    '/system/bin/su',
    '/data/local/bin/su',
    '/cache/su',
    '/odm/bin/su',
    '/dev/su',
    '/system/sd/xbin/su',
    '/system/bin/failsafe/su',
    '/system/xbin/su',
    '/system/bin/.ext/su',
    '/data/local/su',
    '/data/local/xbin/su',
    '/system/xbin/busybox',
    '/system/app/Superuser.apk',
    '/system/xbin/which',
    '/data/adb/magisk.img',
    '/data/data/com.noshufou.android.su',
    '/apex/com.android.runtime/bin/su',
    '/apex/com.android.runtime/bin/su',
    '/product/bin/su',
    '/system/usr/we-need-root/su',
    '/vendor/xbin/su',
    '/vendor/bin/su',
  ];

  static final List<String> rootProcesses = [
    'su',
    'supersu',
    'magisk',
    'frida-server',
    'xposed',
    'busybox',
    'zygote',
    'zygote64',
    'daemonsu',
    'sudaemon',
    'magiskd',
    'system_server',
    'app_process',
    'gdaemon',
  ];

  static final List<String> rootProperties = [
    'service.adb.root',
    'ro.debuggable',
  ];

  var _bottomSheetCrossFadeState = CrossFadeState.showFirst;
  int _textAnimationStage = 0;
  bool animationStarted = false;
  String _getTopText() {
    switch (_textAnimationStage) {
      case 0:
        return '';
      case 1:
        return context.translate.autonomy;
      case 2:
        return context.translate.inThePalm;
      default:
        return context.translate.appNameAnimation;
    }
  }

  String _getBottomText() {
    switch (_textAnimationStage) {
      case 0:
        return '';
      case 1:
        return context.translate.andInteraction;
      case 2:
        return context.translate.ofYourHand;
      default:
        return '';
    }
  }

  Future<bool> androidRootChecker() async {
    try {
      if (Platform.isIOS) {
        return false;
      }
      final hasChanges = await monitorFileAndProcessChanges(timeout: const Duration(seconds: 10)).firstWhere(
        (hasChanges) => hasChanges == true,
        orElse: () => false,
      );
      return hasChanges;
    } catch (error) {
      return false;
    }
  }

  Stream<bool> monitorFileAndProcessChanges({required Duration timeout}) async* {
    Future<bool> isFileExists(String filePath) async {
      try {
        final file = File(filePath);
        return await file.exists();
      } catch (e) {
        return false;
      }
    }

    bool isProcessRunning(String processName) {
      try {
        final processes = Process.runSync('ps', ['-A']);
        final output = processes.stdout.toString();
        return output.contains(processName);
      } catch (e) {
        return false;
      }
    }

    bool isRootProperty(String propertyName) {
      try {
        final propertyValue = Process.runSync('getprop', [propertyName]);
        final output = propertyValue.stdout.toString();
        return output.contains('1');
      } catch (e) {
        return false;
      }
    }

    final startTime = DateTime.now();
    final stream = Stream<void>.periodic(const Duration(seconds: 1), (timer) {});

    await for (final _ in stream) {
      bool hasChanges = false;

      for (final property in rootProperties) {
        if (isRootProperty(property)) {
          hasChanges = true;
        }
      }

      for (final file in rootFiles) {
        if (await isFileExists(file)) {
          hasChanges = true;
        }
      }

      for (final process in rootProcesses) {
        if (isProcessRunning(process)) {
          hasChanges = true;
        }
      }

      if (DateTime.now().difference(startTime) >= timeout) {
        yield false;
        break;
      }

      yield hasChanges;
      break;
    }
  }

  void _getAlreadyViewedOnboardingEvent() {
    if (_splashBloc.state is FinishSplashState) {
      _splashBloc.add(
        ChangeSplashStatusEvent(),
      );
      return;
    } else {
      widget.onboardingBloc.add(
        const GetAlreadyViewedOnboardingEvent(
          onboardingViewKeyEnum: OnboardingViewKeyEnum.onboarding,
          isReview: false,
        ),
      );
    }
  }
}
