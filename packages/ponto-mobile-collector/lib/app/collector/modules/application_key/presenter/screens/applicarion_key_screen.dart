import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/tokens/senior_colors.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../../../../generated/l10n/collector_localizations.dart';
import '../../../../core/domain/services/navigator/navigator_service.dart';
import '../../../../core/infra/exception/screen/exception_handler_screen.dart';
import '../../../../core/infra/services/configuration/collector_module_service.dart';
import '../../../../core/presenter/widgets/loading/loading_widget.dart';
import '../../../facial_recognition/presenter/screens/feedback_screen.dart';
import '../cubit/application_key_cubit.dart';
import '../cubit/application_key_state.dart';

class ApplicationKeyScreen extends StatefulWidget {
  final AuthenticationBloc _authenticationBloc;
  final Widget _keyAuthenticationScreen;
  final ApplicationKeyCubit _applicationKeyCubit;
  final String homePath;
  final NavigatorService _navigatorService;

  const ApplicationKeyScreen({
    required Widget content,
    required AuthenticationBloc authenticationBloc,
    required ApplicationKeyCubit applicationKeyCubit,
    required this.homePath,
    required NavigatorService navigatorService,
    super.key,
  })  : _keyAuthenticationScreen = content,
        _authenticationBloc = authenticationBloc,
        _applicationKeyCubit = applicationKeyCubit,
        _navigatorService = navigatorService;

  @override
  State<ApplicationKeyScreen> createState() => _ApplicationKeyScreenState();
}

class _ApplicationKeyScreenState extends State<ApplicationKeyScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget._applicationKeyCubit.loadContent();
    });
  }

  @override
  void dispose() {
    SeniorAuthentication.enableLoginWithKey = false;
    widget._applicationKeyCubit.logoffUser();
    super.dispose();
  }

  String loadingMessageByState(ApplicationKeyBaseState applicationKeyState) {
    return switch (applicationKeyState) {
      VerifyingUnsycedClockingEventsState() =>
        CollectorLocalizations.of(context).loadingUnsyncedClockingEvents,
      RemovingKeysState() => CollectorLocalizations.of(context).removingKeys,
      _ => CollectorLocalizations.of(context).loading,
    };
  }

  void navigateToMultiplo() {
    widget._navigatorService.popAndPushNamed(
      route: widget.homePath,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeRepository>(context).isDarkTheme();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          if (widget._applicationKeyCubit.state
              is KeyRegisteredSuccessfullyState) {
            navigateToMultiplo();
          } else {
            widget._navigatorService.pop();
          }
        }
      },
      child: BlocConsumer<ApplicationKeyCubit, ApplicationKeyBaseState>(
        bloc: widget._applicationKeyCubit,
        listener: (context, state) async {
          if (state is ConfirmRemoveKeysState) {
            final toDeleteKeys = await showDialog<bool>(
              context: context,
              builder: (_) => SeniorModal(
                title: CollectorLocalizations.of(context)
                    .keyAlreadyRegisteredRemove,
                content: CollectorLocalizations.of(context).confirmRemoveKeys,
                defaultAction: SeniorModalAction(
                  label: CollectorLocalizations.of(context).yes,
                  action: () {
                    widget._applicationKeyCubit.removeKeys();

                    widget._navigatorService.pop(value: true);
                  },
                ),
                otherAction: SeniorModalAction(
                  label: CollectorLocalizations.of(context).no,
                  action: () => widget._navigatorService.pop(value: false),
                ),
              ),
            );

            if (toDeleteKeys == null || !toDeleteKeys) {
              widget._applicationKeyCubit.cancelRemoveKeys();
            }

            return;
          }

          if (state is HasUnsyncedClockingEventsState) {
            await showDialog(
              context: context,
              builder: (_) => SeniorModal(
                title:
                    CollectorLocalizations.of(context).unsyncedClockingEvents,
                content: CollectorLocalizations.of(context)
                    .syncClockingEventsBeforeRemoveKeys,
                defaultAction: SeniorModalAction(
                  label: CollectorLocalizations.of(context).close,
                  action: widget._navigatorService.pop,
                ),
              ),
            );

            return widget._applicationKeyCubit.cancelRemoveKeys();
          }

          if (state is RemoveKeyErrorState) {
            await showDialog(
              context: context,
              builder: (_) => SeniorModal(
                title: CollectorLocalizations.of(context).keysNotRemoved,
                content: CollectorLocalizations.of(context)
                    .keysRemovedUnsuccessfully,
                defaultAction: SeniorModalAction(
                  label: CollectorLocalizations.of(context).close,
                  action: widget._navigatorService.pop,
                ),
              ),
            );

            return widget._applicationKeyCubit.cancelRemoveKeys();
          }

          if (state is KeysRemovedState) {
            widget._navigatorService.navigate(
              route: widget.homePath,
            );
          }
        },
        builder: (context, applicationKeyState) {
          /// User Without Connectivity
          if (applicationKeyState is HasNoConnectivityState) {
            return ExceptionHandlerScreen(
              feedbackType: ExceptionTypeEnum.alert,
              title:
                  CollectorLocalizations.of(context).facialLooksLikeAreOffline,
              subtitle:
                  CollectorLocalizations.of(context).checkConnectivityForKeys,
              actionButtonLabel:
                  CollectorLocalizations.of(context).facialModalAlertBackButton,
              onAction: () {
                widget._navigatorService.navigate(
                  route: CollectorModuleService.homePath,
                );
              },
              showRetryButton: false,
              retryButtonLabel: '',
              onRetry: () {},
            );
          }

          /// User Without Permission
          if (applicationKeyState is UserWithoutPermissionState) {
            return ExceptionHandlerScreen(
              feedbackType: ExceptionTypeEnum.alert,
              title: CollectorLocalizations.of(context).userWithoutPermission,
              subtitle: CollectorLocalizations.of(context)
                  .userWithoutPermissionDescription,
              retryButtonLabel: '',
              actionButtonLabel:
                  CollectorLocalizations.of(context).facialModalAlertBackButton,
              onAction: () {
                widget._navigatorService.navigate(
                  route: CollectorModuleService.homePath,
                );
              },
              onRetry: () {},
              showRetryButton: false,
            );
          }

          /// Application Key Authentication
          if (applicationKeyState is KeyNotRegisteredState || 
              applicationKeyState is RegisterNewKeyState) {
            return BlocConsumer<AuthenticationBloc, AuthenticationState>(
              bloc: widget._authenticationBloc,
              listener: (context, state) {
                switch (state.status) {
                  case AuthenticationStatus.authenticated:
                    widget._applicationKeyCubit.successfullyRegisteredKey();
                    break;
                  case AuthenticationStatus.unauthenticated:
                  case AuthenticationStatus.offline:
                  case AuthenticationStatus.unknown:
                    break;
                }
              },
              builder: (context, state) {
                return widget._keyAuthenticationScreen;
              },
            );
          }

          if (applicationKeyState is KeyAlreadyRegisteredState) {
            return FeedbackScreen(
              navigatorService: widget._navigatorService,
              feedbackType: FeedbackTypeEnum.success,
              title: CollectorLocalizations.of(context).keyAlreadyRegistered,
              subtitle: CollectorLocalizations.of(context)
                  .keyAlreadyRegisteredDescription,
              buttons: [
                SeniorButton(
                  label: CollectorLocalizations.of(context)
                      .keyAlreadyRegisteredRemove,
                  style: const SeniorButtonStyle(
                    backgroundColor: SeniorColors.pureWhite,
                    outlinedContentColor: SeniorColors.manchesterColorRed400,
                    borderColor: SeniorColors.manchesterColorRed400,
                  ),
                  outlined: true,
                  fullWidth: true,
                  onPressed: widget._applicationKeyCubit.removeKeys,
                ),
                SeniorButton(
                  label: CollectorLocalizations.of(context)
                      .registerNewkey,
                  style: const SeniorButtonStyle(
                    backgroundColor: SeniorColors.manchesterColorGreen,
                    outlinedContentColor: SeniorColors.manchesterColorGreen,
                    borderColor: SeniorColors.pureWhite,
                  ),
                  outlined: true,
                  fullWidth: true,
                  onPressed: widget._applicationKeyCubit.registerNewKey,
                ),
              ],
            );
          }

          if (applicationKeyState is KeyRegisteredSuccessfullyState) {
            SeniorAuthentication.enableLoginWithKey = true;
            return FeedbackScreen(
              canPop: false,
              navigatorService: widget._navigatorService,
              feedbackType: FeedbackTypeEnum.success,
              title:
                  CollectorLocalizations.of(context).keyRegisteredSuccessfully,
              subtitle: CollectorLocalizations.of(context)
                  .keyRegisteredSuccessfullyDescription,
              onPressedClose: navigateToMultiplo,
              buttons: [
                SeniorButton(
                  label: CollectorLocalizations.of(context)
                      .keyRegisteredSuccessfullyBackHome,
                  style: const SeniorButtonStyle(
                    backgroundColor: SeniorColors.primaryColor600,
                  ),
                  onPressed: () => navigateToMultiplo.call(),
                ),
              ],
            );
          }

          return Scaffold(
            backgroundColor:
                isDark ? SeniorColors.grayscale90 : SeniorColors.pureWhite,
            body: LoadingWidget(
              bottomLabel: loadingMessageByState(applicationKeyState),
            ),
          );
        },
      ),
    );
  }
}
