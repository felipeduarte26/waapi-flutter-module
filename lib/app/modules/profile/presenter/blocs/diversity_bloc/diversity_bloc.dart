import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_diversity_usecase.dart';
import 'diversity_event.dart';
import 'diversity_state.dart';

class DiversityBloc extends Bloc<DiversityEvent, DiversityState> {
  final GetDiversityUsecase _getDiversitysUsecase;

  DiversityBloc({
    required GetDiversityUsecase getDiversitysUsecase,
  })  : _getDiversitysUsecase = getDiversitysUsecase,
        super(const InitialDiversityState()) {
    on<GetDiversityEvent>(_getDiversityEvent);
  }

  Future<void> _getDiversityEvent(
    GetDiversityEvent event,
    Emitter<DiversityState> emit,
  ) async {
    emit(state.loadingDiversityState());

    final diversity = await _getDiversitysUsecase.call(
      personId: event.personId,
    );

    diversity.fold(
      (left) {
        emit(
          state.errorDiversityState(),
        );
      },
      (right) {
        if (right == null) {
          emit(state.emptyStateDiversityState());
        } else {
          emit(
            state.loadedDiversityState(
              diversity: right,
            ),
          );
        }
      },
    );
  }
}
