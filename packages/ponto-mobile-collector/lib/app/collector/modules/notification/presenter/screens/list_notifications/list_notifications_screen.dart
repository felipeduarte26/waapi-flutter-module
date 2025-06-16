import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../../generated/l10n/collector_localizations.dart';
import '../../../../../core/constants/assets_path.dart';
import '../../../../../core/helper/scroll_helper.dart';
import '../../../../../core/presenter/widgets/loading/loading_widget.dart';
import '../../../../../core/widgets/empty_state_widget.dart';
import '../../../../../core/widgets/error_state_widget.dart';
import '../../blocs/confirm_read_push_message/confirm_read_push_message_bloc.dart';
import '../../blocs/confirm_read_push_message/confirm_read_push_message_event.dart';
import '../../blocs/confirm_read_push_message/confirm_read_push_message_state.dart';
import '../../blocs/list_notifications_bloc/list_notifications_bloc.dart';
import '../../blocs/list_notifications_bloc/list_notifications_event.dart';
import '../../blocs/list_notifications_bloc/list_notifications_state.dart';
import 'bloc/list_notifications_screen_bloc.dart';

class ListNotificationsScreen extends StatefulWidget {
  final ListNotificationsScreenBloc listNotificationsScreenBloc;

  const ListNotificationsScreen({
    super.key,
    required this.listNotificationsScreenBloc,
  });

  @override
  State<ListNotificationsScreen> createState() {
    return _ListNotificationsScreenState();
  }
}

class _ListNotificationsScreenState extends State<ListNotificationsScreen> {
  late ScrollController _scrollController;
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
    final collectorLocalizations = CollectorLocalizations.of(context);
    final localeName = collectorLocalizations.localeName;

    return WillPopScope(
      onWillPop: () async {
        Modular.to.pop(requestUpdateCounter);
        return false;
      },
      child: Scaffold(
        body: SeniorColorfulHeaderStructure(
          hasTopPadding: false,
          title: SeniorText.label(
            color: SeniorColors.pureWhite,
            darkColor: SeniorColors.grayscale5,
            CollectorLocalizations.of(context).titleNotifications,
          ),
          actions: const [],
          body: BlocConsumer<ListNotificationsBloc, ListNotificationsState>(
            bloc: widget.listNotificationsScreenBloc.listNotificationsBloc,
            listener: (_, state) {
              if (state is LoadedListNotificationsState) {}

              if (state is ReloadListNotificationsState) {
                widget.listNotificationsScreenBloc.listNotificationsBloc.add(
                  GetListRecentNotificationsEvent(),
                );
              }

              if (state is ErrorMoreListNotificationsState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SeniorSnackBar.error(
                    message: CollectorLocalizations.of(context)
                        .notificationErrorNextPage,
                    action: SeniorSnackBarAction(
                      label: CollectorLocalizations.of(context).repeat,
                      onPressed: _getListRecentNotificationsEvent,
                    ),
                  ),
                );
              }
            },
            builder: (_, state) {
              if (state is LoadingListNotificationsState) {
                return const LoadingWidget(
                  bottomLabel: '',
                );
              }

              if (state is ErrorListNotificationsState) {
                return ErrorStateWidget(
                  imagePath: AssetsPath.generalErrorState,
                  title:
                      CollectorLocalizations.of(context).notificationErrorState,
                  subTitle: CollectorLocalizations.of(context)
                      .notificationErrorStateDescription,
                  onTapTryAgain: _getListRecentNotificationsEvent,
                );
              }

              if (state is EmptyListNotificationsState) {
                return EmptyStateWidget(
                  title: CollectorLocalizations.of(context)
                      .notificationNotReceivedTitle,
                  subTitle: CollectorLocalizations.of(context)
                      .notificationNotReceivedDescription,
                  imagePath: AssetsPath.generalEmptyState,
                );
              }

              final loadedNotifications = state.notifications;

              final notifications = loadedNotifications.map(
                (notification) {
                  return SeniorNotification(
                    title: notification.title ?? '',
                    body: notification.messageContent ?? '',
                    footer: widget.listNotificationsScreenBloc
                        .formatNotificationDate(
                      notification.createdAt,
                      localeName,
                    ),
                    isRead: notification.read ?? false,
                  );
                },
              ).toList();

              return BlocConsumer<ConfirmReadPushMessageBloc,
                  ConfirmReadPushMessageState>(
                bloc: widget
                    .listNotificationsScreenBloc.confirmReadPushMessageBloc,
                listener: (_, markAsReadState) {
                  if (markAsReadState is ErrorConfirmReadPushMessageState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SeniorSnackBar.error(
                        message: CollectorLocalizations.of(context)
                            .errorMarkNotificationAsRead,
                        action: SeniorSnackBarAction(
                          label: CollectorLocalizations.of(context).repeat,
                          onPressed: _onNotificationTap,
                        ),
                      ),
                    );
                  }

                  if (markAsReadState is SucceedConfirmReadPushMessageState) {
                    widget.listNotificationsScreenBloc.listNotificationsBloc
                        .add(
                      ChangeNotificationToReadScreenEvent(
                        notificationIndex: selectedNotificationIndex,
                      ),
                    );
                  }
                },
                builder: (context, markAsReadState) {
                  return Column(
                    children: [
                      Expanded(
                        child: SeniorNotificationList(
                          title: CollectorLocalizations.of(context)
                              .latestNotifications,
                          notifications: notifications,
                          onNotificationTap: (notificationIndex) {
                            if (markAsReadState
                                is LoadingConfirmReadPushMessageState) {
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
                              state is LoadingMoreListNotificationsState ||
                                  state is ClearingListNotificationsState,
                          busyActionButton:
                              state is ClearingListNotificationsState,
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

  void _getListRecentNotificationsEvent() {
    widget.listNotificationsScreenBloc.listNotificationsBloc.add(
      GetListRecentNotificationsEvent(),
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

  void _onNotificationTap() {
    final notificationSelected = widget.listNotificationsScreenBloc
        .listNotificationsBloc.state.notifications[selectedNotificationIndex];

    widget.listNotificationsScreenBloc.confirmReadPushMessageBloc.add(
      GetConfirmReadPushMessageEventEvent(
        messageId: notificationSelected.id ?? '',
        read: notificationSelected.read ?? false,
      ),
    );
  }
}
