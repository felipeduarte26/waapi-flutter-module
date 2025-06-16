import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_current_version_usecase.dart';
import 'get_current_version_event.dart';
import 'get_current_version_state.dart';

class GetCurrentVersionBloc extends Bloc<GetCurrentVersionEvent, GetCurrentVersionState> {
  final GetCurrentVersionUsecase _getCurrentVersionUsecase;

  GetCurrentVersionBloc({
    required GetCurrentVersionUsecase getCurrentVersionUsecase,
  })  : _getCurrentVersionUsecase = getCurrentVersionUsecase,
        super(InitialGetCurrentVersionState()) {
    on<RequestGetCurrentVersionEvent>(_requestGetCurrentVersionEvent);
  }

  Future<void> _requestGetCurrentVersionEvent(
    RequestGetCurrentVersionEvent _,
    Emitter<GetCurrentVersionState> emit,
  ) async {
    final responseVersion = await _getCurrentVersionUsecase.call();

    responseVersion.fold(
      (error) {
        emit(
          ErrorGetCurrentVersionState(
            message: error.message,
          ),
        );
      },
      (version) {
        emit(
          LoadedGetCurrentVersionState(
            version: version,
          ),
        );
      },
    );
  }
}
