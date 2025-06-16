import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../core/constants/assets_path.dart';
import '../../../../../core/enums/analytics/waapi_loading_size_enum.dart';
import '../../../../../core/extension/media_query_extension.dart';
import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/widgets/error_state_widget.dart';
import '../../../../../core/widgets/waapi_colorful_header.dart';
import '../../../../../core/widgets/waapi_loading_widget.dart';
import '../../../enums/notification_type_enum.dart';
import '../../blocs/notification_settings_bloc/notification_settings_event.dart';
import '../../blocs/notification_settings_bloc/notification_settings_state.dart';
import '../../blocs/permission_notification_bloc/permission_notification_state.dart';
import 'bloc/notification_settings_screen_bloc.dart';
import 'bloc/notification_settings_screen_state.dart';
import 'widgets/disabled_push_notifications_card_widget.dart';

class NotificationSettingsScreen extends StatefulWidget {
  final bool isWaapiLite;

  const NotificationSettingsScreen({
    Key? key,
    required this.isWaapiLite,
  }) : super(key: key);

  @override
  State<NotificationSettingsScreen> createState() {
    return _NotificationSettingsScreenState();
  }
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  late NotificationSettingsScreenBloc _notificationSettingsScreenBloc;

  @override
  void initState() {
    super.initState();
    _notificationSettingsScreenBloc = Modular.get<NotificationSettingsScreenBloc>();
    _notificationSettingsScreenBloc.notificationSettingsBloc.add(GetNotificationSettingsEvent());
  }

  @override
  Widget build(_) {
    return BlocConsumer<NotificationSettingsScreenBloc, NotificationSettingsScreenState>(
      bloc: _notificationSettingsScreenBloc,
      listener: (context, state) {
        final notificationSettingsState = state.notificationSettingsState;

        if (notificationSettingsState is ErrorOnTogglingNotificationSettingsState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SeniorSnackBar.error(
              message: context.translate.errorOnTogglingSettingNotification,
              action: SeniorSnackBarAction(
                label: context.translate.repeat,
                onPressed: () => _notificationSettingsScreenBloc.notificationSettingsBloc.add(
                  ToggleNotificationSettingsEvent(
                    userNotificationSettingEntity: notificationSettingsState.userNotificationSettingEntity,
                  ),
                ),
              ),
            ),
          );
        }

        if (notificationSettingsState is ToggledNotificationSettingsState) {
          final isEnabledNotification = !notificationSettingsState.userNotificationSettingEntity.notificationEnabled;
          final notificationType = notificationSettingsState.userNotificationSettingEntity.notificationType;

          String message;

          message = isEnabledNotification
              ? context.translate.enableNotificationMessage(_getNotificationName(notificationType: notificationType))
              : context.translate.disableNotificationMessage(_getNotificationName(notificationType: notificationType));

          ScaffoldMessenger.of(context).showSnackBar(
            SeniorSnackBar.success(
              message: message,
            ),
          );
        }
      },
      builder: (_, state) {
        final notificationSettingsState = state.notificationSettingsState;

        return PopScope(
          canPop: notificationSettingsState is! LoadingNotificationSettingsState &&
              notificationSettingsState is! TogglingNotificationSettingsState,
          child: Scaffold(
            body: WaapiColorfulHeader(
              hasTopPadding: false,
              titleLabel: context.translate.configPushNotifications,
              onTapBack: () {
                if (notificationSettingsState is! LoadingNotificationSettingsState &&
                    notificationSettingsState is! TogglingNotificationSettingsState) {
                  Modular.to.pop();
                }
              },
              body: Builder(
                builder: (context) {
                  if (notificationSettingsState is LoadingNotificationSettingsState ||
                      notificationSettingsState is InitialNotificationSettingsState) {
                    return Container(
                      padding: const EdgeInsets.only(
                        top: SeniorSpacing.normal,
                      ),
                      alignment: Alignment.topCenter,
                      child: const WaapiLoadingWidget(
                        key: Key('notification-notification_settings_screen-loading_indicator'),
                      ),
                    );
                  }

                  if (notificationSettingsState is ErrorNotificationSettingsState) {
                    return ErrorStateWidget(
                      key: const Key('notification-notification_settings_screen-error_state_screen'),
                      imagePath: AssetsPath.generalErrorState,
                      title: context.translate.genericErrorAndTryAgain,
                      onTapTryAgain: () =>
                          _notificationSettingsScreenBloc.notificationSettingsBloc.add(GetNotificationSettingsEvent()),
                    );
                  }

                  var userNotificationSettings = notificationSettingsState.userNotificationSettings;
                  if (widget.isWaapiLite) {
                    final excludedNotifications = [
                      NotificationTypeEnum.hcmFeedbackReceived,
                      NotificationTypeEnum.hcmFeedbackRequested,
                      NotificationTypeEnum.hcmVacationRequestApproved,
                      NotificationTypeEnum.hcmVacationRequestReturned,
                      NotificationTypeEnum.hcmVacationRequestRejected,
                    ];
                    userNotificationSettings
                        .retainWhere((type) => !excludedNotifications.contains(type.notificationType));
                  }

                  final isNotificationDisabled =
                      state.permissionNotificationState is ForceRequestPermissionNotificationState ||
                          state.permissionNotificationState is ClearedTokenPermissionNotificationState;

                  return SizedBox(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DisabledPushNotificationsCardWidget(
                          visible: isNotificationDisabled,
                        ),
                        Expanded(
                          child: Scrollbar(
                            child: ListView.separated(
                              padding: const EdgeInsets.only(
                                top: SeniorSpacing.normal,
                              ),
                              key: const Key('notification-notification_settings_screen-list_settings'),
                              itemCount: userNotificationSettings.length + 1,
                              separatorBuilder: (_, __) {
                                return const SizedBox(
                                  height: SeniorSpacing.xsmall,
                                );
                              },
                              itemBuilder: (_, index) {
                                if (userNotificationSettings.length == index) {
                                  return SizedBox(
                                    height: context.bottomSize,
                                  );
                                }

                                final userNotificationSetting = userNotificationSettings[index];

                                final isToggling = notificationSettingsState is TogglingNotificationSettingsState &&
                                    notificationSettingsState.userNotificationSettingEntity.id ==
                                        userNotificationSetting.id;

                                return ListTile(
                                  key: Key('notification-notification_settings_screen-list_settings-item-$index'),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: SeniorSpacing.normal,
                                  ),
                                  title: SeniorText.bodyBold(
                                    _getNotificationName(
                                      notificationType: userNotificationSetting.notificationType,
                                    ),
                                    key: Key(
                                      'notification-notification_settings_screen-list_settings-item-$index-title',
                                    ),
                                    darkColor:
                                        Provider.of<ThemeRepository>(context).theme.textTheme!.bodyBoldStyle!.color,
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(
                                      top: SeniorSpacing.xxsmall,
                                    ),
                                    child: SeniorText.body(
                                      _getNotificationDescription(
                                        notificationType: userNotificationSetting.notificationType,
                                      ),
                                      key: Key(
                                        'notification-notification_settings_screen-list_settings-item-$index-description',
                                      ),
                                      darkColor:
                                          Provider.of<ThemeRepository>(context).theme.textTheme!.bodyStyle!.color,
                                    ),
                                  ),
                                  trailing: Container(
                                    margin: const EdgeInsets.only(
                                      top: SeniorSpacing.small,
                                    ),
                                    child: isToggling
                                        ? const SizedBox(
                                            height: SeniorSpacing.xbig,
                                            width: SeniorSpacing.xbig,
                                            child: WaapiLoadingWidget(
                                              waapiLoadingSizeEnum: WaapiLoadingSizeEnum.small,
                                            ),
                                          )
                                        : SizedBox(
                                            height: SeniorSpacing.medium,
                                            width: SeniorSpacing.xbig,
                                            child: Center(
                                              child: SeniorSwitch(
                                                key: Key(
                                                  'notification-notification_settings_screen-list_settings-item-$index-toggle',
                                                ),
                                                disabled:
                                                    notificationSettingsState is TogglingNotificationSettingsState ||
                                                        isNotificationDisabled,
                                                value: userNotificationSetting.notificationEnabled,
                                                onChanged: (_) =>
                                                    _notificationSettingsScreenBloc.notificationSettingsBloc.add(
                                                  ToggleNotificationSettingsEvent(
                                                    userNotificationSettingEntity: userNotificationSetting,
                                                  ),
                                                ),
                                                titlePosition: SeniorSwitchTitlePosition.right,
                                              ),
                                            ),
                                          ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  String _getNotificationName({
    required NotificationTypeEnum notificationType,
  }) {
    switch (notificationType) {
      case NotificationTypeEnum.hcmFeedbackReceived:
        return context.translate.feedbackReceived;
      case NotificationTypeEnum.hcmFeedbackRequested:
        return context.translate.feedbackRequest;
      case NotificationTypeEnum.hcmPersonalDataUpdate:
        return context.translate.personalDataUpdateNotificationTitle;
      case NotificationTypeEnum.hcmPersonalContactsUpdate:
        return context.translate.contactsUpdateNotificationTitle;
      case NotificationTypeEnum.hcmPersonalAddressUpdate:
        return context.translate.addressUpdateNotificationTitle;
      case NotificationTypeEnum.hcmPersonalDocumentsUpdate:
        return context.translate.documentsUpdateNotificationTitle;
      case NotificationTypeEnum.hcmVacationRequestApproved:
        return context.translate.vacationRequestApprovedNotificationTitle;
      case NotificationTypeEnum.hcmVacationRequestReturned:
        return context.translate.vacationRequestReturnedNotificationTitle;
      case NotificationTypeEnum.hcmVacationRequestRejected:
        return context.translate.vacationRequestRejectedNotificationTitle;
      case NotificationTypeEnum.hcmPontoReceived:
        return context.translate.timeControlReceivedNotificationTitle;
      case NotificationTypeEnum.hcmMoodsReceived:
        return context.translate.moodsPulse;
      case NotificationTypeEnum.hcmVacationRequestExpired:
        return context.translate.vacationRequestExpiredNotificationTitle;
    }
  }

  String _getNotificationDescription({
    required NotificationTypeEnum notificationType,
  }) {
    switch (notificationType) {
      case NotificationTypeEnum.hcmFeedbackReceived:
        return context.translate.feedbackReceivedDescription;
      case NotificationTypeEnum.hcmFeedbackRequested:
        return context.translate.feedbackRequestedDescription;
      case NotificationTypeEnum.hcmPersonalDataUpdate:
        return context.translate.personalDataUpdateNotificationDescription;
      case NotificationTypeEnum.hcmPersonalContactsUpdate:
        return context.translate.contactsUpdateNotificationDescription;
      case NotificationTypeEnum.hcmPersonalAddressUpdate:
        return context.translate.addressUpdateNotificationDescription;
      case NotificationTypeEnum.hcmPersonalDocumentsUpdate:
        return context.translate.documentsUpdateNotificationDescription;
      case NotificationTypeEnum.hcmVacationRequestApproved:
        return context.translate.vacationRequestApprovedNotificationDescription;
      case NotificationTypeEnum.hcmVacationRequestReturned:
        return context.translate.vacationRequestReturnedNotificationDescription;
      case NotificationTypeEnum.hcmVacationRequestRejected:
        return context.translate.vacationRequestRejectedNotificationDescription;
      case NotificationTypeEnum.hcmPontoReceived:
        return context.translate.timeControlReceivedNotificationDescription;
      case NotificationTypeEnum.hcmMoodsReceived:
        return context.translate.moodsNotificationDescription;
      case NotificationTypeEnum.hcmVacationRequestExpired:
        return context.translate.vacationRequestExpiredNotificationDescription;
    }
  }
}
