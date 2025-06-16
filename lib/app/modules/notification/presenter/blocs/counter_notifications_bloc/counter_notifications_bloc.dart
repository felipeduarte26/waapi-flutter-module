import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_number_unread_notifications_usecase.dart';
import 'counter_notifications_event.dart';
import 'counter_notifications_state.dart';

class CounterNotificationsBloc extends Bloc<CounterNotificationsEvent, CounterNotificationsState> {
  final GetNumberUnreadNotificationsUsecase _getNumberUnreadNotificationsUsecase;

  CounterNotificationsBloc({
    required GetNumberUnreadNotificationsUsecase getNumberUnreadNotificationsUsecase,
  })  : _getNumberUnreadNotificationsUsecase = getNumberUnreadNotificationsUsecase,
        super(InitialCounterNotificationsState()) {
    on<GetCounterNotificationsEvent>(_getCounterNotificationsEvent);
  }

  Future<void> _getCounterNotificationsEvent(
    GetCounterNotificationsEvent _,
    Emitter<CounterNotificationsState> emit,
  ) async {
    emit(LoadingCounterNotificationsState());

    final numberUnreadNotifications = await _getNumberUnreadNotificationsUsecase.call();

    numberUnreadNotifications.fold(
      (left) {
        emit(ErrorCounterNotificationsState());
      },
      (right) {
        emit(
          SucceedCounterNotificationsState(
            numberUnreadNotifications: right,
          ),
        );
      },
    );
  }
}
