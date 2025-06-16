import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_system/senior_design_system.dart';

import '../../../core/enums/analytics/analytics_event_enum.dart';
import '../../../core/extension/media_query_extension.dart';
import '../../../core/extension/translate_extension.dart';
import '../../../core/services/analytics/analytics_service.dart';
import '../../../routes/notification_routes.dart';
import '../../active_contract/presenter/blocs/active_contract_bloc/active_contract_bloc.dart';
import '../../active_contract/presenter/blocs/active_contract_bloc/active_contract_state.dart';
import '../../authentication/presenter/blocs/sign_out/sign_out_event.dart';
import '../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../management_panel/presenter/screens/management_panel/widgets/alert_notifications_disabled_widget.dart';
import '../../notification/enums/notification_permission_status_enum.dart';
import '../../notification/presenter/blocs/counter_notifications_bloc/counter_notifications_event.dart';
import '../../notification/presenter/blocs/permission_notification_bloc/permission_notification_event.dart';
import '../../notification/presenter/blocs/permission_notification_bloc/permission_notification_state.dart';
import '../presenter/bloc/home_screen_bloc/home_screen_bloc.dart';

class HomePermissionNotificationController {
  final HomeScreenBloc homeScreenBloc;
  final BuildContext context;

  HomePermissionNotificationController({
    required this.homeScreenBloc,
    required this.context,
  });

  void handlePermissionNotificationState({
    required PermissionNotificationState state,
    required BuildContext context,
  }) {
    if (state is NotDeterminedPermissionNotificationState) {
      showDialogRequestPermission(
        context: context,
      );
    }

    if (state is AuthorizedPermissionNotificationState) {
      homeScreenBloc.permissionNotificationBloc.add(RegisterTokenPermissionNotificationEvent());
    }

    if (state is SavedNativePermissionNotificationState &&
        Modular.get<ActiveContractBloc>().state is LoadedActiveContractState) {
      homeScreenBloc.permissionNotificationBloc.add(RequestPermissionNotificationEvent());
    }

    if (state is DeniedPermissionNotificationState) {
      homeScreenBloc.permissionNotificationBloc.add(ClearTokenPermissionNotificationEvent());
    }

    if (state is ForceRequestPermissionNotificationState) {
      showBottomSheetNotifications(
        context: context,
      );
    }

    if (state is ClearedAndSavedAndSignOutNotificationState) {
      homeScreenBloc.signOutBloc.add(RequestSignOutEvent());
      Modular.get<AnalyticsService>().logEvent(
        analyticsEventEnum: AnalyticsEventEnum.signoutHomePermissionController,
      );
    }

    if (state is ErrorOpenSettingsPermissionNotificationState) {
      Modular.to.pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SeniorSnackBar.error(
          message: context.translate.errorOpenSettings,
        ),
      );
    }

    if (state is ErrorPermissionNotificationState) {
      ScaffoldMessenger.of(context).showSnackBar(
        SeniorSnackBar.error(
          message: context.translate.errorRegisterNotification,
          action: SeniorSnackBarAction(
            label: context.translate.repeat,
            onPressed: () {
              final permissionNotificationBloc = homeScreenBloc.permissionNotificationBloc;
              permissionNotificationBloc.add(RequestPermissionNotificationEvent());
            },
          ),
        ),
      );
    }

    if (state is ErrorFirebaseGetTokenNotificationState) {
      ScaffoldMessenger.of(context).showSnackBar(
        SeniorSnackBar.error(
          message: context.translate.errorGetTokenFirebase,
        ),
      );
    }

    if (state is ErrorOnClearTokenNotificationState) {
      Modular.to.pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SeniorSnackBar.error(
          message: context.translate.settingsLogoutErrorMessage,
        ),
      );
    }
  }

  void showDialogRequestPermission({
    required BuildContext context,
  }) {
    showDialog(
      barrierDismissible: false,
      useRootNavigator: true,
      context: context,
      builder: (context) {
        return SeniorModal(
          title: context.translate.requestNotification,
          content: context.translate.requestNotificationDescription,
          defaultAction: SeniorModalAction(
            label: context.translate.notAllow,
            action: () {
              homeScreenBloc.permissionNotificationBloc.add(
                SaveNativePermissionNotificationEvent(
                  notificationPermissionStatus: NotificationPermissionStatusEnum.denied,
                ),
              );
              Modular.to.pop();
            },
          ),
          otherAction: SeniorModalAction(
            label: context.translate.allow,
            action: () {
              homeScreenBloc.permissionNotificationBloc.add(
                SaveNativePermissionNotificationEvent(
                  notificationPermissionStatus: NotificationPermissionStatusEnum.authorized,
                ),
              );
              Modular.to.pop();
            },
          ),
        );
      },
    );
  }

  void showBottomSheetNotifications({
    required BuildContext context,
  }) {
    SeniorBottomSheet.showBottomSheet(
      context: context,
      height: context.bottomSheetSize,
      content: [
        Expanded(
          child: AlertNotificationsDisabledWidget(
            onOpenSettings: () {
              final permissionNotificationBloc = homeScreenBloc.permissionNotificationBloc;
              permissionNotificationBloc.add(OpenNativeSettingsPermissionNotificationEvent());
            },
          ),
        ),
      ],
      hasCloseButton: false,
    );
  }

  Future<void> setupInteractedMessage(BuildContext context) async {
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _goToNotificationsPage();
    }

    FirebaseMessaging.onMessage.listen(_handleMessageWhenAppIsForeground);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageWhenAppIsBackground);
  }

  void _goToNotificationsPage() async {
    if (homeScreenBloc.activeContractBloc.state is LoadedActiveContractState) {
      final isWaapiLite = (homeScreenBloc.authorizationBloc.state is LoadedAuthorizationState)
          ? (homeScreenBloc.authorizationBloc.state as LoadedAuthorizationState).authorizationEntity.isWaapiLite
          : false;
      final String employeeId =
          (homeScreenBloc.activeContractBloc.state as LoadedActiveContractState).activeContractEntity.employeeId;
      final updateCounter = await Modular.to.pushNamed(
        NotificationRoutes.notificationScreenInitialRoute,
        arguments: {
          'employeeId': employeeId,
          'isWaapiLite': isWaapiLite,
          'isWaapiLiteProfile': false,
        },
      ) as bool?;
      if (updateCounter != null && updateCounter) {
        homeScreenBloc.counterNotificationsBloc.add(GetCounterNotificationsEvent());
      }
    }
  }

  void _handleMessageWhenAppIsForeground(RemoteMessage message) {
    final String title = message.notification!.title!;
    final String body = message.notification!.body!;

    homeScreenBloc.counterNotificationsBloc.add(GetCounterNotificationsEvent());

    if (context.mounted) {
      showTopSnackBar(
        context: context,
        child: SeniorNotificationSnackbar(
          title: title,
          message: body,
          seniorNotificationSnackBarAction: SeniorNotificationSnackBarAction(
            title: context.translate.view,
            onPressed: _goToNotificationsPage,
          ),
        ),
      );
    }
  }

  void _handleMessageWhenAppIsBackground(RemoteMessage _) {
    homeScreenBloc.counterNotificationsBloc.add(GetCounterNotificationsEvent());
    _goToNotificationsPage();
  }

  void updateCounterNotifications() {
    homeScreenBloc.counterNotificationsBloc.add(GetCounterNotificationsEvent());
  }
}
