import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/notification_entity.dart';
import '../../../domain/usecases/clear_all_user_notifications_usecase.dart';
import '../../../domain/usecases/get_list_recent_notifications_usecase.dart';
import 'list_notifications_event.dart';
import 'list_notifications_state.dart';

class ListNotificationsBloc extends Bloc<ListNotificationsEvent, ListNotificationsState> {
  final ClearAllUserNotificationsUsecase _clearAllUserNotificationsUsecase;
  final GetListRecentNotificationsUseCase _getListRecentNotificationsUseCase;

  ListNotificationsBloc({
    required ClearAllUserNotificationsUsecase clearAllUserNotificationsUsecase,
    required GetListRecentNotificationsUseCase getListRecentNotificationsUseCase,
  })  : _clearAllUserNotificationsUsecase = clearAllUserNotificationsUsecase,
        _getListRecentNotificationsUseCase = getListRecentNotificationsUseCase,
        super(
          InitialListNotificationsState(),
        ) {
    on<GetListRecentNotificationsEvent>(_getListRecentNotificationsEvent);

    on<ClearAllUserNotificationsEvent>(_clearAllUserNotificationsEvent);

    on<ChangeNotificationToReadScreenEvent>(_changeNotificationToReadEvent);

    on<ReloadListNotificationsEvent>(_reloadListNotificationsEvent);
  }

  Future<void> _reloadListNotificationsEvent(
    ReloadListNotificationsEvent _,
    Emitter<ListNotificationsState> emit,
  ) async {
    emit(ReloadListNotificationsState());
  }

  Future<void> _clearAllUserNotificationsEvent(
    ClearAllUserNotificationsEvent _,
    Emitter<ListNotificationsState> emit,
  ) async {
    emit(
      state.clearingListNotificationsState(
        notifications: state.notifications,
      ),
    );

    final hasClearAllUserNotifications = await _clearAllUserNotificationsUsecase.call();

    hasClearAllUserNotifications.fold(
      (left) {
        emit(
          state.errorClearListNotificationsState(
            notifications: state.notifications,
          ),
        );
      },
      (right) {
        emit(
          state.emptyListNotificationsState(),
        );
      },
    );
  }

  Future<void> _getListRecentNotificationsEvent(
    GetListRecentNotificationsEvent event,
    Emitter<ListNotificationsState> emit,
  ) async {
    final bool isAllowedToGetMoreNotifications = (state is! LoadingListNotificationsState &&
        state is! LoadingMoreListNotificationsState &&
        state is! EmptyListNotificationsState &&
        state is! LastPageListNotificationsState);

    if (!isAllowedToGetMoreNotifications) {
      return;
    }

    if (state.notifications.isEmpty) {
      emit(
        state.loadingListNotificationsState(),
      );
    } else {
      emit(
        state.loadingMoreListNotificationsState(
          notifications: state.notifications,
        ),
      );
    }

    final listRecentNotifications = await _getListRecentNotificationsUseCase.call(
      paginationRequirements: event.paginationRequirements,
    );

    listRecentNotifications.fold(
      (left) {
        if (state.notifications.isEmpty) {
          emit(
            state.errorListNotificationsState(),
          );
        } else {
          emit(
            state.errorMoreListNotificationsState(
              notifications: state.notifications,
            ),
          );
        }
      },
      (right) {
        if (right.isEmpty) {
          if (state.notifications.isEmpty) {
            emit(
              state.emptyListNotificationsState(),
            );
          } else {
            emit(
              state.lastPageListNotificationsState(
                notifications: state.notifications,
              ),
            );
          }
        } else {
          emit(
            state.loadedListNotificationsState(
              notifications: state.notifications + right,
            ),
          );
        }
      },
    );
  }

  Future<void> _changeNotificationToReadEvent(
    ChangeNotificationToReadScreenEvent event,
    Emitter<ListNotificationsState> emit,
  ) async {
    var notificationList = state.notifications;
    final notificationSelected = state.notifications[event.notificationIndex];

    notificationList[event.notificationIndex] = NotificationEntity(
      content: notificationSelected.content,
      createdDate: notificationSelected.createdDate,
      hasRead: true,
      id: notificationSelected.id,
      notificationParameters: notificationSelected.notificationParameters,
      notificationType: notificationSelected.notificationType,
      title: notificationSelected.title,
    );

    emit(state.loadingListNotificationsState());

    emit(
      state.loadedListNotificationsState(
        notifications: notificationList,
      ),
    );
  }
}
