import 'package:flutter_bloc/flutter_bloc.dart';

import 'connectivity_event.dart';
import 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  ConnectivityBloc() : super(InitialConnectivityState()) {
    on<SetOnlineConnectivityEvent>(_setOnlineConnectivityEvent);
    on<SetOfflineConnectivityEvent>(_setOfflineConnectivityEvent);
  }

  Future<void> _setOnlineConnectivityEvent(
    SetOnlineConnectivityEvent _,
    Emitter<ConnectivityState> emit,
  ) async {
    emit(OnlineConnectivityState());
  }

  Future<void> _setOfflineConnectivityEvent(
    SetOfflineConnectivityEvent _,
    Emitter<ConnectivityState> emit,
  ) async {
    emit(OfflineConnectivityState());
  }
}
