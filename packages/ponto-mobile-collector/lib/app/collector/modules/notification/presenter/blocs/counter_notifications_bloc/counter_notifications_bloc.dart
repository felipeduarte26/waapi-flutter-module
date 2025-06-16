import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/domain/usecases/check_conection_usecase.dart';
import '../../../domain/usecases/get_number_unread_notifications_usecase.dart';
import 'counter_notifications_event.dart';
import 'counter_notifications_state.dart';

class CounterNotificationsBloc
    extends Bloc<CounterNotificationsEvent, CounterNotificationsState> {
  final GetNumberUnreadNotificationsUsecase getNumberUnreadNotificationsUsecase;
  final IHasConnectivityUsecase hasConnectivityUsecase;

  CounterNotificationsBloc({
    required this.getNumberUnreadNotificationsUsecase,
    required this.hasConnectivityUsecase,
  }) : super(InitialCounterNotificationsState()) {
    on<GetCounterNotificationsEvent>(_getCounterNotificationsEvent);

    if (state is InitialCounterNotificationsState) {
      add(GetCounterNotificationsEvent());
    }
  }

  Future<void> _getCounterNotificationsEvent(
    GetCounterNotificationsEvent _,
    Emitter<CounterNotificationsState> emit,
  ) async {
    emit(LoadingCounterNotificationsState());

    final numberUnreadNotifications =
        await getNumberUnreadNotificationsUsecase.call();
    emit(
      SucceedCounterNotificationsState(
        hasUnreadPushMessage: numberUnreadNotifications,
      ),
    );
  }

  Future<bool> hasConnectivity() async {
    return await hasConnectivityUsecase.call();
  }

}
