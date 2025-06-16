import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/constants/assets_path.dart';
import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/helper/date_time_helper.dart';
import '../../../../../core/helper/locale_helper.dart';
import '../../../../../core/helper/scroll_helper.dart';
import '../../../../../core/pagination/pagination_requirements.dart';
import '../../../../../core/theme/waapi_style_theme.dart';
import '../../../../../core/widgets/empty_state_widget.dart';
import '../../../../../core/widgets/error_state_widget.dart';
import '../../../../../core/widgets/waapi_colorful_header.dart';
import '../../../../../core/widgets/waapi_loading_widget.dart';
import '../../../../../routes/moods_routes.dart';
import '../../../../../routes/routes.dart';
import '../../../../moods/presenter/blocs/moods_bloc/moods_state.dart';
import '../../../enums/notification_type_enum.dart';
import '../../blocs/list_notifications_bloc/list_notifications_bloc.dart';
import '../../blocs/list_notifications_bloc/list_notifications_event.dart';
import '../../blocs/list_notifications_bloc/list_notifications_state.dart';
import '../../blocs/mark_notification_as_read_bloc/mark_notification_as_read_bloc.dart';
import '../../blocs/mark_notification_as_read_bloc/mark_notification_as_read_event.dart';
import '../../blocs/mark_notification_as_read_bloc/mark_notification_as_read_state.dart';
import 'bloc/list_notifications_screen_bloc.dart';
import 'widgets/notifications_actions_widget.dart';

class ListNotificationsScreen extends StatefulWidget {
  final ListNotificationsScreenBloc listNotificationsScreenBloc;
  final String? employeeId;
  final bool isWaapiLite;
  final bool isWaapiLiteProfile;

  const ListNotificationsScreen({
    Key? key,
    required this.listNotificationsScreenBloc,
    this.employeeId,
    required this.isWaapiLite,
    required this.isWaapiLiteProfile,
  }) : super(key: key);

  @override
  State<ListNotificationsScreen> createState() {
    return _ListNotificationsScreenState();
  }
}

class _ListNotificationsScreenState extends State<ListNotificationsScreen> {
  late ScrollController _scrollController;
  var _nextPage = 1;
  var selectedNotificationIndex = 0;
  var requestUpdateCounter = false;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    _getListRecentNotificationsEvent();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (_, __) async => Modular.to.pop(requestUpdateCounter),
      child: Scaffold(
        body: WaapiColorfulHeader(
          key: const Key('notifications-list_notifications_screen'),
          hasTopPadding: false,
          titleLabel: context.translate.titleNotifications,
          onTapBack: () => Modular.to.pop(requestUpdateCounter),
          actions: [
            NotificationsActionsWidget(
              key: const Key('notifications-notifications_actions-actions'),
              isWaapiLite: widget.isWaapiLite,
            ),
          ],
          body: BlocConsumer<ListNotificationsBloc, ListNotificationsState>(
            bloc: widget.listNotificationsScreenBloc.listNotificationsBloc,
            listener: (_, state) {
              if (state is LoadedListNotificationsState) {
                _nextPage++;
              }

              if (state is ReloadListNotificationsState) {
                _nextPage = 1;
                widget.listNotificationsScreenBloc.listNotificationsBloc.add(
                  GetListRecentNotificationsEvent(
                    paginationRequirements: PaginationRequirements(
                      page: _nextPage,
                    ),
                  ),
                );
              }

              if (state is ErrorMoreListNotificationsState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SeniorSnackBar.error(
                    key: const Key('notifications-show_snack_bar-error-get_list_recent_notifications'),
                    message: context.translate.notificationErrorNextPage,
                    action: SeniorSnackBarAction(
                      label: context.translate.repeat,
                      onPressed: _getListRecentNotificationsEvent,
                    ),
                  ),
                );
              }

              if (state is ErrorClearListNotificationsState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SeniorSnackBar.error(
                    key: const Key('notifications-show_snack_bar-error-clear_all_user_notifications'),
                    message: context.translate.notificationErrorClearNotifications,
                    action: SeniorSnackBarAction(
                      label: context.translate.repeat,
                      onPressed: _showDialogClearNotifications,
                    ),
                  ),
                );
              }
            },
            builder: (_, state) {
              if (state is LoadingListNotificationsState) {
                return const WaapiLoadingWidget(
                  key: Key('notifications-list_notifications-request_list_notifications-loading_state_screen'),
                );
              }

              if (state is ErrorListNotificationsState) {
                return ErrorStateWidget(
                  key: const Key('notifications-list_notifications-request_list_notifications-error_state_screen'),
                  imagePath: AssetsPath.generalErrorState,
                  title: context.translate.notificationErrorState,
                  subTitle: context.translate.notificationErrorStateDescription,
                  onTapTryAgain: _getListRecentNotificationsEvent,
                );
              }

              if (state is EmptyListNotificationsState) {
                return EmptyStateWidget(
                  key: const Key('notifications-list_notifications-request_list_notifications-empty_state_screen'),
                  title: context.translate.notificationNotReceivedTitle,
                  subTitle: context.translate.notificationNotReceivedDescription,
                  imagePath: AssetsPath.generalEmptyState,
                );
              }

              final excludedNotifications = [
                NotificationTypeEnum.hcmFeedbackReceived,
                NotificationTypeEnum.hcmFeedbackRequested,
                NotificationTypeEnum.hcmVacationRequestApproved,
                NotificationTypeEnum.hcmVacationRequestReturned,
                NotificationTypeEnum.hcmVacationRequestRejected,
              ];

              final loadedNotifications = state.notifications;

              if (widget.isWaapiLite) {
                loadedNotifications
                    .retainWhere((notification) => !excludedNotifications.contains(notification.notificationType));
              }

              final notifications = loadedNotifications.map(
                (notification) {
                  return SeniorNotification(
                    title: notification.title,
                    body: notification.content,
                    footer: DateTimeHelper.formatWithDefaultDateTimePattern(
                      dateTime: notification.createdDate,
                      locale: LocaleHelper.languageAndCountryCode(
                        locale: Localizations.localeOf(context),
                      ),
                      adjustTimeZone: true,
                    ),
                    isRead: notification.hasRead,
                  );
                },
              ).toList();

              return BlocConsumer<MarkNotificationAsReadBloc, MarkNotificationAsReadState>(
                bloc: widget.listNotificationsScreenBloc.markNotificationAsReadBloc,
                listener: (_, markAsReadState) {
                  if (markAsReadState is ErrorMarkNotificationAsReadState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SeniorSnackBar.error(
                        key: const Key('notifications-show_snack_bar-error-mark-notification-as-read'),
                        message: context.translate.errorMarkNotificationAsRead,
                        action: SeniorSnackBarAction(
                          label: context.translate.repeat,
                          onPressed: _onNotificationTap,
                        ),
                      ),
                    );
                  }

                  if (markAsReadState is SucceedMarkNotificationAsReadState) {
                    widget.listNotificationsScreenBloc.listNotificationsBloc.add(
                      ChangeNotificationToReadScreenEvent(
                        notificationIndex: selectedNotificationIndex,
                      ),
                    );
                    _onSucceedMarkNotificationAsReadState();
                  }
                },
                builder: (context, markAsReadState) {
                  return Column(
                    children: [
                      Expanded(
                        child: SeniorNotificationList(
                          key: const Key('notifications-list_notifications-request_list_notifications'),
                          title: context.translate.latestNotifications,
                          notifications: notifications,
                          onNotificationTap: (notificationIndex) {
                            if (markAsReadState is LoadingMarkNotificationAsReadState) {
                              return;
                            }
                            setState(() {
                              selectedNotificationIndex = notificationIndex;
                            });
                            _onNotificationTap();
                          },
                          onLoad: _getListRecentNotificationsEvent,
                          isLoading: state is LoadingMoreListNotificationsState,
                          scrollController: _scrollController,
                          disabledActionButton:
                              state is LoadingMoreListNotificationsState || state is ClearingListNotificationsState,
                          busyActionButton: state is ClearingListNotificationsState,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(
                          SeniorSpacing.normal,
                        ),
                        child: SeniorButton(
                          label: context.translate.clearNotifications,
                          onPressed: _showDialogClearNotifications,
                          outlined: true,
                          fullWidth: true,
                          style: WaapiStyleTheme.waapiSeniorButtonGhostOutlinedStyle(context),
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

  void _clearAllUserNotificationsEvent() {
    requestUpdateCounter = true;
    widget.listNotificationsScreenBloc.listNotificationsBloc.add(ClearAllUserNotificationsEvent());
  }

  void _getListRecentNotificationsEvent() {
    widget.listNotificationsScreenBloc.listNotificationsBloc.add(
      GetListRecentNotificationsEvent(
        paginationRequirements: PaginationRequirements(
          page: _nextPage,
        ),
      ),
    );
  }

  void _onNotificationTap() {
    final notificationSelected =
        widget.listNotificationsScreenBloc.listNotificationsBloc.state.notifications[selectedNotificationIndex];

    widget.listNotificationsScreenBloc.markNotificationAsReadBloc.add(
      SendMarkNotificationAsReadEvent(
        notificationId: notificationSelected.id,
        isAlreadyRead: notificationSelected.hasRead,
      ),
    );
  }

  Future<void> _onSucceedMarkNotificationAsReadState() async {
    requestUpdateCounter = true;

    final notificationSelected =
        widget.listNotificationsScreenBloc.listNotificationsBloc.state.notifications[selectedNotificationIndex];

    if (notificationSelected.notificationType == NotificationTypeEnum.hcmFeedbackReceived) {
      Modular.to.pushNamed(
        FeedbackRoutes.toFeedbacksDetailsReceivedScreenRoute,
        arguments: {
          'receivedFeedbackId': notificationSelected.notificationParameters.id,
        },
      );
    } else if (notificationSelected.notificationType == NotificationTypeEnum.hcmFeedbackRequested) {
      Modular.to.pushNamed(
        FeedbackRoutes.detailsRequestFeedbackScreenInitialRoute,
        arguments: {
          'feedbackRequestId': notificationSelected.notificationParameters.id,
          'isRequestedByMe': false,
        },
      );
    } else if (notificationSelected.notificationType == NotificationTypeEnum.hcmPersonalDataUpdate ||
        notificationSelected.notificationType == NotificationTypeEnum.hcmPersonalContactsUpdate) {
      if (!widget.isWaapiLiteProfile) {
        Modular.to.pushNamed(
          ProfileRoutes.profileScreenInitialRoute,
          arguments: {
            'isWaapiLiteProfile': false,
            'isOffline': false,
            'counterUnreadNotifications': 0,
            'employeeId': null,
            'showSearchPerson': false,
          },
        );
      } else {
        Modular.to.pop();
      }
    } else if (notificationSelected.notificationType == NotificationTypeEnum.hcmPersonalDocumentsUpdate) {
      Modular.to.pushNamed(ProfileRoutes.profilePersonalDocumentsInitialRoute);
    } else if (notificationSelected.notificationType == NotificationTypeEnum.hcmPersonalAddressUpdate) {
      Modular.to.pushNamed(ProfileRoutes.personalAddressScreenRouteInitialRoute);
    } else if ((notificationSelected.notificationType == NotificationTypeEnum.hcmVacationRequestApproved ||
            notificationSelected.notificationType == NotificationTypeEnum.hcmVacationRequestRejected ||
            notificationSelected.notificationType == NotificationTypeEnum.hcmVacationRequestReturned) &&
        widget.employeeId != null) {
      Modular.to.pushNamed(
        VacationsRoutes.vacationsScreenInitialRoute,
        arguments: {
          'employeeId': widget.employeeId,
        },
      );
    } else if (notificationSelected.notificationType == NotificationTypeEnum.hcmMoodsReceived) {
      var openMoods = '';
      if (widget.listNotificationsScreenBloc.moodsBloc.state is LoadedMoodsState) {
        openMoods = (widget.listNotificationsScreenBloc.moodsBloc.state as LoadedMoodsState).url;
        if (openMoods.isEmpty) {
          Modular.to.pushNamed(MoodsRoutes.moodsScreenInitialRoute);
        } else {
          await launchUrl(Uri.parse(openMoods));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SeniorSnackBar.warning(
            message: context.translate.alertExpiredPulse,
          ),
        );
      }
    }
  }

  void _showDialogClearNotifications() {
    showDialog(
      barrierDismissible: false,
      useRootNavigator: true,
      context: context,
      builder: (_) {
        return BlocConsumer<ListNotificationsBloc, ListNotificationsState>(
          listener: (_, state) {
            if (state is EmptyListNotificationsState || state is ErrorClearListNotificationsState) {
              Modular.to.pop();
            }
          },
          bloc: widget.listNotificationsScreenBloc.listNotificationsBloc,
          builder: (_, state) {
            return SeniorModal(
              title: context.translate.confirmClearNotificationsTitle,
              content: context.translate.confirmClearNotificationsDescription,
              defaultAction: SeniorModalAction(
                label: context.translate.optionCancel,
                action: Modular.to.pop,
                busy: state is ClearingListNotificationsState,
              ),
              otherAction: SeniorModalAction(
                busy: state is ClearingListNotificationsState,
                label: context.translate.clear,
                action: _clearAllUserNotificationsEvent,
                danger: true,
              ),
            );
          },
        );
      },
    );
  }

  void _onScroll() {
    final canLoadMore = ScrollHelper.reachedListEnd(
      scrollController: _scrollController,
    );

    if (canLoadMore) {
      _getListRecentNotificationsEvent();
    }
  }
}
