import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/domain/input_model/employee_dto.dart';
import '../../../../../core/domain/usecases/check_conection_usecase.dart';
import '../../../../../core/types/either.dart';
import '../../../../clocking_event/domain/usecase/get_employee_usecase.dart';
import '../../../domain/entities/push_message_entity.dart';
import '../../../domain/entities/push_notification_dto.dart';
import '../../../domain/failures/notification_failure.dart';
import '../../../domain/usecases/get_list_recent_notifications_usecase.dart';
import 'list_notifications_event.dart';
import 'list_notifications_state.dart';

class ListNotificationsBloc
    extends Bloc<ListNotificationsEvent, ListNotificationsState> {
  final GetListRecentNotificationsUseCase getListRecentNotificationsUseCase;
  final IHasConnectivityUsecase hasConnectivityUsecase;
  final IGetEmployeeUsecase? getEmployeeUsecase;

  ListNotificationsBloc({
    required this.getListRecentNotificationsUseCase,
    required this.hasConnectivityUsecase,
    this.getEmployeeUsecase,
  }) : super(
          InitialListNotificationsState(),
        ) {
    on<GetListRecentNotificationsEvent>(_getListRecentNotificationsEvent);

    on<ChangeNotificationToReadScreenEvent>(_changeNotificationToReadEvent);

    on<ReloadListNotificationsEvent>(_reloadListNotificationsEvent);
  }

  Future<void> _reloadListNotificationsEvent(
    ReloadListNotificationsEvent _,
    Emitter<ListNotificationsState> emit,
  ) async {
    emit(ReloadListNotificationsState());
  }

  Future<void> _getListRecentNotificationsEvent(
    GetListRecentNotificationsEvent event,
    Emitter<ListNotificationsState> emit,
  ) async {
    final bool isAllowedToGetMoreNotifications =
        (state is! LoadingListNotificationsState &&
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

    bool hasConnectivity = await hasConnectivityUsecase.call();
    if (hasConnectivity) {
      EmployeeDto? employeeDto = getEmployeeUsecase?.call();
      if (employeeDto != null) {
        Either<NotificationFailure, PushNotificationDto> callBack =
            await getListRecentNotificationsUseCase.call(
          employeeId: employeeDto.id,
        );

        verify(callBack, emit);
      } else {
        emit(
          state.emptyListNotificationsState(),
        );
        return;
      }
    } else {
      emit(
        state.errorListNotificationsState(),
      );
      return;
    }
  }

  void verify(
    Either<NotificationFailure, PushNotificationDto> callback,
    Emitter<ListNotificationsState> emit,
  ) {
    callback.fold(
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
        if (right.messages.isEmpty) {
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
              notifications: right.messages,
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

    notificationList[event.notificationIndex] = PushMessageEntity(
      title: notificationSelected.title,
      messageContent: notificationSelected.messageContent,
      read: true,
      id: notificationSelected.id,
      createdAt: notificationSelected.createdAt,
    );

    emit(state.loadingListNotificationsState());

    emit(
      state.loadedListNotificationsState(
        notifications: notificationList,
      ),
    );
  }
}
