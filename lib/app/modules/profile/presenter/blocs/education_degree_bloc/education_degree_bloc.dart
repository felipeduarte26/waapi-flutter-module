import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_education_degree_usecase.dart';
import 'education_degree_event.dart';
import 'education_degree_state.dart';

class EducationDegreeBloc extends Bloc<EducationDegreeEvent, EducationDegreeState> {
  final GetEducationDegreeUsecase _getEducationDegreeUsecase;

  EducationDegreeBloc({
    required GetEducationDegreeUsecase getEducationDegreeUsecase,
  })  : _getEducationDegreeUsecase = getEducationDegreeUsecase,
        super(const InitialEducationDegreeState()) {
    on<GetEducationDegreeProfileEvent>(_getEducationDegree);
    on<ClearEducationDegreeProfileEvent>(_clearEducationDegreeProfileEvent);
    on<SelectEducationDegreeFromEntityToProfileEvent>(_selectEducationDegreeFromEntity);
  }

  Future<void> _clearEducationDegreeProfileEvent(
    ClearEducationDegreeProfileEvent _,
    Emitter<EducationDegreeState> emit,
  ) async {
    emit(state.initialEducationDegreeState());
  }

  Future<void> _getEducationDegree(
    GetEducationDegreeProfileEvent _,
    Emitter<EducationDegreeState> emit,
  ) async {
    emit(state.loadingEducationDegreeState());

    final educationDegreeList = await _getEducationDegreeUsecase.call();

    educationDegreeList.fold(
      (left) {
        emit(
          state.errorEducationDegreeState(
            message: left.message,
          ),
        );
      },
      (right) {
        if (right.isEmpty) {
          emit(state.emptyStateEducationDegreeState());
        } else {
          emit(
            state.loadedEducationDegreeState(
              educationDegreeList: right,
            ),
          );
        }
      },
    );
  }

  Future<void> _selectEducationDegreeFromEntity(
    SelectEducationDegreeFromEntityToProfileEvent event,
    Emitter<EducationDegreeState> emit,
  ) async {
    emit(
      state.loadedSelectEducationDegreeState(
        educationDegreeEntity: event.educationDegreeEntity,
      ),
    );
  }
}
