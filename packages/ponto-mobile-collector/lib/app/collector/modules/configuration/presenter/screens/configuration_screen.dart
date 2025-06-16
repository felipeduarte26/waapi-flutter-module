import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../ponto_mobile_collector.dart';
import '../../../../core/domain/services/navigator/navigator_service.dart';
import '../../../../core/domain/usecases/get_execution_mode_usecase.dart';
import '../../../../core/domain/usecases/logoff_usecase.dart';
import '../../../../core/infra/utils/enum/execution_mode_enum.dart';
import '../../../../core/presenter/cubit/sync_all_individual_info/sync_all_individual_info_cubit.dart';
import '../../../facial_recognition/presenter/screens/feedback_screen.dart';
import '../../../routes/collector_routes.dart';
import '../../../routes/device_configuration_permission_routes.dart';
import '../cubit/configuration/configuration_cubit.dart';
import '../cubit/configuration/configuration_state.dart';
import '../widgets/sync_logs_widget.dart';

class ConfigurationScreen extends StatefulWidget {
  final SyncAllIndividualInfoCubit synchronizationCubit;
  final String? pathLogin;
  final ILogoffUsecase iLogoffUsecase;
  final ConfigurationCubit configurationCubit;
  final NavigatorService navigatorService;
  final GetExecutionModeUsecase getExecutionModeUsecase;

  const ConfigurationScreen({
    this.pathLogin,
    required this.configurationCubit,
    required this.synchronizationCubit,
    required this.iLogoffUsecase,
    required this.navigatorService,
    required this.getExecutionModeUsecase,
    super.key,
  });

  @override
  State<ConfigurationScreen> createState() => _ConfigurationScreenState();
}

class _ConfigurationScreenState extends State<ConfigurationScreen>
    with SingleTickerProviderStateMixin {
  bool isDark = false;
  AnimationController? animationController;
  Animation<double>? rotateAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    rotateAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(parent: animationController!, curve: Curves.linear),
    );

    widget.configurationCubit.loadContent();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isDark = Provider.of<ThemeRepository>(context).isDarkTheme();

    return Scaffold(
      body: SeniorColorfulHeaderStructure(
        title: SeniorText.label(
          CollectorLocalizations.of(context).configurations,
          color: SeniorColors.pureWhite,
          darkColor: SeniorColors.grayscale5,
        ),
        leading: IconButton(
          icon: Icon(
            FontAwesomeIcons.angleLeft,
            color: isDark ? SeniorColors.grayscale5 : SeniorColors.pureWhite,
          ),
          iconSize: SeniorSpacing.small,
          onPressed: () {
            Modular.to.pop();
          },
        ),
        body: BlocBuilder<ConfigurationCubit, ConfigurationBaseState>(
          bloc: widget.configurationCubit,
          builder: (context, state) {
            if (state is LoadingContentState) {
              return LoadingWidget(
                bottomLabel: CollectorLocalizations.of(context).loading,
              );
            }
            return getBodyConfiguration();
          },
        ),
      ),
    );
  }

  Widget getBodyConfiguration() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
          left: SeniorSpacing.normal,
          right: SeniorSpacing.normal,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SeniorText.body(
              CollectorLocalizations.of(context).configurations,
            ),
            const SizedBox(height: SeniorSpacing.xsmall),
            widget.configurationCubit.showFacialRecognitionRegistration
                ? ConfigurationRowWidget(
                    title: CollectorLocalizations.of(context)
                        .facialRecognitionRegistration,
                    icon: const Icon(
                      // ignore: deprecated_member_use
                      FontAwesomeIcons.solidUserCircle,
                      color: SeniorColors.primaryColor500,
                      size: SeniorIconSize.medium,
                    ),
                    onTap: () {
                      widget.navigatorService.pushNamed(
                        route:
                            '/${PontoMobileCollectorRoutes.module}/${FacialRecognitionRoutes.registrationFull}',
                      );
                    },
                  )
                : const SizedBox(),
            ConfigurationRowWidget(
              title: CollectorLocalizations.of(context).setKey,
              icon: const Icon(
                FontAwesomeIcons.key,
                color: SeniorColors.primaryColor500,
                size: SeniorIconSize.medium,
              ),
              onTap: () {
                widget.navigatorService.pushNamed(
                  route: ApplicationKeyRoutes.registerKeyFull,
                );
              },
            ),
            ConfigurationRowWidget(
              title: CollectorLocalizations.of(context)
                  .deviceConfigurationPermission,
              icon: const Icon(
                FontAwesomeIcons.toggleOn,
                color: SeniorColors.primaryColor500,
                size: SeniorIconSize.medium,
              ),
              onTap: () {
                widget.navigatorService.pushNamed(
                  route: DeviceConfigurationPermissionRoutes.homeFull,
                );
              },
            ),

            /// TODO Código comentado devido a essas opções não seram liberadas no momento
            ///
            // ConfigurationRowWidget(
            //   title: CollectorLocalizations.of(context).configurationReminders,
            //   icon: const Icon(
            //     FontAwesomeIcons.solidBookmark,
            //     color: SeniorColors.primaryColor500,
            //     size: SeniorIconSize.medium,
            //   ),
            //   onTap: () {},
            // ),
            // ConfigurationRowWidget(
            //   title:
            //       CollectorLocalizations.of(context).configurationNotifications,
            //   icon: const Icon(
            //     FontAwesomeIcons.solidBell,
            //     color: SeniorColors.primaryColor500,
            //     size: SeniorIconSize.medium,
            //   ),
            //   onTap: () {},
            // ),

            BlocConsumer<SyncAllIndividualInfoCubit,
                SyncAllIndividualInfoState>(
              bloc: widget.synchronizationCubit,
              listener: (context, state) {
                if (state is SyncAllIndividualInfoNoConnectionState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SeniorSnackBar.warning(
                      message: CollectorLocalizations.of(context)
                          .facialLooksLikeAreOffline,
                    ),
                  );
                }

                if (state is SyncAllIndividualInfoFailureState ||
                    state is SyncAllIndividualInfoNotTokenState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SeniorSnackBar.error(
                      message: CollectorLocalizations.of(context)
                          .syncClockingEventSyncFailure,
                    ),
                  );
                }

                if (state is SyncAllIndividualInfoSuccessState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SeniorSnackBar.success(
                      message: CollectorLocalizations.of(context)
                          .syncClockingEventSyncSuccess,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is SyncAllIndividualInfoInProgressState) {
                  animationController!.repeat();

                  return ConfigurationRowWidget(
                    title: CollectorLocalizations.of(context).syncAppointInfo,
                    showRightIcon: false,
                    icon: const Icon(
                      FontAwesomeIcons.rotate,
                      color: SeniorColors.primaryColor500,
                      size: SeniorIconSize.medium,
                    ),
                    rotationTransition: RotationTransition(
                      turns: rotateAnimation!,
                      child: const Icon(
                        FontAwesomeIcons.rotate,
                        color: SeniorColors.primaryColor500,
                        size: SeniorIconSize.medium,
                      ),
                    ),
                    onTap: () {},
                  );
                } else {
                  animationController!.stop();

                  return ConfigurationRowWidget(
                    title: CollectorLocalizations.of(context).syncAppointInfo,
                    showRightIcon: false,
                    icon: const Icon(
                      FontAwesomeIcons.rotate,
                      color: SeniorColors.primaryColor500,
                      size: SeniorIconSize.medium,
                    ),
                    rotationTransition: RotationTransition(
                      turns: rotateAnimation!,
                      child: const Icon(
                        FontAwesomeIcons.rotate,
                        color: SeniorColors.primaryColor500,
                        size: SeniorIconSize.medium,
                      ),
                    ),
                    onTap: () async {
                      widget.synchronizationCubit.syncAllIndividualInfo();
                    },
                  );
                }
              },
            ),
            BlocConsumer<ConfigurationCubit, ConfigurationBaseState>(
              bloc: widget.configurationCubit,
              listener: (context, state) {
                if (state is HasNoConectionHelpCenterState) {
                  FeedbackScreen(
                    navigatorService: widget.navigatorService,
                    buttons: [
                      SeniorButton(
                        label:
                            CollectorLocalizations.of(context).facialTryAgain,
                        onPressed: () => widget.configurationCubit
                            .goToHelpCenterDocumentation(),
                        fullWidth: true,
                        style: const SeniorButtonStyle(
                          backgroundColor: SeniorColors.primaryColor600,
                        ),
                      ),
                    ],
                    feedbackType: FeedbackTypeEnum.error,
                    subtitle: '',
                    title: CollectorLocalizations.of(context)
                        .facialLooksLikeAreOffline,
                  );
                }
                if (state is LogActiveState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SeniorSnackBar.success(
                      message: CollectorLocalizations.of(context).logsEnabled,
                    ),
                  );
                }
                if (state is LogInactiveState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SeniorSnackBar.error(
                      message: CollectorLocalizations.of(context).logsDisabled,
                    ),
                  );
                }
                if (state is SuccessSyncLogsApiState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SeniorSnackBar.success(
                      message:
                          CollectorLocalizations.of(context).successfulSyncLogs,
                    ),
                  );
                }
                if (state is PartialSuccessSyncLogs) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SeniorSnackBar.warning(
                      message: CollectorLocalizations.of(context)
                          .partialSuccessSyncLogs,
                    ),
                  );
                }
                if (state is FaliedSyncLogsApiState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SeniorSnackBar.error(
                      message:
                          CollectorLocalizations.of(context).faliedSyncLogs,
                    ),
                  );
                }
                if (state is UnexpectedErrorSyncLogsApiState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SeniorSnackBar.error(
                      message: CollectorLocalizations.of(context)
                          .unexpectedErrorSyncLogs,
                    ),
                  );
                }
                if (state is NoLogsToSyncState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SeniorSnackBar.error(
                      message: CollectorLocalizations.of(context).notLogsToSync,
                    ),
                  );
                }
                if (state is NoConnectionSyncLogsApiState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SeniorSnackBar.error(
                      message: CollectorLocalizations.of(context)
                          .featureIsNotAvailableOffline,
                    ),
                  );
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    Visibility(
                      visible: widget.configurationCubit.hasLogsPermission,
                      child: ConfigurationRowWidget(
                        showRightIcon: false,
                        title: widget.configurationCubit.isActiveLogs
                            ? CollectorLocalizations.of(context).disableLogs
                            : CollectorLocalizations.of(context).enableLogs,
                        icon: Icon(
                          widget.configurationCubit.isActiveLogs
                              ? FontAwesomeIcons.circleXmark
                              : FontAwesomeIcons.fileLines,
                          color: SeniorColors.primaryColor500,
                          size: SeniorIconSize.medium,
                        ),
                        onTap: () {
                          widget.configurationCubit.toggleLogs();
                        },
                      ),
                    ),
                    Visibility(
                      visible: widget.configurationCubit.hasLogsPermission,
                      child: SyncLogsWidget(
                        onTap: () {
                          widget.configurationCubit.syncLogsApi();
                        },
                        iconWidget: state is LoadSyncLogsApiState
                            ? const SizedBox(
                                width: SeniorIconSize.medium,
                                height: SeniorIconSize.medium,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    SeniorColors.primaryColor500,
                                  ),
                                ),
                              )
                            : const Icon(
                                FontAwesomeIcons.cloudArrowUp,
                                color: SeniorColors.primaryColor500,
                                size: SeniorIconSize.medium,
                              ),
                        text: CollectorLocalizations.of(context).sendLogs,
                      ),
                    ),
                  ],
                );
              },
            ),

            /// TODO Código comentado devido a essas opções não seram liberadas no momento
            ///
            // ConfigurationRowWidget(
            //   title: CollectorLocalizations.of(context).configurationReports,
            //   icon: const Icon(
            //     FontAwesomeIcons.print,
            //     color: SeniorColors.primaryColor500,
            //     size: SeniorIconSize.medium,
            //   ),
            //   onTap: () {},
            // ),
            const SizedBox(
              height: SeniorSpacing.normal,
            ),
            Divider(
              height: 5,
              thickness: 1,
              color: isDark
                  ? SeniorColors.grayscale80
                  : SeniorColors.neutralColor800,
              endIndent: 0,
              indent: 0,
            ),
            const SizedBox(
              height: SeniorSpacing.normal,
            ),
            SeniorText.body(
              CollectorLocalizations.of(context).othersResources,
            ),
            // TODO Código comentado devido a essas opções não seram liberadas no momento
            // ConfigurationRowWidget(
            //   title: CollectorLocalizations.of(context).help,
            //   icon: const Icon(
            //     FontAwesomeIcons.headset,
            //     color: SeniorColors.primaryColor500,
            //     size: SeniorIconSize.medium,
            //   ),
            //   onTap: () {},
            // ),
            // ConfigurationRowWidget(
            //   title: CollectorLocalizations.of(context).privacyPolicy,
            //   icon: const Icon(
            //     FontAwesomeIcons.solidFileLines,
            //     color: SeniorColors.primaryColor500,
            //     size: SeniorIconSize.medium,
            //   ),
            //   onTap: () {},
            // ),
            ConfigurationRowWidget(
              title: CollectorLocalizations.of(context).helpCenter,
              icon: const Icon(
                FontAwesomeIcons.headset,
                color: SeniorColors.primaryColor500,
                size: SeniorIconSize.medium,
              ),
              onTap: () {
                widget.configurationCubit.goToHelpCenterDocumentation();
              },
            ),
            ConfigurationRowWidget(
              title: CollectorLocalizations.of(context).privacyPolicy,
              icon: const Icon(
                FontAwesomeIcons.solidFileLines,
                color: SeniorColors.primaryColor500,
                size: SeniorIconSize.medium,
              ),
              onTap: () {
                widget.configurationCubit.goToLastPrivacyPoliceVersion();
              },
            ),
            ConfigurationRowWidget(
              title: CollectorLocalizations.of(context).about,
              icon: const Icon(
                FontAwesomeIcons.circleInfo,
                color: SeniorColors.primaryColor500,
                size: SeniorIconSize.medium,
              ),
              onTap: () {
                widget.navigatorService.pushNamed(
                  route: AboutRoutes.homeFull,
                );
              },
            ),

            /// TODO Código comentado devido a essas opções não seram liberadas no momento
            ///
            // ConfigurationRowWidget(
            //   title: CollectorLocalizations.of(context).configurationAppReview,
            //   icon: const Icon(
            //     FontAwesomeIcons.solidStar,
            //     color: SeniorColors.primaryColor500,
            //     size: SeniorIconSize.medium,
            //   ),
            //   onTap: () {},
            // ),
            // ConfigurationRowWidget(
            //   title: CollectorLocalizations.of(context).configurationSearch,
            //   icon: const Icon(
            //     FontAwesomeIcons.solidCommentDots,
            //     color: SeniorColors.primaryColor500,
            //     size: SeniorIconSize.medium,
            //   ),
            //   onTap: () {},
            // ),

            /// TODO Código comentado devido a essas opções não seram liberadas no momento
            ///
            // ConfigurationRowWidget(
            //   title:
            //       CollectorLocalizations.of(context).configurationViewTourAgain,
            //   icon: const Icon(
            //     FontAwesomeIcons.solidFlag,
            //     color: SeniorColors.primaryColor500,
            //     size: SeniorIconSize.medium,
            //   ),
            //   onTap: () {},
            // ),
            ConfigurationRowWidget(
              title: CollectorLocalizations.of(context).signOut,
              icon: const Icon(
                FontAwesomeIcons.rightFromBracket,
                color: SeniorColors.primaryColor500,
                size: SeniorIconSize.medium,
              ),
              onTap: () async {
                var executionModeEnum =
                    await widget.getExecutionModeUsecase.call();

                await widget.iLogoffUsecase.call(
                  cleanTenant: executionModeEnum != ExecutionModeEnum.multiple,
                );

                if (widget.pathLogin != null) {
                  widget.navigatorService.pushNamedAndRemoveUntil(
                    widget.pathLogin!,
                    (route) => false,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
