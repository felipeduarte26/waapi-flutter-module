import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ponto_mobile_collector/app/collector/modules/configuration/presenter/cubit/configuration/configuration_cubit.dart';
import 'package:ponto_mobile_collector/app/collector/modules/configuration/presenter/cubit/configuration/configuration_state.dart';
import 'package:ponto_mobile_collector/app/collector/modules/routes/collector_routes.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_system/components/components.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../core/enums/analytics/waapi_loading_size_enum.dart';
import '../../../../../core/extension/media_query_extension.dart';
import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/helper/snackbar_helper.dart';
import '../../../../../core/widgets/waapi_colorful_header.dart';
import '../../../../../core/widgets/waapi_loading_widget.dart';
import '../../../../../routes/routes.dart';
import '../../../../active_contract/presenter/blocs/active_contract_bloc/active_contract_bloc.dart';
import '../../../../active_contract/presenter/blocs/active_contract_bloc/active_contract_state.dart';
import '../../../../authentication/presenter/blocs/sign_out/sign_out_bloc.dart';
import '../../../../authentication/presenter/blocs/sign_out/sign_out_event.dart';
import '../../../../authentication/presenter/blocs/sign_out/sign_out_state.dart';
import '../../../../authorization/presenter/blocs/authorization_bloc/authorization_bloc.dart';
import '../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../../../management_panel/helpers/management_panel_dialog_helper.dart';
import '../../blocs/get_current_version/get_current_version_event.dart';
import '../../blocs/get_current_version/get_current_version_state.dart';
import 'bloc/settings_screen_bloc.dart';
import 'bloc/settings_screen_state.dart';

class SettingsScreen extends StatefulWidget {
  final SettingsScreenBloc settingsScreenBloc;
  final bool disabled;
  final bool isWaapiLite;
  final ConfigurationCubit configurationCubit;

  const SettingsScreen({
    Key? key,
    required this.settingsScreenBloc,
    required this.disabled,
    required this.isWaapiLite,
    required this.configurationCubit,
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() {
    return _SettingsScreenState();
  }
}

class _SettingsScreenState extends State<SettingsScreen> with SingleTickerProviderStateMixin {
  late final ActiveContractBloc activeContractBloc;
  late final AuthorizationBloc authorizationBloc;
  late bool isBiometricDeviceEnabled;
  late final isWaapiLiteVersion = widget.isWaapiLite ? ' \n Waapi Lite' : '';
  AnimationController? animationController;
  Animation<double>? rotateAnimation;

  @override
  void initState() {
    isBiometricDeviceEnabled = false;
    super.initState();
    widget.settingsScreenBloc.getCurrentVersionBloc.add(RequestGetCurrentVersionEvent());
    activeContractBloc = Modular.get<ActiveContractBloc>();
    authorizationBloc = Modular.get<AuthorizationBloc>();

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
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SignOutBloc, SignOutState>(
          bloc: widget.settingsScreenBloc.signOutBloc,
          listener: (context, state) {
            if (state.signOutStatus == SignOutStatusEnum.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SeniorSnackBar.error(
                  message: context.translate.settingsLogoutErrorMessage,
                ),
              );
            }
            if (state.signOutStatus == SignOutStatusEnum.signOut) {
              Modular.to.navigate(AuthenticationRoutes.authenticationModuleRoute);
            }
          },
        ),
      ],
      child: BlocBuilder<SettingsScreenBloc, SettingsScreenState>(
        bloc: widget.settingsScreenBloc,
        builder: (context, state) {
          final getCurrentVersionState = state.getCurrentVersionState;

          final authorizationBlocState = authorizationBloc.state;

          var allowToViewTimeManagement = false;
          var allowToViewClockingMobileLog = false;
          ConfigurationBaseState? previousClockConfigLogState;

          if (authorizationBlocState is LoadedAuthorizationState) {
            allowToViewTimeManagement = authorizationBlocState.authorizationEntity.allowToViewTimeManagement;
            allowToViewClockingMobileLog = authorizationBlocState.authorizationEntity.allowToViewClockingMobileLog;
          }

          const disableSeniorMenuItemListStyle = SeniorMenuListItemStyle(
            titleColor: SeniorColors.neutralColor400,
            pushIconColor: SeniorColors.neutralColor400,
            iconColor: SeniorColors.primaryColor200,
          );

          return Scaffold(
            body: WaapiColorfulHeader(
              hasTopPadding: false,
              title: SeniorText.label(
                color: SeniorColors.pureWhite,
                darkColor: SeniorColors.grayscale5,
                context.translate.titleSettings,
              ),
              body: Column(
                children: [
                  Expanded(
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: SeniorSpacing.normal,
                            ),
                            if (activeContractBloc.state is LoadedActiveContractState)
                            allowToViewTimeManagement
                                ? FutureBuilder<bool>(
                                    future: Modular.get<GetUserFaceRecognitionUsecase>().call(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return const WaapiLoadingWidget(
                                          waapiLoadingSizeEnum: WaapiLoadingSizeEnum.small,
                                        );
                                      }
                                      if (snapshot.hasError || !snapshot.data!) {
                                        return const SizedBox.shrink();
                                      }
                                      return SeniorMenuItemList(
                                        leftPadding: SeniorSpacing.normal,
                                        rightPadding: SeniorSpacing.normal,
                                        leading: const Icon(
                                          FontAwesomeIcons.circleUser,
                                          color: SeniorColors.primaryColor,
                                          size: SeniorSpacing.medium,
                                        ),
                                        title: context.translate.facialRecognitionRegistration,
                                        style: widget.disabled ? disableSeniorMenuItemListStyle : null,
                                        onTap: () => widget.disabled
                                            ? _showOfflineSnackbar()
                                            : Modular.to.pushNamed(
                                                '/${PontoMobileCollectorRoutes.module}/${FacialRecognitionRoutes.registrationFull}',
                                              ),
                                      );
                                    },
                                  )
                                : const SizedBox.shrink(),
                            allowToViewClockingMobileLog
                                ? BlocConsumer<ConfigurationCubit, ConfigurationBaseState>(
                                    bloc: widget.configurationCubit,
                                    listener: (context, state) {
                                      if (state is LogActiveState && previousClockConfigLogState is! ReadContentState) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SeniorSnackBar.success(
                                            message: context.translate.logsEnabled,
                                          ),
                                        );
                                      }
                                      if (state is LogInactiveState &&
                                          previousClockConfigLogState is! ReadContentState) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SeniorSnackBar.error(
                                            message: context.translate.logsDisabled,
                                          ),
                                        );
                                      }
                                      if (state is SuccessSyncLogsApiState) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SeniorSnackBar.success(
                                            message: context.translate.successfulSyncLogs,
                                          ),
                                        );
                                      }
                                      if (state is PartialSuccessSyncLogs) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SeniorSnackBar.warning(
                                            message: context.translate.partialSuccessSyncLogs,
                                          ),
                                        );
                                      }
                                      if (state is FaliedSyncLogsApiState) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SeniorSnackBar.error(
                                            message: context.translate.failedSyncLogs,
                                          ),
                                        );
                                      }
                                      if (state is UnexpectedErrorSyncLogsApiState) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SeniorSnackBar.error(
                                            message: context.translate.unexpectedErrorSyncLogs,
                                          ),
                                        );
                                      }
                                      if (state is NoLogsToSyncState) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SeniorSnackBar.error(
                                            message: context.translate.notLogsToSync,
                                          ),
                                        );
                                      }
                                      if (state is NoConnectionSyncLogsApiState) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SeniorSnackBar.error(
                                            message: context.translate.featureIsNotAvailableOffline,
                                          ),
                                        );
                                      }

                                      previousClockConfigLogState = state;
                                    },
                                    builder: (context, state) {
                                      return SeniorMenuItemList(
                                        leftPadding: SeniorSpacing.normal,
                                        rightPadding: SeniorSpacing.normal,
                                        leading: Icon(
                                          widget.configurationCubit.isActiveLogs
                                              ? FontAwesomeIcons.circleXmark
                                              : FontAwesomeIcons.fileLines,
                                          color: SeniorColors.primaryColor,
                                          size: SeniorSpacing.medium,
                                        ),
                                        title: widget.configurationCubit.isActiveLogs
                                            ? context.translate.disableLogs
                                            : context.translate.enableLogs,
                                        onTap: () => widget.configurationCubit.toggleLogs(),
                                      );
                                    },
                                  )
                                : const SizedBox.shrink(),
                            allowToViewClockingMobileLog
                                ? BlocConsumer<ConfigurationCubit, ConfigurationBaseState>(
                                    bloc: widget.configurationCubit,
                                    listener: (context, state) {
                                      if (state is! LoadSyncLogsApiState) {
                                        animationController!.stop();
                                      }
                                    },
                                    builder: (context, state) {
                                      return SeniorMenuItemList(
                                        leftPadding: SeniorSpacing.normal,
                                        rightPadding: SeniorSpacing.normal,
                                        leading: state is LoadSyncLogsApiState
                                            ? RotationTransition(
                                                turns: rotateAnimation!,
                                                child: const Icon(
                                                  FontAwesomeIcons.rotate,
                                                  color: SeniorColors.primaryColor,
                                                  size: SeniorSpacing.medium,
                                                ),
                                              )
                                            : const Icon(
                                                FontAwesomeIcons.cloudArrowUp,
                                                color: SeniorColors.primaryColor,
                                                size: SeniorSpacing.medium,
                                              ),
                                        title: context.translate.sendLogs,
                                        style: widget.disabled ? disableSeniorMenuItemListStyle : null,
                                        onTap: () {
                                          if (state is! LoadSyncLogsApiState) {
                                            animationController!.repeat();
                                            widget.configurationCubit.syncLogsApi();
                                          }
                                        },
                                      );
                                    },
                                  )
                                : const SizedBox.shrink(),
                            SeniorMenuItemList(
                              leftPadding: SeniorSpacing.normal,
                              rightPadding: SeniorSpacing.normal,
                              leading: const Icon(
                                FontAwesomeIcons.solidFileLines,
                                color: SeniorColors.primaryColor,
                                size: SeniorSpacing.medium,
                              ),
                              title: context.translate.privacyPolicy,
                              style: widget.disabled ? disableSeniorMenuItemListStyle : null,
                              onTap: () => widget.disabled
                                  ? _showOfflineSnackbar()
                                  : Modular.to.pushNamed(
                                      PrivacyPolicyRoutes.privacyPolicyScreenInitialRoute,
                                    ),
                            ),
                            SeniorMenuItemList(
                              leftPadding: SeniorSpacing.normal,
                              rightPadding: SeniorSpacing.normal,
                              leading: const Icon(
                                FontAwesomeIcons.solidHeadset,
                                color: SeniorColors.primaryColor,
                                size: SeniorSpacing.medium,
                              ),
                              title: context.translate.help,
                              style: widget.disabled ? disableSeniorMenuItemListStyle : null,
                              onTap: () => widget.disabled
                                  ? _showOfflineSnackbar()
                                  : Modular.to.pushNamed(
                                      HelpRoutes.helpScreenInitialRoute,
                                    ),
                            ),
                            SeniorMenuItemList(
                              leftPadding: SeniorSpacing.normal,
                              rightPadding: SeniorSpacing.normal,
                              leading: const Icon(
                                FontAwesomeIcons.solidFlag,
                                color: SeniorColors.primaryColor,
                                size: SeniorSpacing.medium,
                              ),
                              title: context.translate.reviewTour,
                              style: widget.disabled ? disableSeniorMenuItemListStyle : null,
                              onTap: () => widget.disabled
                                  ? _showOfflineSnackbar()
                                  : Modular.to.navigate(
                                      OnboardingRoutes.tourScreenInitialRoute,
                                      arguments: {
                                        'isReview': true,
                                      },
                                    ),
                            ),
                            SeniorMenuItemList(
                              leftPadding: SeniorSpacing.normal,
                              rightPadding: SeniorSpacing.normal,
                              leading: const Icon(
                                FontAwesomeIcons.solidShareFromSquare,
                                color: SeniorColors.primaryColor,
                                size: SeniorSpacing.medium,
                              ),
                              title: context.translate.descriptionTileExitSettings,
                              onTap: () => _showDialogExit(
                                context: context,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  getCurrentVersionState is LoadedGetCurrentVersionState
                      ? Padding(
                          padding: EdgeInsets.only(
                            bottom: SeniorSpacing.normal + context.bottomSize,
                          ),
                          child: SeniorText.body(
                            'powered by Senior Sistemas\n${context.translate.version}: ${getCurrentVersionState.version}$isWaapiLiteVersion',
                            textProperties: const TextProperties(
                              textAlign: TextAlign.center,
                            ),
                            color: SeniorColors.secondaryColor600,
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showDialogExit({
    required BuildContext context,
  }) {
    ManagementPanelDialogHelper.openSignOutModelDialog(
      context: context,
      onSignOut: () {
        if (widget.disabled) {
          widget.settingsScreenBloc.signOutBloc.add(RequestSignOutOfflineEvent());
        } else {
          widget.settingsScreenBloc.signOutBloc.add(RequestSignOutEvent());
        }
      },
    );
  }

  void _showOfflineSnackbar() {
    SnackbarHelper.showSnackbar(
      context: context,
      message: context.translate.featureIsNotAvailableOffline,
    );
  }
}
