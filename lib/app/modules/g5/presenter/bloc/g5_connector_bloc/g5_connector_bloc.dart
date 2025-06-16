import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_g5_connector_usecase.dart';
import 'g5_connector_event.dart';
import 'g5_connector_state.dart';

class G5ConnectorBloc extends Bloc<G5ConnectorEvent, G5ConnectorState> {
  final GetG5ConnectorUsecase _getG5ConnectorUsecase;

  G5ConnectorBloc({
    required GetG5ConnectorUsecase getG5ConnectorUsecase,
  })  : _getG5ConnectorUsecase = getG5ConnectorUsecase,
        super(InitialG5ConnectorState()) {
    on<GetG5ConnectorEvent>(_getG5ConnectorEvent);
  }

  Future<void> _getG5ConnectorEvent(
    GetG5ConnectorEvent _,
    Emitter<G5ConnectorState> emit,
  ) async {
    emit(LoadingG5ConnectorState());

    final connector = await _getG5ConnectorUsecase.call();

    connector.fold(
      (left) {
        emit(
          ErrorG5ConnectorState(),
        );
      },
      (right) {
        emit(
          LoadedG5ConnectorState(
            connector: right,
          ),
        );
      },
    );
  }
}
